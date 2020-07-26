// 启动自定义
/*
    配置文件即将加载，这是最后动态修改配置的时机（configWillLoad）
    配置文件加载完成（configDidLoad）
    文件加载完成（didLoad）
    插件启动完毕（willReady）
    worker 准备就绪（didReady）
    应用启动完成（serverDidReady）
    应用即将关闭（beforeClose）

*/


class AppBotHook{
    constructor(app){
        this.app =app;
    }

    //  配置文件即将加载，这是最后修改配置的时机
    configWillLoad(){

    }

    


    // 文件加载完成
    async didLoad() {

    }

    async willReady() {

    }
    // 应用启动完成
    async didReady() {}

    // service 启动
    async serverDidReady() {
        // http / https server 已启动，开始接受外部请求
        // 此时可以从 app.server 拿到 server 的实例
    
        this.app.server.on('timeout', socket => {
          // handle socket timeout
        });
      }
}