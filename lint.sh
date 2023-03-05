#!/bin/bash

path=$1

echo "Linting $path with test values"
helm lint --debug --values "$path"/tests/test-values.yaml "$path"