#! /bin/bash

pilihan=0

luasKubus=0
luasPrisma=0
luasLimas=0

function kubus {
    echo "Masukkan panjang rusuk : ";
    read rusuk
    let luasKubus=6*rusuk*rusuk
    echo "Luas permukaan kubus adalah $luasKubus"
}

function prisma {
    echo "Masukkan panjang selimut : ";
    read panjangPersegiPanjang
    echo "Masukkan lebar selimut : ";
    read lebarPersegiPanjang
    echo "Masukkan tinggi segitiga : ";
    read tinggiSegitiga
    echo "Masukkan alas segitiga : ";
    read alasSegitiga
    let luasSegitiga=alasSegitiga*tinggiSegitiga/2
    let luasPersegiPanjang=panjangPersegiPanjang*lebarPersegiPanjang
    let luasPrisma=2*luasSegitiga+3*luasPersegiPanjang
    echo "Luas permukaan prisma segitiga adalah $luasPrisma"
}

function limas {
    echo "Masukkan panjang rusuk alas : "
    read rusukAlas
    echo "Masukkan tinggi limas : "
    read tinggiLimas
    let luasAlas=rusukAlas*rusukAlas
    let luasSisiTegak=rusukAlas*tinggiLimas/2
    let luasSisiTegak=4*luasSisiTegak
    let luasLimas=luasSisiTegak+luasAlas
    echo "Luas permukaan limas persegi adalah $luasLimas"
}

function median {
    if [ $luasKubus -ne 0 ] && [ $luasLimas -ne 0 ] && [ $luasPrisma -ne 0 ]
    then
        max=$luasKubus
        if [ $max -lt $luasPrisma ]
        then
            max=$luasPrisma
        fi

        if [ $max -lt $luasLimas ]
        then
            max=$luasLimas
        fi

        max1=0
        if [ $max1 -lt $luasKubus ] && [ $luasKubus -lt $max ]
        then
            max1=$luasKubus
        fi

        if [ $max1 -lt $luasPrisma ] && [ $luasPrisma -lt $max ]
        then
            max1=$luasPrisma
        fi

        if [ $max1 -lt $luasLimas ] && [ $luasLimas -lt $max ]
        then
            max1=$luasLimas
        fi

        echo "terbesar $max, data median $max1"
    else
        echo "ada data yang kosong"
    fi
}

while [ $pilihan -ne 5 ]
do
    echo "== Program Luas Permukaan Bangun Datar =="
    echo "1. Menghitung luas permukaan kubus"
    echo "2. Menghitung luas permukaan prisma segitiga (sama sisi)"
    echo "3. Menghitung luas permukaan limas persegi"
    echo "4. Mendapatkan nilai tengah(median) dari ketiga luas permukaan"
    echo "5. Keluar Program"
    echo "Pilihan : "

    read pilihan

    case $pilihan in
        1)
            kubus
            ;;
        2)
            prisma
            ;;
        3)
            limas
            ;;
        4)
            median
            ;;
        5)
            echo "Terima Kasih Telah Menggunakan Program Ini"
            ;;
    esac
done
