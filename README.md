# kernel16
A 16bit operatingsystem written in C

## Linux 
### Build
```
bash build.sh
```

### Run
Qemu:
```
qemu-system-i386 -fda floppy.flp
```

### Burn
To USB:
```
sudo dd if=floppy.flp of=/dev/sdb
```
