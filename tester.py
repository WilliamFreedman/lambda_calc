import subprocess
import os

def tester (input,  output, mode):
    to_execute = ["./_build/default/src/main.exe"]
    to_execute.append(mode)
    with open(input) as f:
        result = subprocess.run(to_execute, stdin = f, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text = True, timeout = 5)

    result_str = result.stdout.strip()
    res_comp = open(output, 'r')
    res_comp_str = res_comp.read()

    if (result_str != res_comp_str):
        message = result_str
        return False, message
    else:
        return True, ""
    
def make_files(name):
    return f"./test_files/in/{name}.txt", f"./test_files/out/{name}.txt"

def main ():
    test_files = [
        ("identity", "capture_avoiding"),
        ("identity", "naive"),
        ("constant", "capture_avoiding"),
        ("constant", "naive"),
    ]
    tests_passed = 0
    for name, mode in test_files:
        in_file, out_file = make_files(name)
        result, message = tester(in_file, out_file, mode)
        if result:
            tests_passed += 1
            print ("Test Passes! for file: " + in_file)
        else:
            print("Test failed for: " + in_file)
            print(message)
        print("")
    print(str(tests_passed) + " out of " + str(len(test_files)) + " tests passed.")

if __name__ == "__main__":
    main()