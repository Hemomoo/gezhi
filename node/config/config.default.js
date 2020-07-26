/* eslint valid-jsdoc: "off" */

'use strict';

/**
 * @param {Egg.EggAppInfo} appInfo app info
 */
module.exports = appInfo => {
  /**
   * built-in config
   * @type {Egg.EggAppConfig}
   **/
  const config = (exports = {});

  // use for cookie sign key, should change to your own and keep security
  config.keys = appInfo.name + '_1594001823203_4401';

  // add your middleware config here
  config.middleware = [ 'gzip', 'jwtMidd', 'errorHandler' ];
  config.gzip = {
    enable: false,
    threshold: 1024,
  }; // 小于 1k 的响应体不压缩

  config.jwtMidd = {
    enable: true,
    ignore: [ '/user/register/', '/user/login/' ], // 哪些请求不需要认证，需要前后都加/
  };

  // add your user config here
  const userConfig = {
    // myAppName: 'egg',
  };

  // jwt 盐的设置
  config.jwt = {
    secret: '123456',
  };
  config.security = {
  // 关闭crsf
    csrf: {
      enable: false,
      ignoreJSON: true,
    },
    domainWhiteList: [ 'http://localhost:8200' ], // 允许访问接口的白名单
  };
  // 跨域设置
  config.cors = {
    origin: '*',
    allowMethods: 'GET,HEAD,PUT,POST,DELETE,PATCH',
  };


  // 修改端口号
  config.cluster = {
    listen: {
      path: '',
      port: 7100,
      hostname: '127.0.0.1',
    },
  };

  return {
    ...config,
    ...userConfig,
  };
};
