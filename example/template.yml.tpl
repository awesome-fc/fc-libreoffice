ROSTemplateFormatVersion: '2015-09-01'
Transform: 'Aliyun::Serverless-2018-04-03'
Resources:
  libre-svc: # service name
    Type: 'Aliyun::Serverless::Service'
    Properties:
      Description: 'fc test'
      Policies: 
        - AliyunOSSFullAccess
    libre-fun: # function name
      Type: 'Aliyun::Serverless::Function'
      Properties:
        Handler: index.handler
        Initializer: index.initializer
        Runtime: nodejs8
        CodeUri: './'
        Timeout: 60
        MemorySize: 640
        EnvironmentVariables:
          ALIBABA_CLOUD_DEFAULT_REGION: ${ALIBABA_CLOUD_DEFAULT_REGION}
          OSS_BUCKET: ${OSS_BUCKET}
          OSS_INTERNAL: 'true'

