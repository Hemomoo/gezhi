"use strict";


const Service = require("egg").Service;
// 一个 Service 文件只能包含一个类， 这个类需要通过 module.exports 的方式返回。

class UserService extends Service {
  // 查询用户是不是已经注册
  async userRegister(password, name) {
    const { app } = this;
    const register = await app.mysql.select("user", {
      where: { name },
    });
    if (register.length > 0) {
      return false;
    }
    await app.mysql.insert("user", {
      password,
      name,
    });
    return true;
  }

  async userLogin(password, name) {
    const { app } = this;
    // 判断是不是注册了
    const isRegister = (await +app.mysql.select("user", { name }).length) === 0;
    if (isRegister) {
      this.ctx.body = {
        code: 1,
        result: "",
        msg: "您还没有注册",
      };
    } else {
      const login = await app.mysql.select("user", {
        where: { name, password },
        columns: ["name", "avatar", "isVip", "userid"],
      });
      return login;
    }
  }

  // 查询提示库数据
  async tipLibrary() {
    const { ctx, app } = this;
    const userid = ctx.locals.userid;
    const dayRes = ctx.helper.format(
      await app.mysql.select("tiplibrary", {
        where: { date: "日", userid },
        columns: ["tip"],
      })
    );
    const weekRes = ctx.helper.format(
      await app.mysql.select("tiplibrary", {
        where: { date: "周", userid },
        columns: ["tip"],
      })
    );
    const monthRes = ctx.helper.format(
      await app.mysql.select("tiplibrary", {
        where: { date: "月", userid },
        columns: ["tip"],
      })
    );
    const yearRes = ctx.helper.format(
      await app.mysql.select("tiplibrary", {
        where: { date: "年", userid },
        columns: ["tip"],
      })
    );
    return {
      day: dayRes.map((item) => item.tip),
      week: weekRes.map((item) => item.tip),
      month: monthRes.map((item) => item.tip),
      year: yearRes.map((item) => item.tip),
    };
  }

  // 添加提示库
  async addTipLibrary(date, tip) {
    const { ctx, app } = this;
    const userid = ctx.locals.userid;
    const res = ctx.helper.format(
      await app.mysql.insert("tiplibrary", { date: date, tip: tip ,userid:userid})
    );
  }

  // 查询名言
  async famousRemark() {
    const { ctx, app } = this;
    const userid = ctx.locals.userid;
    const res = ctx.helper.format(
      await app.mysql.query(
        "SELECT * FROM famous_remark Where userid = ? ORDER BY RAND() LIMIT 1",
        [userid]
      )
    );
    return res.map((item) => item.remark);
  }




  // 插入名言
  async addFamousRemark(remark) {
    const { ctx, app } = this;
    const userid = ctx.locals.userid;
    const insetRes = ctx.helper.format(
      await app.mysql.insert("famous_remark", {
        userid: userid,
        remark: remark,
      })
    );
    return insetRes;
  }
}

module.exports = UserService;
