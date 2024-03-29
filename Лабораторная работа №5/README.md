# Объектно-ориентированное программирование  

## Лабораторная работа №5. Абстрактный класс и JSON  
---  
## Теоретическая справка   

### Абстрактные классы  

Абстрактный класс - это тип класса в ООП, который нельзя экземпляризовать (создать объект из него), но может быть использован как родительский класс для других классов. Абстрактные классы часто содержат абстрактные методы, которые не имеют реализации в родительском классе, но должны быть реализованы в классах-наследниках.  
Любой класс, который содержит хотя бы одну чистую виртуальную функцию становится абстрактным.  
Объекты виртуальных классов **нельзя** создавать.

### Виртуальные функции  

Виртуальная функция - это функция, объявленная в базовом классе и переопределенная в производных классах. Она обладает виртуальностью, то есть вызов функции осуществляется в зависимости от типа объекта, а не от типа указателя или ссылки, через которые он вызывается.

Виртуальные функции позволяют реализовать полиморфизм, то есть вызывать различные реализации функции в зависимости от типа объекта. Это позволяет использовать объекты различных классов с одинаковым интерфейсом в едином коде, не зная конкретный тип объекта.   

Чтобы сделать функцию виртуальной необходимо указать ключевое слово **`virtual`**.  
При переопределении виртуальной функции в классе наследнике, необходимо использовать ключевое слово `override`.  

```cpp
class Entity {
public:
    virtual void attack() { // <-- Объявили виртуальную функцию
        std::cout << "Attacking..." << std::endl;
    }
};

class Player : public Entity {
public:
    void attack() override { // <-- Переопределили ее
        std::cout << "Player is attacking..." << std::endl;
    }
};

int main(){

    Entity *entity = new Player();

    entity->attack(); // output: Player is attacking...

    return 0;
}
```
Казалось бы, должно вывести "Attacking...", но компилятор смотрит на метод **attack** в классе `Entity` и видит, что метод виртуальный, тогда он идет к классу `Player` и вызывает переопределенный метод attack.  

### Чистые виртуальные функции  

Чистая виртуальная функция - это виртуальная функция, которая объявляется с ключевым словом "virtual" и "=0" в конце ее определения. Это означает, что функция является абстрактной и должна быть переопределена в классах-наследниках. Такие функции не имеют реализации в родительском классе и не могут быть вызваны через указатель или ссылку на родительский класс. 

Если коротко, то мы говорим компилятору, что реализацию этих функций возьмут на себя дочерние классы.  


Использование чистых виртуальных функций приводит нас к двум основным последствиям:  
* Любой класс с одной и более виртуальными чистыми функциями становится **абстрактным классом**, объекты которого нельзя создавать.  
* Все дочерние классы абстрактного класса должны переопределять все чистые виртуальные функции, иначе они также будут считаться абстрактными классами.

```cpp
class Entity { //Абстрактный класс
public:
    virtual void attack() = 0; //Чистая виртуальная функция
};


class Player : public Entity {
public:
    void attack() override { // <-- Переопределили ее. Если не переопределить ее, то компилятор выдаст ошибку!
        std::cout << "Player is attacking..." << std::endl;
    }
};
```

Не виртуальным функциям нельзя присваивать 0.  
```cpp
class Entity {
public:
    void attack() = 0; //Ошибка! Нет слова virtual.
};
```

### Определение чистых виртуальных функций  

```cpp
class Entity { //Абстрактный класс
public:
    virtual void attack() = 0; //Чистая виртуальная функция
};

void Entity::attack() { //Черная магия, но мы определили чистую виртуальную функцию.
    std::cout << "Entity is attacking..." << std::endl;
}
```
В этом примере не нарушается понятие абстракного класса - у него есть читая виртуальная фунция, а его объекты также нельзя создавать. Любой класс, который будет наследоваться от `Entity` должен будет переопределить функцию **attack()**, так как она все еще остается чистой виртуальной функцией.  

При определении чистой виртуальной функции, ее тело должно быть записано отдельно.

Это полезно, когда вы хотите, чтобы дочерние классы имели возможность переопределять виртуальную функцию или оставить её реализацию по умолчанию (которую предоставляет родительский класс). В случае, если дочерний класс доволен реализацией по умолчанию, он может просто вызвать её напрямую.  


### JSON  

JSON (JavaScript Object Notation) - это текстовый формат для представления данных, часто используемый для обмена данными между веб-приложениями и серверами. Он основан на стандартах JavaScript и использует синтаксис объектов, ключ-значение, для описания данных.   

Пример json-файла:  
```json
{
    "id": 0,
    "name": "Lucy",
    "attributes": [
        "Intelligence": 20,
        "Reflexes": 17,
        "Cool": 18
    ],
    "weapon": "Monowire",
    "Affiliation": {
        "formerly": "Arasaka",
        "defunct": "Maine's crew"
    },
    "Role": "Netrunner",
    "Partner": "David Martinez"
}
```

Так исторически сложилось, что в С++ нет встроенных методов для парсинга JSON.  

Будь это JavaScript, то мы бы просто использовали что-то подобное:  
```js
const jsonFile = require('./jsonexample.json')

const data = JSON.parse(JSON.stringify(jsonFile))

console.log(data.name); // Output: Lucy
console.log(data.Affiliation.formerly); //Output: Arasaka
```
Но так как у нас нету ничего подобного в современном С++ 20го стандарта, то мы воспользуемся [этой библиотекой](https://github.com/nlohmann/json).  

Для ее установки необходимо всего лишь добавить в свой проект один [файл](https://github.com/nlohmann/json/blob/develop/single_include/nlohmann/json.hpp): `json.hpp`. Файл также находится в папке к этой лаборторной работе.  

Чтобы добавить его в проект, нажимаете на ваш проект правой кнопкой мыши и выбираете `добавить существующие файлы`

Пример работы с данной библиотекой:  
```cpp
std::vector<Anime> JSONReader::readAll() {
    std::vector<Anime> result;

    nlohmann::json json;

    fin >> json;

    for(const auto & j: json) {
        Anime anime;

        anime.setTitle(j["title"]);
        anime.setTargetId(j["target_id"]);
        anime.setTargetType(j["target_type"]);
        anime.setRating(j["rating"]);
        anime.setStatus(j["status"]);
        anime.setRewatches(j["rewatches"]);
        anime.setEpisodes(j["episodes"]);

        result.push_back(anime);
    }

    return result;
}
```

---
## **Задание**  
* Создать абстрактный класс `AbstractReader` с виртуальными методами is_open() и read().
* Переработать класс `CSVReader` чтобы он наследовался от AbstractReader.  
* Переработать кнопку так, чтобы она могла открывать и JSON, и CSV файлы.
* Реализовать класс чтения данных из JSON.

---

## Вопросы
1. Что такое виртуальная функция?
2. Что такое абстрактный класс?
3. Назовите 2 свойства абстрактного класса
4. Что такое JSON?
5. Какие функции необходимо переопределить при наследовании от абстрактного класса?

