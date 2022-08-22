#!/bin/bash

rm -rf build/*

echo "    Building Scorpion..."
cd ../../../../src/planners/scorpion
./build.py
cd ../../../external/submission/solver/custom
cp -rf ../../../../src/planners/scorpion build/fd

echo "    Building SymK..."
cd ../../../../src/planners/symk
./build.py
cd ../../../external/submission/solver/custom
cp -rf ../../../../src/planners/symk build/symk

if [ "$1" == "shortest" ]; then
    echo
    echo "    Building the shortest-path solver..."
    echo

    cp -rf ../../../../src/shortest-path build/shortest
    cp -rf ../../../../src/planners/numeric-abstractions/mip build/mip
    cp run-shortest.sh build/run.sh
    cp planner-shortest.sh build/shortest/plan-sas.sh
elif [ "$1" == "longest" ]; then
    echo
    echo "    Building the longest-path solver..."
    echo

    cp -rf ../../../../src/shortest-path build/longest
    cp run-longest.sh build/run.sh
    cp planner-longest.sh build/longest/plan-sas.sh
else
    echo "Unknown solver type: $1"
    exit 1
fi
