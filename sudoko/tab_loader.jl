file_path = "sudoko/sudoko_tests.txt"
tabs_file = open(file_path, "r")

file_lines = readlines(tabs_file)

tabuleiros = [[]]

num_tabuleiros = length(file_lines)÷10

for linha in 