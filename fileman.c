asm("org 0x4000");

void main(){
	char* filelist = getFileList();
	int alpha = choose(filelist);
	cls();
	unsigned char* buffer = (unsigned char*) 0x5000;
	if(loadFileByID(alpha,buffer)){
		typedef void func();
		func* f = (func*)buffer;
		f();
	}else{
		printf("UNABLE TO LOAD FILE");
		getc();
	}
	asm("jmp _main");
}



#include "stdlib.c"
