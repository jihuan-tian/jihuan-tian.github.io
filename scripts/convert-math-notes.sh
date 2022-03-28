#!/bin/bash

gawk -i inplace -f ../scripts/latex-to-md.awk "$1"
