#!/bin/bash

git add --all
git commit -m `date +%F-%H-%M`
git push
