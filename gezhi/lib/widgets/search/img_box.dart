import 'package:flutter/material.dart';
import 'package:gezhi/widgets/search/top.dart';

class ImgBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(14)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [Top(title: '图库', num: 123, url: '/search/img_list'), _img(context)],
        ),
      ),
    );
  }

  Widget _img(context) {
    return Container(
      height: (MediaQuery.of(context).size.width - 20) / 2,
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width - 20) / 2,
            child: Image.network('https://cdn.pixabay.com/photo/2020/04/25/18/45/robinia-5092118_960_720.jpg',
                height: (MediaQuery.of(context).size.width - 20) / 2, fit: BoxFit.cover),
          ),
          Container(
            width: (MediaQuery.of(context).size.width - 20) / 2,
            child: Container(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 20) / 4,
                        height: (MediaQuery.of(context).size.width - 20) / 4,
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2020/04/25/18/45/robinia-5092118_960_720.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 20) / 4,
                        height: (MediaQuery.of(context).size.width - 20) / 4,
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2020/04/25/18/45/robinia-5092118_960_720.jpg',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 20) / 4,
                        height: (MediaQuery.of(context).size.width - 20) / 4,
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2020/04/25/18/45/robinia-5092118_960_720.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width - 20) / 4,
                        height: (MediaQuery.of(context).size.width - 20) / 4,
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2020/04/25/18/45/robinia-5092118_960_720.jpg',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
