void main(){
	unsigned char* buffer = (unsigned char*) 0x5000;
	hideCursor();
	cls();
	char* filelist = getFileList();
	int alpha = choose(filelist);
	cls();
	if(loadFileByID(alpha,buffer)){
		alpha = choose("Bekijken;Uitvoeren;Terug");
		cls();
		if(alpha==0){
			int base = 0;
			while(1){
				setTitle("Viewer","+ volgende 512 | - vorige 512 | e terug");
				for(int i = 0 ; i < 512 ; i++){
					putc(buffer[base+i]);
				}
				char x = getc();
				if(x=='+'){base+=512;}
				if(x=='-'){base-=512;}
				if(x=='e'){asm("jmp _main");}
			}
		}else if(alpha==1){
			asm("call 0x5000");
			getc();
		}else if(alpha==2){
		
		}
	}else{
		printf("INIT: Unable to load file");
	}
	asm("jmp _main");
	for(;;);
}


void hideCursor(){
	asm("mov ch, 32");
	asm("mov ah, 1");
	asm("mov al, 3");
	asm("int 10h");
}

char fexists(char* filename){
	char* filelist = getFileList();
	int probing = 0;
	int insmod = 0;
	while(1){
		char thx = filelist[insmod];
		if(thx==0x00){
			return 0x00;
		}
		int tmp = 1;
		for(int i = 0 ; i < 11 ; i++){
			char X = filelist[insmod++];
			char Y = filename[i];
			if(X!=Y){
				tmp = 0;
			}
		}
		if(tmp==1){
			goto second;
		}
		char X = filelist[insmod++];
		if(X==0x00){
			return 0x00;
		}
		probing++;
	}
	return 0x00;
	second:
	return 0x01;
}

char fnew(char* filename){
	return 0x00;
}

char fread(char* filename,void *location){
	char* filelist = getFileList();
	int probing = 0;
	int insmod = 0;
	while(1){
		char thx = filelist[insmod];
		if(thx==0x00){
			return 0x00;
		}
		int tmp = 1;
		for(int i = 0 ; i < 11 ; i++){
			char X = filelist[insmod++];
			char Y = filename[i];
			if(X!=Y){
				tmp = 0;
			}
		}
		if(tmp==1){
			goto second;
		}
		char X = filelist[insmod++];
		if(X==0x00){
			return 0x00;
		}
		probing++;
	}
	return 0x00;
	second:
	return loadFileByID(probing,location);
}

char fwrite(char* filename,void *location,int size){
	if(fexists(filename)==0){
		fnew(filename);
	}
	char* filelist = getFileList();
	int probing = 0;
	int insmod = 0;
	while(1){
		char thx = filelist[insmod];
		if(thx==0x00){
			return 0x00;
		}
		int tmp = 1;
		for(int i = 0 ; i < 11 ; i++){
			char X = filelist[insmod++];
			char Y = filename[i];
			if(X!=Y){
				tmp = 0;
			}
		}
		if(tmp==1){
			goto second;
		}
		char X = filelist[insmod++];
		if(X==0x00){
			return 0x00;
		}
		probing++;
	}
	return 0x00;
	second:
	return writeFileByID(probing,location,size);
}

char writeFileByID(int number,void *targetbuff,int size){
	char* buffer = (char*) 0x1000;
	if(readSectorsDeviceLBA(1,0,19,buffer)){
		int index = 0;
		char deze = 0x00;
		int andere = 0;
		for(int i = 1 ; i < 20 ; i++){
			int semaphore = i*32;
			if(buffer[semaphore+11]!=0x0f){
				if(number==index){
					deze = buffer[semaphore+26];
					andere = buffer[semaphore+28];
					break;
				}
				index++;
			}
		}
		int prosizeA = (andere/512)+1;
		int prosizeB = (size/512)+1;
		if(prosizeB==prosizeA){
			return writeSectorsDeviceLBA((andere/512)+1,0,deze+31,targetbuff);
		}else{
			printf("__SIZE DIFFERENT__");
		}
	}
	return 0x00;
}

char loadFileByID(int number,void *targetbuff){
	char* buffer = (char*) 0x1000;
	if(readSectorsDeviceLBA(1,0,19,buffer)){
		int index = 0;
		char deze = 0x00;
		int andere = 0;
		for(int i = 1 ; i < 20 ; i++){
			int semaphore = i*32;
			if(buffer[semaphore+11]!=0x0f){
				if(number==index){
					deze = buffer[semaphore+26];
					andere = buffer[semaphore+28];
					break;
				}
				index++;
			}
		}
		return readSectorsDeviceLBA((andere/512)+1,0,deze+31,targetbuff);
	}
	return 0x00;
}

int choose(char* alpha){
	int pointer = 0;
	while(1){
		cls();
		setTitle("Selecteer een optie","Pijltjestoetsen: Navigeer | ENTER : Selecteer");
		draw(pointer+1,0,0x70,80);
		curpos(1,0);
		int rowpointer = 0;
		int beta = 0;
		if(rowpointer==pointer){
			printf(">>> ");
		}else{
			printf("--- ");
		}
		while(1){
			char deze = alpha[beta++];
			if(deze==0x00){
				rowpointer++;
				break;
			}else if(deze==';'){
				printf("\n\r");
				rowpointer++;
				if(rowpointer==pointer){
					printf(">>> ");
				}else{
					printf("--- ");
				}
			}else{
				putc(deze);
			}
		}
		printf("\n\r");
		char et = getsc();
		if(et==0x48){
			if(pointer!=0){
				pointer--;
			}
		}else if(et==0x50){
			if(pointer!=rowpointer){
				pointer++;
			}
		}else if(et==0x1C){
			break;
		}
	}
	return pointer;
}

void setTitle(char* front,char* back){
	curpos(0,0);
	draw(0 ,0,0x2a,80);
	for(int i = 1 ; i < 24 ; i++){
		draw(i,0,0x60,80);
	}
	draw(24,0,0x2a,80);
	curpos(0,2);
	printf(front);
	curpos(0,68);
	printf("SanderOS16");
	curpos(24,2);
	printf(back);
	curpos(1,0);
}

char* getFileList(){
	char* buffer = (char*) 0x1000;
	char filebuffer[100];
	int x = 0;
	char first = 1;
	if(readSectorsDeviceLBA(1,0,19,buffer)){
	//if(readSectorsDevice(1,0,2,1,0,buffer)){
		for(int index = 0 ; index < 20 ; index++){
			if(buffer[(index*32)+11]!=0x0f){
				if(buffer[(index*32)]==0x00){
					break;
				}
				if(first){
					first = 0;
				}else{
					char X = ';';
					filebuffer[x++] = (X);
				}
				for(int i = 0 ; i < 11 ; i++){
					filebuffer[x++] = (buffer[(index*32)+i]);
				}
			}
		}
	}else{
		printf("DEV: cannot read\n\r");
	}
	filebuffer[x] = 0;
	return filebuffer;
}

char writeSectorsDeviceLBA(char sectorcount,char device,int lba,void *buffer){
	char head = 0;
	char track = 0;
	char sector = 0;
	head = (lba % (18 * 2)) / 18;
	track = (lba / (18 * 2));
	sector = (lba % 18 + 1);
	writeSectorsDevice(sectorcount,track,sector,head,device,buffer);
}

char readSectorsDeviceLBA(char sectorcount,char device,int lba,void *buffer){
	char head = 0;
	char track = 0;
	char sector = 0;
	head = (lba % (18 * 2)) / 18;
	track = (lba / (18 * 2));
	sector = (lba % 18 + 1);
	readSectorsDevice(sectorcount,track,sector,head,device,buffer);
}

void draw(char x,char y,char color,char times){
	curpos(x,y);
	asm("mov ah,0x09");
	asm("mov al,0x00");
	asm("mov bh,0x00");
	asm("mov bl,[bp+8]");
	asm("mov cx,[bp+10]");
	asm("int 0x10");
}

//AH	02h
//AL	Sectors To Read Count
//CH	Cylinder
//CL	Sector
//DH	Head
//DL	Drive
//ES:BX	Buffer Address Pointer
// loc     sectorcount : (@4) : char
// loc     cylinder : (@6) : char
// loc     sector : (@8) : char
// loc     head : (@10) : char
// loc     device : (@12) : char
// loc     buffer : (@14) : * void
char readSectorsDevice(char sectorcount,char cylinder,char sector,char head,char device,void *buffer){
	if(resetDevice(device)){
		asm("mov si, [bp+14]");
		asm("mov bx, ds");
		asm("mov es, bx");
		asm("mov bx, si");
		asm("mov ah, 0x02");
		asm("mov al, [bp+4]");
		asm("mov ch, [bp+6]");
		asm("mov cl, [bp+8]");
		asm("mov dh, [bp+10]");
		asm("mov dl, [bp+12]");
		asm("int 0x13");
		asm("jc .skip");
		return 0x01;
		asm(".skip:");
		return 0x00;
	}else{
		return 0x00;
	}
}

char writeSectorsDevice(char sectorcount,char cylinder,char sector,char head,char device,void *buffer){
	if(resetDevice(device)){
		asm("mov si, [bp+14]");
		asm("mov bx, ds");
		asm("mov es, bx");
		asm("mov bx, si");
		asm("mov ah, 0x03");
		asm("mov al, [bp+4]");
		asm("mov ch, [bp+6]");
		asm("mov cl, [bp+8]");
		asm("mov dh, [bp+10]");
		asm("mov dl, [bp+12]");
		asm("int 0x13");
		asm("jc .skip");
		return 0x01;
		asm(".skip:");
		return 0x00;
	}else{
		return 0x00;
	}
}

char resetDevice(char device){
	asm("mov dl,[bp+4]");
	asm("mov ax,0");
	asm("int 0x13");
	asm("jc .skip");
	return 0x01;
	asm(".skip:");
	return 0x00;
}

char getc(){
	asm("mov ax,0");
	asm("int 0x16");
}


char getsc(){
	asm("mov ax,0");
	asm("int 0x16");
	asm("mov al,ah");
}

void putc(char a){
	asm("mov ah,0x0e");
	asm("int 0x10");
}

void printf(char* text){
	char deze = 0x00;
	int i = 0;
	while((deze = text[i++])!=0x00){
		putc(deze);
	}
}

void curpos(char x,char y){
	asm("mov ah,0x02");
	asm("mov dh,[bp+4]");
	asm("mov dl,[bp+6]");
	asm("mov bh,0");
	asm("int 0x10");
}

void cls(){
	asm("mov ah,0x02");
	asm("mov dh,0");
	asm("mov dl,0");
	asm("mov bh,0");
	asm("int 0x10");
	for(int y = 0 ; y < 20 ; y++){
		printf("                                                                          \n\r");
	} 
	asm("mov ah,0x02");
	asm("mov dh,0");
	asm("mov dl,0");
	asm("mov bh,0");
	asm("int 0x10");
}
