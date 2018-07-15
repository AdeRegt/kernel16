//jmp os_main		0		X
//jmp _printf		3		V
//jmp _putc		6		V
//jmp _curpos		9		V
//jmp _cls		12		V
//jmp _fexists		15		V
//jmp _fnew		18		V
//jmp _fread		21		V	char fread(char* filename,void *location)
//jmp _fwrite		24		V
//jmp _choose		27		V
//jmp _setTitle		30		V
//jmp _getFileList	33		V
//jmp _draw		36
//jmp _getc		39		V
//jmp _getsc		42		V
//jmp _loadFileByID	45		V
//jmp _writeFileByID	48		V

void printf(char* a){
	typedef void func(char* a);
	func* f = (func*)0x0003;
	f(a);
}

void putc(char a){
	typedef void func(char a);
	func* f = (func*)6;
	f(a);
}


void curpos(char a,char b){
	typedef int func(char a,char b);
	func* f = (func*)9;
	int v = f(a,b);
}

char cls(){
	typedef char func();
	func* f = (func*)12;
	return f();
}

char fexists(char* a){
	typedef char func(char* a);
	func* f = (func*)15;
	return f(a);
}

char fnew(char* a){
	typedef char func(char* a);
	func* f = (func*)18;
	return f(a);
}

char fread(char* a,void *b){
	typedef char func(char* a,void *b);
	func* f = (func*)21;
	return f(a,b);
}

char fwrite(char* a,void *b){
	typedef char func(char* a,void *b);
	func* f = (func*)24;
	return f(a,b);
}

int choose(char* a){
	typedef int func(char* a);
	func* f = (func*)27;
	return f(a);
}

void setTitle(char* a,char* b){
	typedef int func(char* a,char* b);
	func* f = (func*)30;
	int v = f(a,b);
}

char* getFileList(){
	typedef char* func();
	func* f = (func*)33;
	return f();
}

char getc(){
	typedef char func();
	func* f = (func*)39;
	return f();
}

char getsc(){
	typedef char func();
	func* f = (func*)42;
	return f();
}

char loadFileByID(int a,void *b){
	typedef char func(int a,void *b);
	func* f = (func*)45;
	return f(a,b);
}

char writeFileByID(int a,void *b,int c){
	typedef char func(int a,void *b,int c);
	func* f = (func*)48;
	return f(a,b,c);
}
