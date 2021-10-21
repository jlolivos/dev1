#!/bin/bash

export log=audit_log.txt
export gitRepo=main 
export name=Jorge 

#1.- Create or been able to update a log file
function createLog
{
    touch $log
}

#2.- Pull the latest files of the repository
function pullFromGit
{
    git pull origin $gitRepo 
}

#2.1 Add a log: "[System Date] : [Repository_name]"
function log
{
    echo "`date `: "$gitRepo" repository succesfully updated" >> $log
}


#3. Create X number of files by reading "InputFileNames" variables separated by (,)
function createFiles
{

    # Get values from .env file
    inputFileNames=`grep -e "^InputFileNames" .env`
    echo "InputFilName: " $inputFileNames
    fileNames=`echo $inputFileNames | awk -F '=' '{print $2}'`
    echo "FileNames: " $fileNames
    path=`grep -e "^path" .env | awk -F '=' '{print $2}'`
    echo "path: " $path

    for file in `echo $fileNames | tr -s "," "\n"`
    do
        touch ./$path/$file.txt
        echo "`date` : $file.txt document created"
    done
}

createFiles
