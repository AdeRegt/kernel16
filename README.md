# kernel16
A 16bit operatingsystem written in C

# Requirements:
Nasm - https://www.nasm.us/
smlrc - https://github.com/alexfru/SmallerC/tree/master/v0100/binm

# Distribution:
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
