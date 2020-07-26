'use strict';


/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller } = app;
  router.get('/', controller.home.index);
  router.get('/search', controller.search.searchIndex);
  router.get('/search/total', controller.search.searchTotal);
  router.get('/user', controller.user.userIndex);
  router.post('/user/login', controller.user.userLogin);
  router.post('/user/register', controller.user.userRegister);
  router.get('/user/tipLibrary', controller.user.tipLibrary);
  router.get('/user/remark', controller.user.famousRemark);
};
