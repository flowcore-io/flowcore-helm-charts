#!/bin/bash

path=$1
version_type=$2

# Update version in Chart.yaml file
if [ "$version_type" == "patch" ]; then
  sed -i 's/version: .*/version: '$(cat $path/Chart.yaml | grep version: | awk '{print $2}')'.1/' $path/Chart.yaml
elif [ "$version_type" == "minor" ]; then
  sed -i 's/version: .*/version: '$(echo $(cat $path/Chart.yaml | grep version: | awk '{print $2}') | awk -F '.' '{print $1 "." $2+1 "." 0}')'/' $path/Chart.yaml
else
  sed -i 's/version: .*/version: '$(echo $(cat $path/Chart.yaml | grep version: | awk '{print $2}') | awk -F '.' '{print $1+1 "." 0 "." 0}')'/' $path/Chart.yaml
fi

# Package chart
helm package $path

# Update index
helm repo index --url  https://flowcore-io.github.io/flowcore-helm-charts/ .