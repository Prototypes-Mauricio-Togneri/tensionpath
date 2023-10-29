#!/usr/bin/env bash

set -e

dart compile exe lib/main/main.dart -o output/tensionpath
scp -s output/tensionpath max@zeronest.com:/home/max