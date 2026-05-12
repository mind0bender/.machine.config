#!/bin/bash

git clone https://github.com/Sycorlax/Meowdo.git

cd Meowdo || exit

make

if [ -f meowdo ]; then
    sudo mv meowdo /usr/local/bin/
    echo "Successfully installed meowdo to /usr/local/bin"
else
    echo "Error: Binary 'meowdo' not found. Please check the compilation output."
fi

