i=0
echo "Masukkan jumlah array : "
read jumlah

y=1;
while [ $jumlah -ge $y ];
do
    printf "Data ke $y \n"
    read arrayIPSMhs[$i]

    let y=$y+1
    let i=$i+1
done

x=0;
while [ $x -le $jumlah ];
do
    printf "Data ke $x = $arrayIPSMhs[$i]"
done
