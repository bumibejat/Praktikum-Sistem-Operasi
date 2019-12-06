#! /bin/bash

# Global Variable
pilihan=0; bil1=0; bil2=0; result=0
sign=0 #0->penjumlahan, 1->pengurangan, 2->perkalian, 3->pembagian
signChar="+"; globalLow=1; globalHigh=10; timesUp=0; userResult=null

function dangerMessage {
    echo "Permainan ini sangat berbahaya"
    echo "Jika seluruh kesempatan Anda telah habis"
    echo "Maka laptop Anda akan otomatis ter shutdown"
}

function showRules {
    echo "Anda memiliki 3 kesempatan untuk menjawab salah"
    echo "Level kan dimulai dari yang paling mudah"
    echo "Setiap 10 jawaban benar maka level akan ditingkatkan otomatis"
    echo "Tingkat kesulitan dipengaruhi oleh jumlah digit dan operasi aritmatika"
    echo "Anda memiliki waktu 5 detik untuk menjawab setiap soal"
}

function timer {
    let start_time="$(date +%s)";
    local limit=0
    while [ $limit -le 5 ]
    do
        let current_time="$(date +%s)"
        let seconds=$current_time-$start_time;

        echo -en "\r                                        \r"
        printf "Timer: %02d:%02d:%02d:%02d Jawaban Anda : " "$((seconds/86400))" "$((seconds/3600%24))" "$((seconds/60%60))" "$((seconds%60))"
        let limit=$limit+1
        read -t 1 userResult
        if [ ! -z "$userResult" ]
        then
            limit=6
        fi

        if [ $limit -eq 5 ]
        then
            timesUp=1
        fi
    done
}

function randomNumber {
    low=$1
    high=$2
    saveTo=$3

    case $saveTo in
        "bil1")
            bil1=$((RANDOM * ($high-$low+1) / 32768 + low))
            ;;
        "bil2")
            bil2=$((RANDOM * ($high-$low+1) / 32768 + low))
            ;;
        "sign")
            sign=$((RANDOM * ($high-$low+1) / 32768 + low))
            ;;
    esac
}

function calc {
    case $sign in
        0)
            let result=bil1+bil2
            signChar="+"
            ;;
        1)
            let result=bil1-bil2
            signChar="-"
            ;;
        2)
            let result=bil1*bil2
            signChar="*"
            ;;
        3)
            let result=bil1/bil2
            signChar="/"
            ;;
    esac
}

function levelUp {
    let globalLow=globalLow*globalHigh
    let globalHigh=globalHigh*globalHigh
}

function games {
    level=1;life=3;counter=1;number=1;surender="default";score=0
    while [ $life -gt 0 ]
    do
        randomNumber globalLow globalHigh bil1
        randomNumber globalLow globalHigh bil2
        randomNumber 0 2 sign
        calc
        echo "$number.) $bil1 $signChar $bil2 =  ";
        timer

        if [ $timesUp -eq 1 ]
        then
            echo "Waktu habis"
            let life=$life-1
            let number=$number+1
            timesUp=0
            echo "Sisa kesempatan $life"
        elif [ $userResult -eq $result ]
        then
            echo "Jawaban Benar"
            let counter=$counter+1
            let score=$score+1
            let number=$number+1
        else
            echo "Jawaban Salah"
            let life=$life-1
            let number=$number+1
            echo "Sisa kesempatan $life"
        fi

        if [ $counter -gt 10 ]
        then
            echo "Apakah Anda ingin menyerah ? (y/n) "
            read surender

            if [ "$surender" == "y" ] || [ "$surender" == "Y" ]
            then
                echo "Anda mengambil keputusan yang bijak"
                life=0
            else
                levelUp
                counter=1
            fi
        fi
    done

    unset userResult

cat >> score.txt <<EOF
$score
EOF

    if [ "$surender" == "y" ] || [ "$surender" == "Y" ]
    then
        echo "Selamat laptop Anda masih menyala"
    else
        echo "Selamat Anda tewas"
        shutdown -h now
    fi
}

function sortArray {
    local v="$1[*]"
    IFS=$'\n'
    read -d $'\0' -a "$1" < <(sort "${@:2}" <<< "${!v}")
}

function topScore {
    local counter=0
    while read score; do
        allScore[$counter]=$score
        let counter=$counter+1
    done < score.txt
    sortArray allScore -nr
    counter=0
    while [ $counter -lt 3 ]
    do
        echo "Peringkat $((counter+1)) : ${allScore[$counter]}"
        let counter=$counter+1
    done
}

while [ $pilihan -ne 3 ]
do
    echo "== Games Matematika Berbahaya =="
    echo "1. Mulai permainan"
    echo "2. Top Score Sementara"
    echo "3. Keluar Games"
    echo "Pilihan : "

    read pilihan

    case $pilihan in
        1)
            dangerMessage
            echo "Apakah Anda yakin ? (y/n)"
            read agreement
            if [ "$agreement" == "y" ] || [ "$agreement" == "Y" ]
            then
                echo "Setuju"
                games
            elif [ "$agreement" == "n" ] || [ "$agreement" == "N" ]
            then
                echo "Tidak setuju"
            else
                echo "Input yang dapat diterima adalah (y, Y, n, N)"
            fi
            ;;
        2)
            topScore
            ;;
        3)
            echo "Terima Kasih Telah Memainkan Game Ini"
            ;;
    esac
done
