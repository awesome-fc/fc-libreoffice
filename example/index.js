const { convertFileToPDF } = require('fc-libreoffice');
const { execSync } = require('child_process');
const co = require('co');
const OSS = require('ali-oss');
const fs = require('fs');

const binPath = '/tmp/lo.tar.br';

var store;

module.exports.initializer = (context, callback) => {

    store = new OSS({
        region: process.env.LIBREOFFICE_REGION,
        bucket: process.env.LIBREOFFICE_BUCKET,
        accessKeyId: context.credentials.accessKeyId,
        accessKeySecret: context.credentials.accessKeySecret,
        stsToken: context.credentials.securityToken
    });

    if (fs.existsSync(binPath) === true) {
        callback(null, "already downloaded.");
        return;
    }

    co(store.get('lo.tar.br', binPath)).then(function (val) {
        callback(null, val)
    }).catch(function (err) {
        callback(err)
    });
};

module.exports.handler = (event, context, callback) => {
    execSync('cp /code/example.docx /tmp/example.docx');

    convertFileToPDF('/tmp/example.docx', binPath)
        .then(() => {
            co(store.put('example.pdf', '/tmp/example.pdf'))
                .then((val) => callback(null, val))
                .catch((err) => callback(err));
        })
        .catch((e) =>
            callback(e, 'fail')
        );

};