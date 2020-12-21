#!/bin/bash

declare -a mutation;
declare -a poblation;

mutation=('0.2' '0.3' '0.4' '0.5' '0.1');
poblation=('100' '100' '200' '300' '1000');
file="fon.in";
file_aux="aux.in";
exec="nsga2r";
random=0.35;

for ((idx=0; idx<${#mutation[@]}; ++idx)); do
    folder="exp_pb_${poblation[idx]}_mut_${mutation[idx]}";

    sed "1c${poblation[idx]}" $file > $file_aux;
    cat $file_aux > $file;
    rm -fr $file_aux;

    sed "12c${mutation[idx]}" $file > $file_aux;
    cat $file_aux > $file;
    rm -fr $file_aux;

    ./$exec 0.35 < $file;

    rm -fr $folder;
    mkdir $folder;

    mv *.out -t $folder;
done

exit 0;
