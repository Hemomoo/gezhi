'use strict';
const Controller = require('egg').Controller;
const path = require('path');
const fs = require('fs');
const jwt = require('jsonwebtoken'); // 引入jsonwebtoken

class userController extends Controller {
  // 注册
  async userRegister() {
    const { ctx, app } = this;
    try {
      const errors = app.validator.validate({ name: 'string', password: {
        type: 'string',
        min: 6,
      } }, ctx.request.body);
      // 如果判断成功就是undefind
      if (errors) {
        ctx.body = { code: 0, errors };
      } else {
        const { password, name } = ctx.request.body;
        const register = await ctx.service.user.userRegister(password, name);
        // 判断是不是注册了
        if (!register) {
          ctx.body = { code: 0, res: {}, message: '账号已经被注册' };
        } else {
          ctx.body = { code: 1, res: {}, message: '账号注册成功' };
        }
      }
    } catch (error) {
      console.log('error: ', error);
    }
  }

  /* 成功会返回一个undefined*/
  // 登录
  async userLogin() {
    const { ctx, app } = this;
    const errors = app.validator.validate({ name: 'string', password: {
      type: 'string',
      min: 6,
    } }, ctx.request.body);
    const { password, name } = ctx.request.body;
    if (errors) {
      ctx.body = { code: 0, errors };
    } else {
      const login = await ctx.service.user.userLogin(password, name);
      const [ loginRes ] = login;
      const { avatar, isVip, userid } = loginRes;
      if (+login.length === 0) {
        ctx.body = { code: 0, res: '', msg: '您还没有注册' };
      } else {
        const cert = fs.readFileSync(path.join(__dirname, '../public/rsa_private_key.pem'));
        const token = jwt.sign({ userid }, cert, { expiresIn: '1h' }); // token签名 有效期为1小时
        ctx.body = {
          message: '获取token成功',
          code: 1,
          res: { token, name, avatar, isVip },
        };
      }

    }
  }


  async userIndex() {

  }


  // 提示库数据
  async tipLibrary() {
    const { ctx } = this;
    const res = await ctx.service.user.tipLibrary();
    ctx.body = res;
  }

  // 获取名人名言
  async famousRemark() {
    const { ctx } = this;
    const res = await ctx.service.user.famousRemark();
    ctx.body = {
      code: 1,
      res: res[0],
      msg: '获取名言成功',
    };
  }
}

module.exports = userController;
