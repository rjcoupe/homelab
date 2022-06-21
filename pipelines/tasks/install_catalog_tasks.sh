#!/bin/bash

tasks=(
    https://github.com/tektoncd/catalog/raw/main/task/git-clone/0.6/git-clone.yaml
    https://github.com/tektoncd/catalog/raw/main/task/terraform-cli/0.2/terraform-cli.yaml
    kubernetes.core
)

kubectl apply -f $tasks