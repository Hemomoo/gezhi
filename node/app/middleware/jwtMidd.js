'use strict';
const fs = require('fs');
const path = require('path');
const jwt = require('jsonwebtoken'); // 引入jsonwebtoken

module.exports = () => {
  return async function userInterceptor(ctx, next) {
    let authToken = ctx.header.authorization; // 获取header 里的authorization
    if (authToken) {
      /*
        HTTP的header项「Authorization」是在HTTP 1.0引入的，它的值的格式是类型+token，支持多种鉴权方案，bearer只是其中的一种。请求的时候需要加bearer
      */
      authToken = authToken.substring(7);
      const res = verifyToken(ctx,authToken); // 解密token
     
      // 两个的时间戳字数不一样，一个13位一个10位
      if (Date.parse(new Date()) - res.exp*1000 > 0) {
        ctx.body = {
          code: 5009,
          msg: '登录过期请重新登录',
        };
      }

      ctx.locals.userid = res.userid;
      await next();
    } else {
      ctx.body = { code: 5008, msg: '请登陆后再进行操作' };
    }
  };
};

// 解密token
function verifyToken(ctx,token) {
  const cert = fs.readFileSync(path.join(__dirname, '../public/rsa_private_key.pem'));
  // const cert = fs.readFileSync(path.join(__dirname, '../public/rsa_public_key.pem')); // 公钥，看后面生成方法,公钥私钥生成出问题 倒置无法解密 都有的一个密钥
  let res = '';
  try {
    res =  jwt.verify(token, cert) || {};
  } catch (e) {
    throw new Error(e);
    ctx.logger.error(e)
  }
  return res;
}
