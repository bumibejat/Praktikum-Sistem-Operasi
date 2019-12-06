#!/bin/bash

echo -n "Masukkan Batas : ";
read batas;

for ((angka=1; angka<=$batas; angka=angka+1))
do
	if [ $(($angka % 3)) -eq 0 ] && [ $(($angka % 5)) -eq 0 ]
	then
		echo "FizzBuzz"
	elif [ $(($angka % 3)) -eq 0 ]
	then
		echo "Fizz"
	elif [ $(($angka % 5)) -eq 0 ]
	then
		echo "Buzz"
	else
		echo $angka
	fi
done
