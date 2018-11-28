const { convertFileToPDF } = require('fc-libreoffice');

module.exports.handler = (event, context, callback) => {
    convertFileToPDF('/tmp/example.docx')
        .then(() => callback(null, 'done'))
        .catch((e) => 
            callback(e, 'fail')
        );
};