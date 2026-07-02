#!/bin/bash

## ======================================================= ##

echo "Applying application configurations..."

if [ -d "$REPO_DIR/config/autostart" ]; then
    echo "Copying Autostart configuration..."
    rm -rf "$USER_CONFIG_DIR/autostart"
    cp -r "$REPO_DIR/config/autostart" "$USER_CONFIG_DIR/"
fi

if [ -d "$REPO_DIR/config/OpenRGB" ]; then
    echo "Copying OpenRGB configuration..."
    rm -rf "$USER_CONFIG_DIR/OpenRGB"
    cp -r "$REPO_DIR/config/OpenRGB" "$USER_CONFIG_DIR/"
fi

if [ -d "$REPO_DIR/config/solaar" ]; then
    echo "Copying Solaar configuration..."
    rm -rf "$USER_CONFIG_DIR/solaar"
    cp -r "$REPO_DIR/config/solaar" "$USER_CONFIG_DIR/"
fi

## ======================================================= ##