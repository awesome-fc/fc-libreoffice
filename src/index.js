const {unpack} = require('@shelf/aws-lambda-brotli-unpacker');
const {execSync} = require('child_process');
const path = require('path');
const fs = require('fs');
const defaultArgs = require('./args');
const {cleanupTempFiles} = require('./cleanup');

module.exports.defaultArgs = defaultArgs;

const inputPath = path.join(__dirname, '..', 'bin', 'lo.tar.br');
const outputPath = '/tmp/instdir/program/soffice';

// see https://github.com/alixaxel/chrome-aws-lambda
module.exports.getExecutablePath = async function(binPath) {
  cleanupTempFiles();
  if(!binPath){
    binPath = inputPath;
  }
  return unpack({ binPath , outputPath});
};

/**
 * Converts a file in /tmp to PDF
 * @param {String} filePath Absolute path to file to convert located in /tmp directory
 * @return {Promise<String>} Logs from spawning LibreOffice process
 */
module.exports.convertFileToPDF = async function(filePath, binPath) {
  const binary = await module.exports.getExecutablePath(binPath);

  const logs = execSync(
    `cd /tmp && ${binary} ${defaultArgs.join(' ')} --convert-to pdf --outdir /tmp ${filePath}`
  );

  execSync(`cd /tmp && rm ${filePath}`);

  return logs.toString('utf8');
};