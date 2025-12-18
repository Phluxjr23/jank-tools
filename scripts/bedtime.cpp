#include <iostream>
#include <thread>
#include <chrono>
#include <random>

int main() {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, 1);
    
    bool mimimi = dis(gen) == 0;
    
    std::cout << "going to sleep..." << std::endl;
    std::this_thread::sleep_for(std::chrono::seconds(1));
    
    for (int i = 0; i < 10; i++) {
        if (mimimi) {
            std::cout << "snore mimimimimimi ";
        } else {
            std::cout << "honk shoo ";
        }
        std::cout << std::flush;
        std::this_thread::sleep_for(std::chrono::seconds(2));
    }
    
    std::cout << std::endl;
    std::cout << "*wakes up*" << std::endl;
    std::cout << "good morning!" << std::endl;
    
    return 0;
}
