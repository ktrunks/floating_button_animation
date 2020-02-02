import 'package:flutter/material.dart';

class Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {

  Tween<Offset> tween = Tween<Offset>(
    begin: Offset(0.0, 10000.0),
    end: Offset(0.0, 0.0),
  );
  Animation<Offset> animation;
  AnimationController animationController;
  double bottomPosition = 100.0;

  @override
  void initState() {
    super.initState();
    animation = tween.animate(animationController);
    Future.delayed(const Duration(milliseconds: 500), () {
      bottomPosition = 150.0;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.0),
        body: Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Column(
                children: [
                  Expanded(child: Container()),
                  FloatingActionButton(
                    splashColor: Colors.blue,
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    heroTag: 'icon',
                    onPressed: () {
                      bottomPosition = 100.0;
                      setState(() {});
                      Future.delayed(const Duration(milliseconds: 550), () {
                        onClosePressed();
                      });
                    },
                    child: Icon(Icons.close),
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 60, right: 60),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Create',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                onClosePressed();

                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.album),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Post',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                onClosePressed();
                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.album),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Organization',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                onClosePressed();

                              },
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.album),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    'Event',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
                bottom: bottomPosition,
              ),
            ],
          ),
        ));
  }



  void onClosePressed() {
    Navigator.pop(context);
  }
}


