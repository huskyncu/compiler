#include <iostream>

using namespace std;

bool correct = true;
int index=0;
string text = "";
string answer = "";
void stmt();
void error()
{
    correct=false;
}
bool id(char c)
{
    return (c=='_'  || c>='A' && c<='Z' || c>='a' && c<='z');
}
bool ids(char c)
{
    return (c=='_' || c>='0' && c<='9' || c>='A' && c<='Z' || c>='a' && c<='z');
}
void primary_tail()
{
    if(text[index]=='.')
    {
        answer+="DOT .\n";
        index++;
        if(text[index]!='.')
        {
            answer+="ID ";
            while(ids(text[index]))
            {
                answer+=text[index];
                index++;
            }
            answer+="\n";
            primary_tail();
        }
        else error();
    }
    else if(text[index]=='(')
    {
        answer+="LBR (\n";
        index++;
        stmt();
        answer+="RBR )\n";
        index++;
        primary_tail();
    }
    else
    {
        if(text[index]=='$' || text[index]==')' || text[index]=='"' || text[index]=='\n' || text[index]==' ') /* do nothing*/;
        else error();
    }
}
void primary()
{
    answer+="ID ";
    while(ids(text[index]))
    {
        answer+=text[index];
        index++;
    }
    answer+="\n";
    primary_tail();
}
void stmt()
{
    if(id(text[index])) primary();
    else if(text[index]==' ') index++;
    else if(text[index]=='"')
    {
        answer+="STRLIT \"";
        index++;
        while(text[index]!='"')
        {
            answer+=text[index];
            index++;
        }
        answer+="\"\n";
        index++;
    }
    else
    {
        if(text[index]=='$' || text[index]==')' || text[index]=='"') /*do nothing */;
        else error();
    }
}
void stmts()
{
    if(id(text[index]) || text[index]=='"')
    {
        stmt();
        stmts();
    }
    else if(text[index]==' ')
    {

        index++;
        stmts();
    }
    else
    {
        if(text[index]=='$' || text[index]==')' || text[index]=='"' ) /*do nothing */;
        else error();
    }
}
int main()
{
    char input;
    while(scanf("%c",&input)!=EOF) text+=input;
    for(int index=0; index<text.length(); index++) if(text[index]=='\n') text[index]=' ';
    text += "$";
    stmts();
    if(correct) cout<<answer;
    else cout<<"invalid input"<<endl;
}





