import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: _buildHeader(),
      endDrawer: _buildDrawer(),
    );
  }

  // ScaffoldKeyの理解がまだまだ甘い
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'My App',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Los Angeles'),
            onTap: () {
              _closeEndDrawer();
            },
          ),
          ListTile(
            title: Text('Honolulu'),
            onTap: () {
              _closeEndDrawer();
            },
          ),
          ListTile(
            title: Text('Dallas'),
            onTap: () {
              _closeEndDrawer();
            },
          ),
          ListTile(
            title: Text('Seattle'),
            onTap: () {
              _closeEndDrawer();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return AppBar(
      leadingWidth:    100,
      leading:         _buildIconButton(),
      actions: [
        IconButton(
          icon: Icon(Icons.menu,color: Colors.grey),
          onPressed: () => _scaffoldKey.currentState.openEndDrawer()
        )
      ],
      backgroundColor: Colors.white,
      shadowColor:     Colors.white,
    );
  }

  Widget _buildIconButton() {
    const icon_size = 20.0;
    const font_size = 15.0;
    return ButtonTheme(
        minWidth: 100,
        child: TextButton(
          onPressed: () => print('touched leading icon'),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize:  MainAxisSize.max,
            children: [
              // https://aimana-it.com/widget-of-the-week-35-spacer/
              Spacer(),
              Icon(Icons.place_outlined,size: icon_size, color: Colors.grey),
              Spacer(),
              Text(
                "Tokyo",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: font_size, color: Colors.grey)
              ),
              Spacer(),
            ]
          )
        )
    );
  }
}
