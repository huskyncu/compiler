#include <iostream>

using namespace std;
int index = 0;
string c="";
string answer="";
bool correct = true;
void s2();
void s3();
void s4();
void error();
void error()
{
    correct = false;
}
void s3()
{
    if(c[index]=='a')
    {
        index++;
        s3();
    }
    else if(c[index]=='b')
    {
        error();
    }
    else if(c[index]=='c')
    {
        index++;
        s4();
    }
    else if(c[index]=='$')
    {
        answer+="Yes s3";
    }
}
void s4()
{
    if(c[index]=='$')
    {
        answer += "YES s4";
    }
}
void s2()
{
    if(c[index]=='a')
    {
        index++;
        s2();
    }
    else if(c[index]=='b')
    {
        index++;
        s4();
    }
    else error();
}
int main()
{
    
    cin>>c;
    if (c[index]=='c')
    {
        error();
    }
    else if(c[index] == 'b')
    {
        index++;
        s3();
    }
    else if(c[0]=='a')
    {
        index++;
        s2();
    }
    if(correct)
    {
        cout<<answer<<endl;
    }
    else{
        cout<<"NO"<<endl;
    }
}

