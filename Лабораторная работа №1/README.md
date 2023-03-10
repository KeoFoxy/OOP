# Объектно-ориентированное программирование  

## Лабораторная работа №1  
---  
#### Теоретическая справка   

##### CSV - Comma-separated values  
> CSV - Comma-separated values – формат хранения данных, в котором данные разделены запятыми или точка-запятыми. Каждая запись данных располагается на отдельной строке, а каждое поле внутри записи разделяется запятой.  

**Пример СSV-файла**  
```csv
1; BMW M5; 0; 2022
2; Porsche Cayenne; 1; 2020  
```
---

##### Enum   
> Enum (англ. enumeration) в C++ является типом данных, который представляет собой набор константных целочисленных значений. Каждое значение имеет своё уникальное имя, которое может быть использовано в коде вместо соответствующего числового значения. Это позволяет улучшить читабельность кода и сделать его более надежным.

  
```cpp
enum Color
{
    RED, GREEN, BLUE, WHITE, BLACK, YELLOW, ORANGE, GRAY
    //RED == 0, GREEN == 1, ... , GRAY == 7
};

Color background = Color::BLUE;

std::cout << "Color: " << background << std::endl; //Color: 2
```  
---

##### Сортировка  
Методов сортировки существует множество, рассмотрим функцию сортировки из STL библиотеки. 
Пример сортировки:  
```cpp
#include <algorithm>

std::vector<int> numbers = {3, 1, 4, 1, 5, 9, 2, 6};
std::sort(numbers.begin(), numbers.end(), [](int a, int b){ 
    return a < b; 
});
```

---

##### Чтение файлов  
Для чтения файлов используется класс ifstream из fstream. 
```cpp
#include <fstream>

int main() {
    std::ifstream file("example.txt");

    if (file.is_open()) {
        std::string line;

        while (!file.eof()) {
            std::getline(file, line)
            std::cout << line << std::endl;
        }

        file.close();   
    } else {
        std::cout << "Failed to open file" << std::endl;
    }
    return 0;
}

```

---
## **Задание**  
В данном курсе на лабораторных работах мы будем разрабатывать имитацию базы данных.  

В первой лабораторной работе необходимо написать программу, которая будет считывать из CSV файла данные, сортировать их и выводить в консоль. 

---  
#### **Варианты**   

0. Вариант:

Можете сами придумать себе тему. Главное, чтобы она была аналогична уже данным вариантам.  


1. Вариант:  

Автомобили: 
* ID 
* Марка и модель 
* Тип двигателя (enum: бензин, дизель, гибрид, электро)
* Количество лошадиных сил.

***Отсортировать по количеству лошадиных сил. Вывести все автомобили с бензиновыми двигателями мощностью больше 249 л.с.***   

2. Вариант:   

Фильмы:
* ID
* Название фильма
* Основной жанр (enum: боевик, триллер, романтика, фанастика и тд.)
* Год выпуска

***Отсортировать по году выпуска. Вывести все фильмы жанра романтика, которые вышли после 2010 года.***   

3. Вариант:

Игры:
* ID
* Название игры
* Основной жанр игры (enum: Cyberpunk, RPG, FPS и тд.)
* Год выпуска

***Отсортировать по названию. Вывести все игры жанра RPG старше 2 лет.***   

4. Вариант:

Аниме и сериалы:
* ID
* Название
* Тип (enum: Serial, Movie, OVA)
* Студия, которая выпустила (A-1, Mappa, KyoAni, Netflix, HBO и тд.)

***Отсортировать по названию. Вывести все TV сериалы от Netflix.***

---

#### **Этапы выполнения**  

1. Разобрать пример реализации функции split, проверить работоспособность с помощью отладчика.
```cpp
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
```  
2. Используя функцию split и функции потокового чтения из файла, сделать чтение записей.
3. Добавить сортировку и вывод данных.  
4. Добавить вывод отсортированных данных в файл.

---

## Вопросы

1. Что такое **CSV**?
2. Что такое **ENUM**?
3. Что такое функциональное программирование и какое отличие от ООП?
4. Что такое лямбда функция?
