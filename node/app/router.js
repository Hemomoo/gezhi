'use strict';


/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  router.get('/', controller.home.index);
  router.get('/search', controller.search.searchIndex);
  router.get('/search/total', controller.search.searchTotal);
  router.get('/search/diary', controller.search.searchDiary);
  router.post('/user/login', controller.user.userLogin);
  router.post('/user/register', controller.user.userRegister);
  // 查询提示
  router.get('/user/tipLibrary', controller.user.tipLibrary);
  // 增加提示
  router.post('/user/add/tipLibrary',controller.user.addTipLibrary)
  // 查询名言
  router.get('/user/remark', controller.user.famousRemark);
  // 增加名言
  router.post('/user/add/remark',controller.user.addFamousRemark);
};
