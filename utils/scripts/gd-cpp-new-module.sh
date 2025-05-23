#!/bin/bash

# Scaffold a new native module

read -p "Module name: " MOD_NAME

TARGET_DIR="common/cpp/$MOD_NAME"
mkdir -p "$TARGET_DIR"

cp -r common/cpp/mynative/* "$TARGET_DIR"

sed -i "s/MyNativeThing/${MOD_NAME^}/g" "$TARGET_DIR"/*.*
mv "$TARGET_DIR/MyNativeThing.cpp" "$TARGET_DIR/${MOD_NAME^}.cpp"
mv "$TARGET_DIR/MyNativeThing.hpp" "$TARGET_DIR/${MOD_NAME^}.hpp"

echo "C++ module '$MOD_NAME' created at $TARGET_DIR"
