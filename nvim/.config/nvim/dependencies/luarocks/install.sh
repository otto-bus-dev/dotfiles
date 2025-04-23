#!/bin/bash

# Function to clean up previous installations
cleanup_previous_installations() {
  echo "Cleaning up previous installations of Lua, LuaRocks, and jsregexp..."

  # Remove Lua
  sudo apt remove --purge -y lua5.1 lua5.1-dev lua5.3 lua5.3-dev
  sudo rm -rf /usr/local/bin/lua /usr/local/bin/luac
  sudo rm -rf /usr/local/include/lua* /usr/local/lib/liblua*

  # Remove LuaRocks
  sudo luarocks purge --force
  sudo rm -rf /usr/local/bin/luarocks /usr/local/bin/luarocks-admin

  # Remove jsregexp if it exists
  if luarocks list | grep -q jsregexp; then
    sudo luarocks remove jsregexp
  fi
}

# Clean up previous installations
cleanup_previous_installations

# Update package lists
sudo apt update

# Install dependencies
sudo apt install -y build-essential libreadline-dev wget

# Download Lua 5.1.5
wget http://www.lua.org/ftp/lua-5.1.5.tar.gz

# Verify the download
file lua-5.1.5.tar.gz

# Extract the tarball
tar -zxf lua-5.1.5.tar.gz

# Build and install Lua
cd lua-5.1.5
make linux test
sudo make install

# Verify the installation
lua -v

# Download LuaRocks
cd ..
wget https://luarocks.org/releases/luarocks-3.9.1.tar.gz

# Extract LuaRocks tarball
tar zxpf luarocks-3.9.1.tar.gz

# Build and install LuaRocks
cd luarocks-3.9.1
./configure --lua-version=5.1 --with-lua-include=/usr/local/include
make
sudo make install

# Verify LuaRocks installation
luarocks --version

# Install jsregexp using LuaRocks
luarocks install jsregexp

# Verify the installation of jsregexp
if luarocks list | grep -q jsregexp; then
  echo "jsregexp installed successfully."
else
  echo "Failed to install jsregexp."
fi

# Clean up the installation folder
cd ..
rm -rf lua-5.1.5 lua-5.1.5.tar.gz luarocks-3.9.1 luarocks-3.9.1.tar.gz

echo "Installation and cleanup completed successfully."
