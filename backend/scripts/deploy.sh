#!/usr/bin/env bash

set -e

firebase use remote
firebase deploy
firebase use local