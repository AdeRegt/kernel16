

echo ">> Removing old floppy or USB image"
rm -f floppy.flp

echo ">> Creating new floppy image"
mkdosfs -C floppy.flp 1440

echo ">> Compiling bootloader"
nasm -O0 -w+orphan-labels -f bin -o bootload.bin bootload.asm

echo ">> Burning bootloader to image"
dd status=noxfer conv=notrunc if=bootload.bin of=floppy.flp

echo ">> Converting kernels C code into ASM"
smlrc kernel.c kernel.asm

echo ">> Compiling kernel"
nasm -O0 -w+orphan-labels -f bin -o kernel.bin entrypoint.asm

echo ">> Compiling stdlib"
smlrc stdlib.c stdlib.inc

echo ">> Compiling programs"
echo "   > Poweroff"
nasm -O0 -w+orphan-labels -f bin -o poweroff.bin poweroff.asm
echo "   > About"
smlrc about.c about.asm
nasm -O0 -w+orphan-labels -f bin -o about.bin about.asm
echo "   > Fileman"
smlrc fileman.c fileman.asm
nasm -O0 -w+orphan-labels -f bin -o fileman.bin fileman.asm

echo ">> Copy system"
rm -rf mountpoint
mkdir mountpoint

sudo mount -o loop -t vfat floppy.flp mountpoint
sudo cp kernel.bin mountpoint/kernel.bin
sudo cp poweroff.bin mountpoint/poweroff.bin
sudo cp about.bin mountpoint/about.bin
sudo cp fileman.bin mountpoint/fileman.bin
sudo umount mountpoint

sudo rm -rf mountpoint

echo ">> Finished"
