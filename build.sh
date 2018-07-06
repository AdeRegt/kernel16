

echo ">> Removing old floppy or USB image"
rm -f floppy.flp

echo ">> Creating new floppy image"
mkdosfs -C floppy.flp 1440 || exit

echo ">> Compiling bootloader"
nasm -O0 -w+orphan-labels -f bin -o bootload.bin bootload.asm || exit

echo ">> Burning bootloader to image"
dd status=noxfer conv=notrunc if=bootload.bin of=floppy.flp || exit

echo ">> Converting kernels C code into ASM"
smlrc kernel.c kernel.asm || exit

echo ">> Compiling kernel"
nasm -O0 -w+orphan-labels -f bin -o kernel.bin entrypoint.asm || exit

echo ">> Copy system"
rm -rf mountpoint
mkdir mountpoint

sudo mount -o loop -t vfat floppy.flp mountpoint
sudo cp kernel.bin mountpoint/kernel.bin
sudo umount mountpoint

rm -rf mountpoint
