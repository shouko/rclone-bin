#!/usr/bin/env bash

function find_node_arch () {
  case "$1" in
    "amd64" ) retval="x64" ;;
    "386" ) retval="ia32" ;;
    * ) retval="$1" ;;
  esac
}

function find_node_platform () {
  case "$1" in
    "windows" ) retval="win32" ;;
    "osx" ) retval="darwin" ;;
    * ) retval="$1" ;;
  esac
}

function find_bin_basename () {
  case "$1" in
    "windows" ) retval="rclone.exe" ;;
    * ) retval="rclone" ;;
  esac
}

get_binary () {
  _version="$1"
  _platform="$2"
  _arch="$3"
  find_node_platform "$_platform"
  _platform_node="$retval"
  find_node_arch "$_arch"
  _arch_node="$retval"
  _bin_dirname="rclone-$_version-$_platform-$_arch"
  _bin_dirname_final="./$_platform_node/$_arch_node"
  find_bin_basename "$_platform"
  _bin_basename="$retval"
  _bin_path="$_bin_dirname/$_bin_basename"
  _bin_path_final="$_bin_dirname_final/$_bin_basename"
  _zip_basename="$_bin_dirname.zip"
  _zip_url="https://downloads.rclone.org/$_version/$_zip_basename"
  curl -O "$_zip_url"
  unzip -o "$_zip_basename"
  mkdir -p "$_bin_dirname_final/"
  mv "$_bin_path" "$_bin_dirname_final/"
  chmod +x "$_bin_path_final"
}

_version="v1.53.3"

get_binary $_version windows amd64
get_binary $_version windows 386
get_binary $_version osx amd64
get_binary $_version linux amd64
get_binary $_version linux 386
get_binary $_version linux arm64