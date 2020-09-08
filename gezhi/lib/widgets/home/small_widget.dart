import 'package:flutter/material.dart';

class TestAnimation extends StatefulWidget {
  @override
  _TestAnimationState createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _animation = IntTween(begin: 0, end: 80).animate(_animationController);
    _animation.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          if (_animationController.value == 0.0) {
                            _animationController.forward();
                          } else {
                            _animationController.reverse();
                          }
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.settings), onPressed: (){ })
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: _animation.value,
            child: SizedBox(
              width: 0.0,
              child: GestureDetector(
                child: Container(
                  child: FittedBox(
                    //Add this
                    child: Text(
                      "Right",
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
