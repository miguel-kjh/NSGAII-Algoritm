#!/bin/bash

declare -a mutation;
declare -a poblation;

mutation=('0.1' '0.3' '0.4');
poblation=('100' '500' '1000');
file="fon.in";
file_aux="aux.in";
exec="nsga2r";
random_seed=0.35;

function modify_parameter_files() {
    sed "$1" $file > $file_aux;
    cat $file_aux > $file;
    rm -fr $file_aux;
}

for ((idx=0; idx<${#mutation[@]}; ++idx)); do
    for ((jdx=0; jdx<${#poblation[@]}; ++jdx)); do
        folder="exp_pb_${poblation[idx]}_mut_${mutation[jdx]}";

        modify_parameter_files "1c${poblation[idx]}"

        modify_parameter_files "12c${mutation[jdx]}"

        ./$exec $random_seed < $file;

        rm -fr $folder;
        mkdir $folder;

        mv *.out -t $folder;
    done
done

exit 0;
