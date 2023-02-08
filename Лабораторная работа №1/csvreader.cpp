#include <fstream>
#include <iostream>
#include <string>
#include <vector>

enum Color {
    RED,
    BLUE,
    GREEN,
    WHITE,
    PURPLE,
    BLACK,
    PINK
}

struct object {
    int ID;
    std::string name;
    Color color;
    int year;
};

std::vector<std::string> split_line(const std::string &str, char delim) {

    std::vector<std::string> tokens;

    if (!str.empty()) {
        size_t start = 0, end;
        do {
            tokens.push_back(str.substr(start, (str.find(delim, start) - start)));
            end = str.find(delim, start);
            start = end + 1;
        } while (end != std::string::npos);
    }

    return tokens;
}