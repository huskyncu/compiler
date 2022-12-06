#include <iostream>

using namespace std;

string tmp="",texts="",input;
bool hasint=false;

void determine()
{
	if(hasint)
	{
		cout<<tmp<<endl;
		tmp="";
		hasint=false;
	}
}
void determine_int(int i)
{
	if(!hasint)
	{
		cout<<"NUM ";
		hasint=true;
		//cout<<"texts[i]"<<i<<" "<<texts[i]<<endl;
		//cout<<"tmp"<<tmp<<endl;
	}
	tmp+=texts[i];
}
int main() {
	while(cin>>input) texts+=input;
    int i=0,j=texts.length();
	while(j--)
    {
    	switch(texts[i])
    	{
    		case '0': case '1': case '2': case '3': case '4': case '5': case '6': case '7': case '8': case '9':
    			//cout<<"switch "<<texts[i]<<endl;
    			determine_int(i);
    			break;
    		case '+':
    			determine();
    			cout<<"PLUS"<<endl;
    			break;
    		case '-':
    			determine();
    			cout<<"MINUS"<<endl;
    			break;
    		case '*':
    			determine();
    			cout<<"MUL"<<endl;
    			break;
    		case '/':
    			determine();
    			cout<<"DIV"<<endl;
    			break;
    		case '(':
    			determine();
    			cout<<"LPR"<<endl;
    			break;
    		case ')':
    			determine();
    			cout<<"RPR"<<endl;
    			break;
    		
    	}
		i++; 
    }
    if(hasint) cout<<tmp<<endl;
}
