import 'package:flutter/material.dart';

class MeAppbar extends StatelessWidget {
  final String tit;
  final String url;
  MeAppbar({@required this.url = '',this.tit=''});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      onTap: () => {
        if(url == ''){
          Navigator.pop(context),
        }else{
          if(url=='/home'){
            Navigator.of(context).pushNamed(url,arguments: {'currentIndex':4})
          }
        }
      },
    );
  }
}
