#!/bin/bash

version=${1:=latest}

apt-get update
apt-get install libeigen3-dev cmake -y

time=$(date)
echo "::set-output name=time::$time"

eigen3_dir=$(cmake --find-package -DNAME=Eigen3 -DCOMPILER_ID=GNU -DLANGUAGE=C -DMODE=COMPILE)

echo "Eigen3_DIR=${eigen3_dir:2}" >> "${GITHUB_ENV}"