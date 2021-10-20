#!/bin/bash

export log=audit_log.txt
export gitRepo=main
export name=Filiberto

#1.- Create or been able to update a log file with the next name audit_log.txt
function createLog { 
touch $log
}

#2.- Pull the latest files of the repository.
function pullFromGit { 
git pull origin $gitRepo
}

#2.1 - Add a log:  “[System Date] : [Repository_name] repository successfully updated”
function log { 
echo "`date`: "$gitRepo" repository successfully updated" >> $log
}

function getInputFileNames {
export inputFileNames=`grep -e "^InputFileNames" .env`
}

#3.- Create X number of files by reading “InputFileNames” variables separated by (,) the files should have .txt extension example “manzana.txt”
function createFiles {
export fileNames=`echo $inputFileNames | awk -F '=' '{print $2}'`
for file in `echo $fileNames | tr -s "," "\n"`
	do
		touch $path/$file.txt
		#3.3 - Add a log for each document created:  “[System Date] : [File_name] document created”
		echo "`date` : $file.txt document created" >> $log
	done
}

#3.1- Each file should contain a random 8-digit Hexadecimal (Hex) number
function fillFiles {
for file in `echo $fileNames | tr -s "," "\n"`
	do
		generateRandNumber
		echo $randNumber > $path/$file.txt
	done

}


#3.2- Each file should be saved on the “path” described in the .env file.
function getPath {
path=`grep -e "^path" .env | awk -F '=' '{print $2}'`
}

#4.- Change permission to all files under “path” to 777
function changePermissions {
output=`chmod -R 777 $path`
#4.1 – Add a log: “[System Date] :[System output of the change permissions command]”
echo "`date` : "$output"" >> $log
}

function generateRandNumber {
export randNumber=`hexdump -n 8 -v -e '8/1 "%02X" "\n"' /dev/urandom`
}

function getRenName {
	export renName=`grep -e "^OutputFile" .env | awk -F '=' '{print $2}'`
}

#5.- Change all file names with the name from the variable “OutputFile” and add a counter that starts with zero at the end of the name, example: new_name0.txt,  new_name1.txt and so on.
function renameFiles {
export c=0
getRenName
for f in `ls $path/*.txt`
	do
		mv $f $path/$renName$c.txt 
		#5.1- Add a log for each name been changed: “[System Date]: [Old_File_name] rename to [New_File_Name] “
		echo "`date` : $f renamed to $renName$c.txt" >> $log
		let "c=$c+1"
done
}

#7.-Create a local branch based of master and named: “Exam-YourFirstName”
function createBranch {
git branch Exam-$name
}

#6.-Add all files to a commit
function stageFiles {
export gitOutput=`git add .`
#6.1 - Add a log: “[System Date]: [SystemOutPutOfTheCommitFilesCommand]”
echo "`date` : $gitOutput" >> $log
}

function commit {
#7.- Commit your changes and add to the commit description: “Exam perform by [Add your name here] “
git commit -m "Exam performed by $name"
}

function push {
#8.- Push your new branch to the remote repository
export gitPushOutput=`git push origin Exam-$name`
#8.1 – Add a log: “[System Date]: [SystemOutPutOfThePushBranchCommand]”
echo "`date`: $gitPushOutput" >> $log
}

function printLog {
cat $log
}

createLog $log
pullFromGit $gitRepo
log $gitRepo $log
getInputFileNames
getPath
createFiles
fillFiles
changePermissions
renameFiles
createBranch
stageFiles
commit
push
printLog

