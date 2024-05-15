#!/bin/bash

path=$1
version_type=$2

echo "Linting $path with test values"
helm lint --debug --values "$path"/tests/test-values.yaml "$path"

# If linting fails, exit
if [ $? -ne 0 ]; then
  echo "Linting failed"
  exit 1
fi

echo "Deploying new $version_type for $path"

# Update version in Chart.yaml file
if [ "$version_type" == "patch" ]; then
  newVersion=$(echo $(cat "$path"/Chart.yaml | grep version: | awk '{print $2}') | awk -F '.' '{print $1 "." $2 "." $3+1}')

  echo "New version: $newVersion"

  sed -i.bak "s/^version:.*/version: $newVersion/" "$path"/Chart.yaml
  rm "$path"/Chart.yaml.bak
elif [ "$version_type" == "minor" ]; then
  newVersion=$(echo $(cat "$path"/Chart.yaml | grep version: | awk '{print $2}') | awk -F '.' '{print $1 "." $2+1 "." 0}')

  echo "New version: $newVersion"

  sed -i.bak "s/^version:.*/version: $newVersion/" "$path"/Chart.yaml
  rm "$path"/Chart.yaml.bak
else
  newVersion=$(echo $(cat "$path"/Chart.yaml | grep version: | awk '{print $2}') | awk -F '.' '{print $1+1 "." 0 "." 0}')

  echo "New version: $newVersion"

  sed -i.bak "s/^version:.*/version: $newVersion/" "$path"/Chart.yaml
  rm "$path"/Chart.yaml.bak
fi

# Package chart
helm package "$path"

# Update index
helm repo index --url https://flowcore-io.github.io/flowcore-helm-charts/ .
