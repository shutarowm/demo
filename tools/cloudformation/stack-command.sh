#!/bin/bash

dir=$(cd $(dirname $0);pwd;)

project='spring-cicd'
command=$1
tmpIFS=$IFS
IFS='/' target=(${2})
IFS=$tmpIFS

path=''
stack=$project
for text in ${target[@]}; do
    if [[ $text =~ ^[^~.[:space:]]+$ ]]; then
        path=$path/$text
        stack=$stack-$text
    fi
done;

if [ $command = 'create' ]; then
    aws cloudformation create-stack \
        --stack-name $stack \
        --template-body file://$dir$target.yaml \
        --parameters \
            ParameterKey=ProjectName,ParameterValue=$project \
        --capabilities CAPABILITY_NAMED_IAM
elif [ $command = 'delete' ]; then
    aws cloudformation delete-stack \
        --stack-name $stack
else
    echo 'command not exists.'
fi