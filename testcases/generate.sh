#!/bin/bash
g++ -o generator -O2 generator.cpp
./generator $RANDOM $RANDOM
