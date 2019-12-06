#! /bin/bash

pilihan=0

while [ $pilihan -ne 4 ]
do
    echo "== Program Nilai Terbesar Kedua di dalam Array =="
    echo "1. Demo Program Utama"
    echo "2. Lihat Data Array"
    echo "3. Pemjumlahan Data Array"
    echo "4. Exit"
    echo "Pilihan : "

    read pilihan

    case $pilihan in
        1)
            echo "Masukkan banyak elemen array : "
            read max
            for ((angka=0; angka<$max; angka=angka+1))
            do
                printf "Index Array - $angka : "
                read inputan
                utang[$angka]=$inputan
            done
            max=0
            max2=0
            index=0
            iter=0
            for perulangan in ${utang[@]}
            do
                if [ $perulangan -gt $max ]
                then
                    max=$perulangan
                fi
                let iter=$iter+1
            done
            iter=0
            for perulangan in ${utang[@]}
            do
                if [ $perulangan -lt $max ] && [ $perulangan -gt $max2 ]
                then
                    max2=$perulangan
                    index=$iter
                fi
                let iter=$iter+1
            done
            printf "Nilai terbesar kedua di dalam array adalah : ${utang[index]}\n"
            printf "Index array ke : $index\n"
            ;;
        2)
            if [ "${#utang[@]}" -ne 0 ]
            then
                echo "${utang[@]}"
            else
                echo "Data array masih kosong"
            fi
            ;;
        3)
            if [ "${#utang[@]}" -ne 0 ]
            then
                for perulangan in ${utang[@]}
                do
                    let sum=sum+$perulangan
                done
                echo "Jumlah all data array : $sum"
            else
                echo "Data array masih kosong"
            fi
            ;;
        4)
            echo "Terima Kasih Telah Menggunakan Program Ini"
            ;;
    esac
done
