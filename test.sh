#! /bin/bash

echo "Hello World"
touch created_using_vscode.txt
mkdir new_dir
mv created_using_vscode.txt new_dir
cd new_dir
echo "The test was succesful" > created_using_vscode.txt
cat created_using_vscode.txt
number=30
echo $number
echo {1..10}
echo "What's your name?"
read name

echo "Hello, $name!. Nice to meet you"