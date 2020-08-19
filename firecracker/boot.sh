#!/usr/bin/env bash
arch=`uname -m`
dest_kernel="hello-vmlinux.bin"
dest_rootfs="hello-rootfs.ext4"
image_bucket_url="https://s3.amazonaws.com/spec.ccfc.min/img"
kernel="${image_bucket_url}/hello/kernel/hello-vmlinux.bin"
rootfs="${image_bucket_url}/hello/fsfiles/hello-rootfs.ext4"

# echo "Downloading $kernel..."
# curl -fsSL -o $dest_kernel $kernel

# echo "Downloading $rootfs..."
# curl -fsSL -o $dest_rootfs $rootfs

# echo "Saved kernel file to $dest_kernel and root block device to $dest_rootfs."

arch=`uname -m`
kernel_path=$(pwd)"/wasmcloud.bin"

curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/boot-source'   \
  -H 'Accept: application/json'           \
  -H 'Content-Type: application/json'     \
  -d "{
        \"kernel_image_path\": \"${kernel_path}\",
        \"boot_args\": \"\"
  }"

#rootfs_path="/home/cadey/tmp/vm/disk.raw"
#rootfs_path=$(pwd)"/wasmcloud.ext4"
rootfs_path=$(pwd)"/idra.ext4"
curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/drives/rootfs' \
  -H 'Accept: application/json'           \
  -H 'Content-Type: application/json'     \
  -d "{
        \"drive_id\": \"rootfs\",
        \"path_on_host\": \"${rootfs_path}\",
        \"is_root_device\": true,
        \"is_read_only\": false
   }"

curl --unix-socket /tmp/firecracker.socket -i  \
  -X PUT 'http://localhost/machine-config' \
  -H 'Accept: application/json'            \
  -H 'Content-Type: application/json'      \
  -d '{
      "vcpu_count": 1,
      "mem_size_mib": 100,
      "ht_enabled": false
  }'

curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/network-interfaces/eth0' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
      "iface_id": "eth0",
      "guest_mac": "AA:FC:00:00:00:01",
      "host_dev_name": "tap0"
    }'

curl --unix-socket /tmp/firecracker.socket -i \
  -X PUT 'http://localhost/actions'       \
  -H  'Accept: application/json'          \
  -H  'Content-Type: application/json'    \
  -d '{
      "action_type": "InstanceStart"
   }'
