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

struct objects {
    int ID;
    std::string name;
    Color color;
    int angles;
};

// Заготовка для второй лабы
class CSVReader {
public:
    CSVReader(const std::string &filename); // <-- Needs to be realised
    ~CSVReader();                           // <-- Needs to be realised

    bool is_open() { return fin.is_open(); }
    std::vector<std::string> split_line(const std::string &str, char divider); // <-- Needs to be fixed
    // std::vector<class _Tp>
private:
    std::ifstream fin;
};
