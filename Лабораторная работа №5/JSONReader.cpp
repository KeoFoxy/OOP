class JSONReader {
public:
    JSONReader(const QString &filename) {
        fin.open(filename.toLatin1().data());
        fin >> json;
        j_start = json.begin();
    }
    ~JSONReader() {
        fin.close();
    }

    bool is_open() {
        return fin.is_open();
    }

    virtual AbstractReader &operator>>(Player &players) override {

        if (j_start != json.end()) {
            players.level = j_start.value()["level"];
            players.HP = j_start.value()["HP"];
            players.name = QString::fromStdString(j_start.value()["Name"]);
        }
        j_start++;

        return *this;
    }

    virtual operator bool() const override {
        return j_start - 1 != json.end();
    }

    std::vector<Player> readAll() override;

private:
    int index = 0;
    nlohmann::json json;
    nlohmann::json::iterator j_start;
};

std::vector<Player> JSONReader::readAll() {
    std::vector<Player> players;
    nlohmann::json json;

    fin >> json;

    for (const auto &j : json) {
        Player result;
        result.level = j["level"];
        result.HP = j["HP"];
        result.name = QString::fromStdString(j_start.value()["Name"]);

        players.push_back(result);
    }

    return players;
}