"use strict";

const path = require("path");

function getPath() {
  const { platform, arch } = process;
  const fn = platform === 'win32' ? 'rclone.exe' : 'rclone';
  return path.join(__dirname, platform, arch, fn);
}

exports.pathRClone = getPath();