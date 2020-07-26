'use strict';
const fs = require('fs');
const jwt = require('jsonwebtoken');
const path = require('path');
module.exports = {
  // 格式化mysql数据的函数
  format(paramet) {
    return JSON.parse(JSON.stringify(paramet));
  },

  // 生成token
  loginToken(data, expires = 7200) {
    const exp = Math.floor(Date.noe() / 1000) + expires;
    const cert = fs.readFileSync(path.join(__dirname, '../public/rsa_private_key.pem'));
    const token = jwt.sing({ data, exp }, cert, { algorithm: 'RS256' });
    return token;
  },
};
