#!/bin/bash

declare -a mutation;
declare -a population;

mutation=('0.02' '0.1' '0.3' '0.4');
population=('100' '500' '1000');
evaluations=25000
file="fon.in";
file_aux="aux.in";
exec="nsga2r";
random_seed=0.35;

function modify_parameter_files() {
    sed "$1" $file > $file_aux;
    cat $file_aux > $file;
    rm -fr $file_aux;
}

for ((jdx=0; jdx<${#population[@]}; ++jdx)); do
    gen=$((evaluations / population[jdx]));
    for ((idx=0; idx<${#mutation[@]}; ++idx)); do
        
        folder="exp_pb_${population[jdx]}_mut_${mutation[idx]}";

        modify_parameter_files "1c${population[jdx]}"

        modify_parameter_files "2c${gen}"

        modify_parameter_files "12c${mutation[idx]}"

        ./$exec $random_seed < $file;

        rm -fr $folder;
        mkdir $folder;

        mv *.out -t $folder;
        #echo "${mutation[idx]} - $gen";
    done
done

exit 0;
