#sudo vmhgfs-fuse -o allow_other -o auto_unmount .host:/workspace ~/share
sudo mount -t vboxsf -o uid=1000,gid=1000 workspace /home/melosaiyan/share
