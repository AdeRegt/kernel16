asm("org 0x5000");

void main(){
	setTitle("About SanderOS","Press any key to continue");
	printf("Created by:\n\rSander\n\rDaniel");
	getc();
}


void setTitle(char* a,char* b){
	typedef int func(char* a,char* b);
	func* f = (func*)30;
	int v = f(a,b);
}

void printf(char* a){
	typedef int func(char* a);
	func* f = (func*)0x0003;
	int v = f(a);
}


char getc(){
	typedef char func();
	func* f = (func*)39;
	return f();
}
