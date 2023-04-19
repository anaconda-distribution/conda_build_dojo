#!/bin/bash

alias ll="ls -la"

cd /conda_build_dojo

conda update conda -y
conda install tabulate -y

pip install -e .

echo "All set!"
