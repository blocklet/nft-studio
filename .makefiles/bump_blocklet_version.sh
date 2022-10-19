#!/bin/bash

NEW_VERSION=$(cat version | awk '{$1=$1;print}')

cd blocklets/did-storage && blocklet version $NEW_VERSION && git add blocklet.yml && cd ../../
cd blocklets/storage-consumer-demo && blocklet version $NEW_VERSION && git add blocklet.yml && cd ../../
cd blocklets/storage-debugger && blocklet version $NEW_VERSION && git add blocklet.yml && cd ../../

cd website/pages && blocklet version $NEW_VERSION && git add blocklet.yml && cd ../../
cd website/docs && blocklet version $NEW_VERSION && git add blocklet.yml && cd ../../

echo "bump to version $NEW_VERSION successfully"
