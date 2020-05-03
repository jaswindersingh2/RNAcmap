#!/bin/bash

git clone "https://github.com/sokrypton/GREMLIN_CPP"
cd GREMLIN_CPP
g++ -O3 -std=c++0x -o gremlin_cpp gremlin_cpp.cpp -fopenmp

