#include <iostream>
#include <stack>
#include <string>

int main() {
	std::stack<int> stk;
	while(1) {
		std::string str;
		std::cin >> str;
		int inp, tmp1, tmp2;
		if(str == "$") {
			break;
		} else if(str == "push"){
			std::cin >> inp;
			stk.push(inp);
		} else if(str == "inverse") {
			tmp1 = stk.top();
			stk.pop();
			tmp2 = stk.top();
			stk.pop();
			stk.push(tmp1);
			stk.push(tmp2);
		} else if(str == "inc") {
			stk.top()++;
		} else if(str == "dec") {
			stk.top()--;
		}
	}
	std::cout << stk.top() << std::endl;
}