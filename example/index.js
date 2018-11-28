const { convertFileToPDF } = require('fc-libreoffice');
var co = require('co');
const OSS = require('ali-oss');

const binPath = '/tmp/lo.tar.br';

module.exports.initializer = (context, callback) => {

    const store = new OSS({
        region: process.env.LIBREOFFICE_REGION,
        bucket: process.env.LIBREOFFICE_BUCKET,
        accessKeyId: context.credentials.accessKeyId,
        accessKeySecret: context.credentials.accessKeySecret,
        stsToken: context.credentials.securityToken
    });

    co(store.get('lo.tar.br', binPath)).then(function (val) {
        callback(null, val)
    }).catch(function (err) {
        callback(err)
    });
};

module.exports.handler = (event, context, callback) => {
    convertFileToPDF('/tmp/example.docx', binPath)
        .then(() => callback(null, 'done'))
        .catch((e) =>
            callback(e, 'fail')
        );
};