#!/bin/bash

log="audit_log.txt"
gitrepo="main"
name="Jorge"

# Create a log file named: audit_log.txt
function createLog
{
    touch $log
}

# Get git status
function getStatus
{
    gitOutput=`git status`
    echo "`date` : $gitOutput" >> $log
}
# Pull the latest file of the repository
function pullFromGit
{
    gitOutput="`git pull origin` $gitrepo"
    echo "`date` : $gitOutput" >> $log 
}

function pushtoGit
{
    gitOutput="`git add .`"
    echo "`date` : $gitOutput" >> $log 
    mesg="Changes updated by $name"
    #git commit -m "Changes updated by $name"
    gitOutput="`git commit -m "$mesg"`"
    echo "`date` : $gitOutput" >> $log 
    gitOutput="`git push origin` $gitrepo"
    echo "`date` : $gitOutput" >> $log 
}


## Main ##
echo "Creating log"
createLog 
echo "Pulling files from git repository"
pullFromGit $gitrepo
echo "Get status"
getStatus  
pushtoGit 