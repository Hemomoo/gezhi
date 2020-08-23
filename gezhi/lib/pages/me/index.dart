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
              Top(),
              MeItem(
                title: '账户',
                icon: Icons.perm_identity,
                url: '/me/account',
              ),
              MeItem(title: '同步', icon: Icons.cloud_queue),
              MeItem(title: '模块库', icon: Icons.perm_identity),
              MeItem(
                title: '提示库',
                icon: Icons.offline_bolt,
                url: '/me/hint_library',
              ),
              MeItem(title: '名言库', icon: Icons.perm_identity),
              MeItem(title: '数据', icon: Icons.supervised_user_circle),
              MeItem(title: '设置', icon: Icons.settings),
              MeItem(title: '帮助', icon: Icons.subject),
              MeItem(title: '关于', icon: Icons.error_outline),
            ],
          ),
        ),
      ),
    );
  }
}
