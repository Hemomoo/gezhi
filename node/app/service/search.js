'use strict';


const Service = require('egg').Service;
const moment = require('moment');

// 一个 Service 文件只能包含一个类， 这个类需要通过 module.exports 的方式返回。
class UserService extends Service {

  // 搜索日记
  async searchDiary() {
    const res = await this.app.mysql.query('select * from diary where FIND_IN_SET("好", diary)');
    return res;
  }
  // 统计记录总共多少天
  async total() {
    const { ctx, app } = this;
    const userid = ctx.locals.userid;
    const totalDay = ctx.helper.format(await app.mysql.query('select count(1) from date'))[0]['count(1)'];
    const totalDiary = ctx.helper.format(await app.mysql.query('select count(1) from diary'))[0]['count(1)'];
    const virStartDate = ctx.helper.format(await app.mysql.select('user', {
      where: { userid },
      columns: [ 'startDate' ],
    }))[0].startDate;
    console.log('virStartDate: ', virStartDate);
    const startDate = moment(virStartDate).format('YYYY-MM-DD');
    return { totalDay, totalDiary, startDate };
  }
}

module.exports = UserService;
