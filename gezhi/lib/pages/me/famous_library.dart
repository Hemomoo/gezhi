import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gezhi/style/style.dart';
import 'package:gezhi/widgets/me/appbar.dart';
import 'package:gezhi/widgets/common/common.dart';

class FamousLibrary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: MeAppbar(
          tit: '我',
        ),
        title: Text(
          '名言库',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            itemBuilder: (context) {
              return <PopupMenuEntry<String>>[
                _popupItem('addFamous', Icons.add_to_photos, '增加名言'),
                _popupItem('editFamous', Icons.edit, '编辑名言')
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 4, bottom: 4),
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border(
                left: BorderSide(width: 4, color: GZColors.primary),
              ),
            ),
            child: Padding(
              child: Text('默认'),
              padding: EdgeInsets.only(left: 10),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Horse,你好啊，人生啊是不是都只是这样无力啊好难啊是不是时候收购欧斯读后感省公司收购十几个十几个是杀手',maxLines: 2,overflow: TextOverflow.ellipsis,),
                  subtitle: Text('A strong animal'),
                  onTap: (){

                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return CommonWidget.divider;
              },
              itemCount: 4,
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuEntry<String> _popupItem(
    String val,
    IconData popIcon,
    String tit,
  ) {
    return PopupMenuItem<String>(
      value: 'addFamous',
      child: Chip(
        label: Text(
          tit,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        avatar: Icon(
          Icons.add_to_photos,
          color: GZColors.primary,
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }

   void  _famousHandle(){
      return 

   }

}
