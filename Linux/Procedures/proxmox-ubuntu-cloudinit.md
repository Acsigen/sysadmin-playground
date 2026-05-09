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
qemu-img resize resolute-server-cloudimg-amd64.img 5G
```

## Import the disk

Now we need to import the disk into the VM. Since `local-lvm` holds the VM disks, we will import the image on that storage sintead of `local` where Proxmox usually holds ISO images.

```bash
qm importdisk 9001 resolute-server-cloudimg-amd64.qcow2 local-lvm
```

Let's go back to the Proxmox web interface and go back to the VM. Select Hardware and add a Serial Port. There we should also see an unused disk.

<img width="840" height="378" alt="image" src="https://github.com/user-attachments/assets/7f946335-ba9a-44fb-af84-8e5286e0a71a" />

Click on it, then click Edit and apply the following settings.

<img width="600" height="319" alt="image" src="https://github.com/user-attachments/assets/ab20775e-2ed8-4249-8d2a-6a96dd0d2a57" />

**Activate `SSD emulation` and `Discard` only if your physical disk is an SSD.**

## Make the disk bootable

Now go to **Options** and edit the **Boot Order** to boot from the proper disk

<img width="631" height="261" alt="image" src="https://github.com/user-attachments/assets/10a6b9d4-1b2d-4cca-9155-fcd6d9773b20" />

## Configure CloudInit

Now go to **CloudInit** and configure the parameters according to your needs

<img width="490" height="386" alt="image" src="https://github.com/user-attachments/assets/fdf9bc73-a950-4c01-8abe-e500e4d46cc9" />

## Create a VM template

Once all above steps are done, right click on the VM and click **Convert to template**.

## Create a new VM from the template

Right click on the template and click **Clone**. Configure the parameters and create the VM. Once that is done, if you need to change RAM, CPU and disk, do it from the hardware menu.
