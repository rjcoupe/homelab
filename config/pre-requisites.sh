#!/bin/bash

collections=(
    ansible.posix
    kubernetes.core
)

ansible-galaxy collection install $collections