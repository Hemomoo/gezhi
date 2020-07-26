'use strict';

const Controller = require('egg').Controller;
require;

class HomeController extends Controller {
  async index() {
    const { ctx } = this;
    ctx.body = 'hi, egg你好啊';
  }

  async search() {
    const { ctx } = this;
    ctx.status = 201;
    await ctx.service.search.searchDiary();
    ctx.body = {
      name: 'egg',
      category: 'framework',
      language: 'Node.js',
    };
  }
  async memory() {
    // const { ctx } = this;
    // ctx.
  }
}

module.exports = HomeController;
