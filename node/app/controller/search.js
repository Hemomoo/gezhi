'use strict';

const Controller = require('egg').Controller;

class SearchController extends Controller {
  async searchIndex() {
   console.log('12121');
    // const { ctx } = this;
    // const res = await ctx.service.search.total();
    // ctx.body = {
    //   status: 200,
    //   res,
    // };
  }

  // 搜索统计
  async searchTotal() {
    const { ctx } = this;
    const res = await ctx.service.search.total();
    console.log('res: ', res);
    ctx.body = {
      status: 200,
      res,
    };
  }

  // 搜索返回的数据
  async searchDiary() {
    const { ctx } = this;
    const res = await ctx.service.search.searchDiary();
    ctx.body = res;
  }
}

module.exports = SearchController;
