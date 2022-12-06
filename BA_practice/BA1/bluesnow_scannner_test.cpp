#include <iostream>
using namespace std;

string x="";
string txt="";
int p=0;
int iserror=0;

void scan();
int isidf();
int isid();
int isnumf();
int isnum();
void error();

int main() {
	// your code goes here
	/*string txt="";
	string tmp;
	while(cin>>tmp){
		txt+=tmp;
		txt+=" ";
	}
	cout<<txt;*/
	string tmp;
	char a[100];
	cin.getline(a,99);
	txt+=a;
	for(int i=0;i<20;i++){
		cin.getline(a,99);
		txt+=" ";
		txt+=a;
	}
	if(txt==""){return 0;}
	else{
	scan();
	if(iserror==0){cout<<x;}
	else{x="invalid input\n";cout<<x;}
	return 0;}
	return 0;
}
void scan(){
	if(p>=txt.length()){}
	else if(txt[p]==' '){p++;scan();}
	else if(isidf()){
		x+="ID ";
		for(p=p;isid();p++){
			if(txt[p]==' '){}
			else{x+=txt[p];}
		}
		x+="\n";
		scan();
	}
	else if(txt[p]==';'){
		x+="SEMICOLON ;\n";
		p++;
		scan();
	}
	else if(txt[p]=='('){
		x+="LBR (\n";
		p++;
		scan();
	}
	else if(txt[p]==')'){
		x+="RBR )\n";
		p++;
		scan();
	}
	else if(isnumf()){
		x+="NUM ";
		x+=txt[p];
		for(p=p+1;isnum();p++){
			if(txt[p]==' '){}
			else{x+=txt[p];}
		}
		x+="\n";
		scan();
	}
	else if(txt[p]=='+' || txt[p]=='-' || txt[p]=='*' || txt[p]=='/' || txt[p]=='='){
		x+="OP ";
		x+=txt[p];
		x+="\n";
		p++;
		scan();
	}
	else{
		error();
	}
}
int isnumf(){
	if(txt[p]>48 && txt[p]<58){
		return 1;
	}
	else if(txt[p]=='-'){
		return 1;
	}
	else{return 0;}
}
int isnum(){
	if(txt[p]==' '){return 1;}
	if(txt[p]>47 && txt[p]<58){
		return 1;
	}
	else{return 0;}
}
int isidf(){
	if(txt[p]>64 && txt[p]<91){
		return 1;
	}
	else if(txt[p]>96 && txt[p]<123){
		return 1;
	}
	else if(txt[p]=='_'){
		return 1;
	}
	else{
		return 0;
	}
}
int isid(){
	if(txt[p]==' '){return 1;}
	if(txt[p]>64 && txt[p]<91){
		return 1;
	}
	else if(txt[p]>96 && txt[p]<123){
		return 1;
	}
	else if(txt[p]=='_'){
		return 1;
	}
	else if(txt[p]>47 && txt[p]<58){
		return 1;
	}
	else{
		return 0;
	}
}
void error(){
	x="invalid input\n";
	iserror=1;
}