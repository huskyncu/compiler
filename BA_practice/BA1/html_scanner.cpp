#include <iostream>
#include <string>

using namespace std;

int main()
{
    string input;
    // scanf("%s",input);
    getline(cin, input);
    string tmp = "";
    // std::string input; // 存放html的字串
    // ...
    bool inTagDef = false;
    bool intagclose = false;
    for (int i = 0; i < input.length(); i++)
    {
        if (i < input.length() - 1 && input[i] == '<' && input[i + 1] == '/')
        {
            inTagDef = true;
            if (intagclose == true)
            {
                intagclose = false;
                if (tmp != "")
                {
                    cout << "HTML_TEXT " << tmp << endl;
                    tmp = "";
                }
            }
            cout << "TAG_OPEN_SLASH " << input[i] << input[i + 1] << endl;
            i += 1;
            // ... generate TAG_OPEN_SLASH token
        }
        else if (input[i] == '<')
        {
            inTagDef = true;
            cout << "TAG_OPEN " << input[i] << endl;
            // ... generate TAG_OPEN token
        }
        else if (input[i] == '>')
        {

            if (tmp[0] != '\'' && tmp[0] != '\"')
            {
                inTagDef = false;
                intagclose = true;
                if (tmp != "")
                {
                    cout << "TAG_NAME " << tmp << endl;
                    tmp = "";
                }

                cout << "TAG_CLOSE " << input[i] << endl;
            }

            // ... generate TAG_CLOSE token
        }
        else if (input[i] == '=')
        {

            // inTagDef = false;

            // cout<<" equal= "<<tmp<<endl;
            cout << "TAG_NAME " << tmp << endl;
            tmp = "";
            // cout<<endl;
            cout << "TAG_EQUALS " << input[i] << endl;

            // ... generate TAG_EQUALS token
        }
        else if (input[i] == '\'' && inTagDef == true)
        {
            inTagDef = false;
            cout << "SINGLE_QUOTE_STRING ";
            for (i = i + 1; input[i] != '\''; i++)
            {
                cout << input[i];
            }
            cout << endl;
            tmp = "";
            // ... generate SINGLE_QUOTE_STRING token
        }
        else if (input[i] == '"' && inTagDef == true)
        {
            inTagDef = false;
            cout << "DOUBLE_QUOTE_STRING ";
            for (i = i + 1; input[i] != '\''; i++)
            {
                cout << input[i];
            }
            cout << endl;
            tmp = "";
            // ... generate DOUBLE_QUOTE_STRING token
        }
        else if (input[i] == ' ')
        {
            if (inTagDef)
            {
                cout << "TAG_NAME " << tmp << endl;
                tmp = "";
            }
            else if (intagclose)
            {
                if (tmp != "")
                    tmp += " ";
            }
            continue;
        }
        else if (inTagDef || intagclose)
        {
            tmp += input[i];
            // cout<<tmp<<endl;
        }
    }
}