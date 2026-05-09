# Use an Ubuntu cloud image in Proxmox

## Create a VM template in Proxmox

First thing we need to do is to create a new VM template to use the cloud image with.

In Proxmox node click on Create VM and configure the following settings:

- General:
  <img width="724" height="542" alt="image" src="https://github.com/user-attachments/assets/cc21080c-aafe-4fc9-81e7-bb40693df797" />
- OS:
  <img width="724" height="542" alt="image" src="https://github.com/user-attachments/assets/28b6f1fb-dd87-4ff8-bc56-eda3fc5d41b7" />
- System:
  <img width="724" height="542" alt="image" src="https://github.com/user-attachments/assets/5bec2d6f-c6e0-4e25-8f27-ea025d2f6da5" />
- Disk:
  <img width="724" height="542" alt="image" src="https://github.com/user-attachments/assets/b09d0cd0-c27f-4985-9d13-5b195106bde1" />
- CPU: No changes needed
- Memory:
  <img width="724" height="542" alt="image" src="https://github.com/user-attachments/assets/3905ea90-df03-4b36-9193-7edb12bd7263" />
- Network: No changes needed
- Click **Finish** after you make sure that **Start after creation** is unchecked.
- Go to the **Hardware section of the new VM and remove the CD/DVD Drive
  <img width="839" height="397" alt="image" src="https://github.com/user-attachments/assets/4f8860a1-aa71-4d06-a755-685169d15be8" />
- Add a **CloudInit Drive**:
  <img width="299" height="182" alt="image" src="https://github.com/user-attachments/assets/4d74c627-3f0c-4140-81aa-df4d4b63e15d" />


## Grab the image

First, we need to grab the cloud image from Ubuntu. For 26.04 LTS is this URL: <https://cloud-images.ubuntu.com/resolute/current/>. On that page look for the qcow2 format (usually `.img`) and copy the link.

Log into the Proxmox node and run:

```bash
wget https://cloud-images.ubuntu.com/resolute/current/resolute-server-cloudimg-amd64.img
```

This will download the image into the Proxmox node.

## Prepare the image

The `.img` extension is not actually qcow2 format so we need to rename the file so it has the proper extension.

```bash
mv resolute-server-cloudimg-amd64.img resolute-server-cloudimg-amd64.qcow2
```

Since the minimum storage recommended by Ubuntu for cloud images is 4Gib, we go a little bit over that when we configure the disk size.

```bash
qemu img resize resolute-server-cloudimg-amd64.img 5G
```
