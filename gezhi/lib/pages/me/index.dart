import 'package:flutter/material.dart';
import 'package:gezhi/widgets/me/top.dart';
import 'package:gezhi/widgets/me/me_item.dart';

class Me extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20,bottom: 20),
                child: Top(),
              ),
              MeItem(
                title: '账户',
                icon: Icons.perm_identity,
                url: '/me/account',
              ),
              MeItem(title: '同步', icon: Icons.cloud_queue),
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Column(
                  children: [
                    MeItem(title: '模块库', icon: Icons.dashboard,url: '/me/model',),
                    MeItem(
                      title: '提示库',
                      icon: Icons.offline_bolt,
                      url: '/me/hint_library',
                    ),
                    MeItem(title: '名言库', icon: Icons.receipt,url: '/me/famous_library',),
                  ],
                ),
              ),
              MeItem(title: '数据', icon: Icons.folder,url: '/me/data',),
              MeItem(title: '设置', icon: Icons.settings,url:'/me/setting'),
              MeItem(title: '帮助', icon: Icons.help,url:'/me/help'),
              MeItem(title: '关于', icon: Icons.error_outline,url: '/me/about',),
            ],
          ),
        ),
      ),
    );
  }
}
