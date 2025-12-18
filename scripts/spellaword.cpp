#include <iostream>
#include <vector>
#include <string>
#include <random>
#include <thread>
#include <chrono>

int main() {
    std::vector<std::string> words = {
        "jank", "tools", "linux", "arch", "cursed", "based",
        "yeet", "bruh", "cringe", "blessed", "chaos", "meme",
        "terminal", "command", "script", "binary", "compile"
    };
    
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, words.size() - 1);
    
    std::string word = words[dis(gen)];
    
    std::cout << "spelling: " << word << std::endl;
    std::cout << std::endl;
    
    for (char c : word) {
        std::cout << c << std::flush;
        std::this_thread::sleep_for(std::chrono::milliseconds(500));
    }
    
    std::cout << std::endl;
    std::cout << std::endl;
    std::cout << "done!" << std::endl;
    
    return 0;
}
