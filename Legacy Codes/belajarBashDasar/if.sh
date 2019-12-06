#!/bin/bash

echo "Masukkan 1 Angka"

read a
b=10

if [ $a == $b] then
	echo "A Sama Dengan B"
elif [$a -gt $b] then
	echo "A lebih besar dari B"
elif [$a -lt $b] then
	echo "A lebih keci dari B"
else
	echo "Tidak valid"
fi
