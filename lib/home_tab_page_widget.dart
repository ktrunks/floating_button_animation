import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

import 'floating_button_options.dart';

class HomeTabPageWidget extends StatefulWidget {
  const HomeTabPageWidget({
    Key key,
  }) : super(key: key);

  @override
  _HomeTabPageWidget createState() => new _HomeTabPageWidget();
}

class _HomeTabPageWidget extends State<HomeTabPageWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool boostConsoleSelected = false;

  final Duration animationDuration = Duration(minutes: 2);
  final Duration delay = Duration(milliseconds: 500);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  var rect;

  @override
  void initState() {
    super.initState();
    rect = RectGetter.getRectFromKey(rectGetterKey);
    _tabController = new TabController(vsync: this, length: 5, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: RectGetter(
              key: rectGetterKey,
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                heroTag: 'icon',
                onPressed: () => onClickOfFloatingActionButton(context),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Center(
                      child: Text('test'),
                    ),
                    Center(
                      child: Text('test'),
                    ),
                    Center(
                      child: Text('test'),
                    ),
                    Center(
                      child: Text('test'),
                    ),
                    Center(
                      child: Text('test'),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
              Material(
                  elevation: 20,
                  child: TabBar(
                    onTap: (data) {
//                      homeProvider.updateFloatingActionButton(data);
                    },
                    controller: _tabController,
                    indicatorColor: Colors.yellow,
                    tabs: <Tab>[
                      Tab(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.blue,
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.menu, color: Colors.blue),
                      ),
                      Tab(
                        icon: Icon(Icons.menu, color: Colors.blue),
                      ),
                      Tab(
                        icon: Icon(Icons.menu, color: Colors.blue),
                      ),
                      Tab(
                        icon: Icon(Icons.menu, color: Colors.blue),
                      ),
                    ],
                  ))
            ],
          ),
        ),
        rect != null ? _ripple() : Container()
      ],
    );
  }

  void onClickOfFloatingActionButton(context) {
    rect = RectGetter.getRectFromKey(rectGetterKey);

    rect = rect.inflate(1.2 * MediaQuery.of(context).size.longestSide);

    setState(() {});

    Future.delayed(animationDuration + delay, _goToNextPage(context));
    debugPrint('on click of floating action button ');
  }

  _goToNextPage(context) {
    /*Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => NewPage()));*/
    Navigator.of(context).push(FadeRouteBuilder(page: Page())).then((_) {
      rect = null;
      setState(() {});
      debugPrint('on page pop data  -- from pop --- $_');
    });
  }

  Widget _ripple() {
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top + 200,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topCenter,
              end: Alignment.center,
              // Add one stop for each color. Stops should increase from 0 to 1
              stops: [
                0.0,
                0.5,
                0.8,
              ],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.white.withOpacity(0.0),
                Colors.blue,
                Colors.blue,
              ],
            )),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          opaque: false,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
