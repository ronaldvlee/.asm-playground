# Author: Ronald Lee
# Email: ronaldvlee@csu.fullerton.edu

# ; Shell script to run program
# ; Copyright (C) 2023 Ronald Lee

# ; This program is free software: you can redistribute it and/or modify
# ; it under the terms of the GNU General Public License as published by
# ; the Free Software Foundation, either version 3 of the License, or
# ; (at your option) any later version.

# ; This program is distributed in the hope that it will be useful,
# ; but WITHOUT ANY WARRANTY; without even the implied warranty of
# ; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# ; GNU General Public License for more details.

# ; You should have received a copy of the GNU General Public License
# ; along with this program.  If not, see <https://www.gnu.org/licenses/>.

#Clear any previously compiled outputs
rm *.o
rm *.out

echo "Assemble faraday.asm"
nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm

echo "Assemble isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "compile ampere.cpp using gcc compiler standard 2020"
g++ -c -m64 -Wall -o ampere.o ampere.cpp -fno-pie -no-pie -std=c++17 -lstdc++

echo "Link object files using the gcc Linker standard 2020"
g++ -m64 -no-pie -o main.out faraday.o ampere.o isfloat.o -std=c++17

echo "Run the Program:"
./main.out

# For cleaner working directory, you can:
rm *.lis
rm *.o
rm *.out

echo "Script file terminated."