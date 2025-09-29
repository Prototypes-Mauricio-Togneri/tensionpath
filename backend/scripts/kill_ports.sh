#!/usr/bin/env bash

lsof -ti tcp:9099 | xargs --no-run-if-empty kill -9
lsof -ti tcp:9005 | xargs --no-run-if-empty kill -9
lsof -ti tcp:5001 | xargs --no-run-if-empty kill -9
lsof -ti tcp:8080 | xargs --no-run-if-empty kill -9
lsof -ti tcp:9199 | xargs --no-run-if-empty kill -9
lsof -ti tcp:4000 | xargs --no-run-if-empty kill -9
lsof -ti tcp:8085 | xargs --no-run-if-empty kill -9
lsof -ti tcp:9229 | xargs --no-run-if-empty kill -9