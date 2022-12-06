#include <iostream>
#include <vector>
#include<map>
#include <set>

using namespace std;

map<char, vector<string>> grammar;
map<char, set<char>> first_set;
char here;

bool nonterminal(char c)
{
    return (c >= 'A' && c <= 'Z');
}

bool terminal(char c)
{
    return (c >= 'a' && c <= 'z');
}

void FindFirstSet(char chr)
{
    for (int i = 0; i < grammar[chr].size(); i++)
    {
        set<char> tmp_grammar;
        for (int j = 0; j < grammar[chr][i].size(); j++)
        {
            set<char> tmp_first;
            char here = grammar[chr][i][j];
            // cout << "here is "<<here << endl;
            if (terminal(here) || here == '$' || here == ';')
            {
                tmp_first.insert(here);
            }
            else if (nonterminal(here))
            {
                // cout<<"into "<<here<<endl;
                if (first_set.find(here) == first_set.end())
                    FindFirstSet(here);
                // cout<<"back to "<<chr<<endl;
                tmp_first.insert(first_set[here].begin(), first_set[here].end());
            }
            tmp_grammar.insert(tmp_first.begin(), tmp_first.end());
            // cout<<"firsttmp: ";
            // for (auto it = tmp_first.begin(); it != tmp_first.end(); it++)
            //      cout << *it;
            // cout << endl;
            // cout<<"grammartmp: ";
            // for (auto it = tmp_grammar.begin(); it != tmp_grammar.end(); it++)
            //      cout << *it;
            // cout << endl;
            if (tmp_first.find(';') != tmp_first.begin())
            {
            	//cout<<"break"<<endl;
                tmp_grammar.erase(';');
                break;
            }
        }
        first_set[chr].insert(tmp_grammar.begin(), tmp_grammar.end());
        // cout<<"firstset: ";
        // for (auto it = first_set[chr].begin(); it != first_set[chr].end(); it++)
        //     cout << *it;
        // cout << endl;
    }
}

int main()
{
    char chr;
    string input;
    string text;
    string tmp;
    while (1)
    {
        cin >> chr >> input;
        if (input == "ND_OF_GRAMMAR")
        {
            break;
        }
        for (int index = 0; index<input.length(); index++)
        {

            if (input[index] != '|')
            {
                tmp += input[index];
            }
            else
            {
                grammar[chr].push_back(tmp);
                tmp = "";
            }
        }
        // cout<<tmp;
        grammar[chr].push_back(tmp);
        tmp = "";
        // cout << chr << " ";
        //  for (auto i = grammar[chr].begin(); i != grammar[chr].end(); i++)
        //      cout << *i;
        //  cout << endl;
    }
    for (char chr = 'A'; chr <= 'Z'; chr++)
    {
        if (first_set.find(chr) == first_set.end())
        {
            FindFirstSet(chr);
        }
    }
    for (char chr = 'A'; chr <= 'Z'; chr++)
    {
        if (first_set.find(chr) != first_set.end())
        {
            cout << chr << " ";
            for (set<char>::iterator i = first_set[chr].begin(); i != first_set[chr].end(); i++)
                cout << *i;
            cout << endl;
        }
    }
    cout << "END_OF_FIRST" << endl;
    // cout << text;
}