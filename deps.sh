#!/bin/bash

if [[ "${RUNNER_OS}" == "Linux" ]]
then
  sudo apt-get -qq update
  sudo apt-get -qq install cmake jq -y
fi