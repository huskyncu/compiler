#include <iostream>
#include <unordered_map>
#include <set>
#include <vector>
#include <cctype>
#include <string>
using namespace std;

unordered_map<char, vector<string>> rule;
unordered_map<char, set<char>> first;
unordered_map<char, bool> fc;
unordered_map<char, bool> visit;
bool change;
void FindFirst(char ch) {
	visit[ch] = true;
	for (int i = 0; i < rule[ch].size(); i++) {
		set<char> ruleTmp;
		for (int j = 0; j < rule[ch][i].size(); j++) {
			char now = rule[ch][i][j];
			set<char> NowFirstTmp;
			//terminal
			if (islower(now) || now == ';' || now == '$') {
				NowFirstTmp.insert(now);
			}
			//nonterminal
			else {
				if (first.find(now) == first.end()) {
					if (!visit[now] || fc[now]) {
						FindFirst(now);
					}
					else {
						break;
					}
				}
				NowFirstTmp.insert(first[now].begin(), first[now].end());
			}
			ruleTmp.insert(NowFirstTmp.begin(), NowFirstTmp.end());
			if (NowFirstTmp.find(';') == NowFirstTmp.end()) {
				ruleTmp.erase(';');
				break;
			}
		}
		int preSize = first[ch].size();
		first[ch].insert(ruleTmp.begin(), ruleTmp.end());
		if (first[ch].size() != preSize) {
			fc[ch] = true;
			change = true;
		}
	}
}

int main() {
	char ch;
	string s;
	while (cin >> ch >> s) {
		if (s == "ND_OF_GRAMMAR") break;
		size_t pos;
		while (pos = s.find('|'), pos != string::npos) {
			rule[ch].push_back(s.substr(0, pos));
			s.erase(0, pos + 1);
		}
		rule[ch].push_back(s);
	}
	change = true;
	while(change){
		change = false;
		visit.clear();
		fc.clear();
		for (char ch = 'A'; ch <= 'Z'; ch++) {
			if (rule.find(ch) == rule.end())
				continue;
			if (!visit[ch]) 
				FindFirst(ch);
		}
	}
	for (char ch = 'A'; ch <= 'Z'; ch++) {
		if (first.find(ch) == first.end())
			continue;
		cout << ch << " ";
		for (auto it = first[ch].begin(); it != first[ch].end(); it++)
			cout << *it;
		cout << endl;
	}
	cout << "END_OF_FIRST" << endl;
}