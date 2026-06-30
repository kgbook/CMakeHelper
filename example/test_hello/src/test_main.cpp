#include <iostream>
#include <string>

// Simple test without external test framework
// Returns 0 on success, non-zero on failure

int main() {
    int failures = 0;

    // Test 1: Basic assertion
    {
        std::string expected = "Hello";
        std::string actual = "Hello";
        if (expected != actual) {
            std::cerr << "FAIL: Test 1 - Expected '" << expected << "' but got '" << actual << "'" << std::endl;
            failures++;
        } else {
            std::cout << "PASS: Test 1 - String equality" << std::endl;
        }
    }

    // Test 2: Arithmetic
    {
        int expected = 42;
        int actual = 6 * 7;
        if (expected != actual) {
            std::cerr << "FAIL: Test 2 - Expected " << expected << " but got " << actual << std::endl;
            failures++;
        } else {
            std::cout << "PASS: Test 2 - Arithmetic" << std::endl;
        }
    }

    // Test 3: Boolean logic
    {
        bool condition = (5 > 3) && (10 >= 10);
        if (!condition) {
            std::cerr << "FAIL: Test 3 - Boolean condition failed" << std::endl;
            failures++;
        } else {
            std::cout << "PASS: Test 3 - Boolean logic" << std::endl;
        }
    }

    if (failures > 0) {
        std::cerr << "\n" << failures << " test(s) failed!" << std::endl;
        return 1;
    }

    std::cout << "\nAll tests passed!" << std::endl;
    return 0;
}
