#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# When running behind a corporate proxy, make sure that /etc/environment is set properly:
# Example:
# HTTP_PROXY=http://<my-proxy>:<proxy-port>
# http_proxy=http://<my-proxy>:<proxy-port>
# NO_PROXY=10.0.0.0/8,192.168.0.0/16,127.0.0.1,172.16.0.0/16
# HTTPS_PROXY=http://<my-proxy>:<proxy-port>
# https_proxy=http://<my-proxy>:<proxy-port>
# no_proxy=10.0.0.0/8,192.168.0.0/16,127.0.0.1,172.16.0.0/16

install-general-dependencies() {
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl
}

install-containerd() {
  cd /tmp
  curl -fsSLo containerd-config.toml https://gist.githubusercontent.com/oradwell/31ef858de3ca43addef68ff971f459c2/raw/5099df007eb717a11825c3890a0517892fa12dbf/containerd-config.toml
  # sudo mkdir /etc/containerd
  sudo mv containerd-config.toml /etc/containerd/config.toml

  # curl -fsSLo containerd-1.6.21-linux-amd64.tar.gz https://github.com/containerd/containerd/releases/download/v1.6.21/containerd-1.6.21-linux-amd64.tar.gz
  # Extract the binaries
  # sudo tar Cxzvf /usr/local containerd-1.6.21-linux-amd64.tar.gz

  # Install containerd as a service
  # sudo curl -fsSLo /etc/systemd/system/containerd.service https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

  # sudo systemctl daemon-reload
  # sudo systemctl enable --now containerdi
  sudo systemctl restart containerd
}

install-runc() {
  cd /tmp
  curl -fsSLo runc.amd64 \
  https://github.com/opencontainers/runc/releases/download/v1.1.7/runc.amd64
  sudo install -m 755 runc.amd64 /usr/local/sbin/runc
}

install-cni-plugins() {
  curl -fsSLo cni-plugins-linux-amd64-v1.2.0.tgz https://github.com/containernetworking/plugins/releases/download/v1.2.0/cni-plugins-linux-amd64-v1.2.0.tgz
  sudo mkdir -p /opt/cni/bin
  sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.2.0.tgz
}

configure-iptables() {
  
  cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
  overlay
  br_netfilter
EOF

  sudo modprobe -a overlay br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
  net.bridge.bridge-nf-call-iptables  = 1
  net.bridge.bridge-nf-call-ip6tables = 1
  net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
}

install-kube() {
  cd /tmp
  # Add Kubernetes GPG key
  sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

  # Add Kubernetes apt repository
  echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

  # Fetch package list
  sudo apt update

  sudo apt install -y kubelet kubeadm kubectl

  # Prevent them from being updated automatically
  sudo apt-mark hold kubelet kubeadm kubectl
}

disable-swap() {
  # See if swap is enabled
  swapon --show

  # Turn off swap
  sudo swapoff -a

  # Disable swap completely
  # sudo sed -i -e '/swap/d' /etc/fstab
}

configure-cluster() {
  cd /tmp
  kubectl="/usr/bin/kubectl"
  # Init cluster
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16
  
  # Congigure current user
  mkdir -p "$HOME"/.kube
  sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
  sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config
  
  # You might need to run these again outside of script
  $kubectl taint nodes --all node-role.kubernetes.io/master-
  $kubectl taint nodes --all node-role.kubernetes.io/control-plane-
  
  # You might need to run these again outside of script
  $kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

  curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
  
  # Add openebs repo to helm
  # helm repo add openebs https://openebs.github.io/charts
  # $kubectl create namespace openebs
  # helm --namespace=openebs install openebs openebs/openebs
  cd "$HOME"
}


install-general-dependencies
install-containerd
install-runc
install-cni-plugins
# configure-iptables
install-kube
disable-swap
configure-cluster
