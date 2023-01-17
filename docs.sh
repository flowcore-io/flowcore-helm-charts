#!/usr/bin/env bash

path=$1

echo "Generating docs for $path"

if ! command -v readme-generator &> /dev/null
then
    npm i -g @bitnami/readme-generator-for-helm
fi

readme-generator -v "$path"/values.yaml --readme "$path"/README.md