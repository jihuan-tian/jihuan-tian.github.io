#!/bin/bash

gawk -i inplace '{gsub(/\$/, "$$"); gsub(/\$\$\$\$/, "$$"); print}' "$1"
