# fc-libreoffice

fc-libreoffice 是一个开箱即用的 word 转 pdf NPM 包。在 [fc-docker](https://github.com/aliyun/fc-docker) 提供的 runtime-nodejs8 环境下编译，并且进行了精简，采用了压缩比最高的 Brotli 工具进行打包，最终压缩包大小为 84 M。这个大小仍然超过了 FC 50M 的代码包限制，所以采用 OSS 运行时下载并解压的方式制作了 example 工程。example 工程提供了方便的 Makefile 脚本，集成了 [fun](https://github.com/aliyun/fun) ，简单配置后可以快捷部署。

## 安装

```bash
npm install awesome-fc/fc-libreoffice#master --save
```

## 使用

```nodejs
const { convertFileToPDF } = require('fc-libreoffice');

module.exports.handler = (event, context, callback) => {
    convertFileToPDF('/tmp/example.docx', binPath)
        .then(() => {
            console.log('convert success.');
            callback(null, 'done');
        })
        .catch((e) => {
            console.log('convert success.');
            callback(e, 'fail')
        });

};
```

### 快速体验

```bash
# 克隆项目
git clone https://github.com/awesome-fc/fc-libreoffice.git

# 进入示例工程目录
cd fc-libreoffice/example

# 配置 .env 文件
cp env.example .env

# 部署函数
make deploy

# 调用函数
make invoke

# 从 OSS 下载 PDF 到当前目录，查看转换后的结果
make download
```

## 编译 libreoffice

bin 目录下已经放置了一个在 fc 环境下编译好的 lo.tar.br 打包文件，所以正常情况下不需要编译。

找一台 linux 机器，mac 下编译会有问题。预先安装好 docker 即可。

```bash
cd compile/
./build.sh
```

最终会生成 lo.tar.br 文件。

## 参考阅读

1. https://github.com/shelfio/aws-lambda-libreoffice
2. https://github.com/vladgolubev/serverless-libreoffice
3. https://github.com/shelfio/aws-lambda-brotli-unpacker