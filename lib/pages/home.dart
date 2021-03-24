import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeStore extends ChangeNotifier {
  String _locaton = 'Tokyo';

  void notify(String location) {
    this._locaton = location;
    notifyListeners();
  }
}

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState>     _formKey     = GlobalKey<FormState>();

  final locationController = TextEditingController();

   double _iconSize = 20.0;
   double _fontSize = 15.0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeStore(),
      child:  Builder(builder: (BuildContext context) {
        final store     = Provider.of<HomeStore>(context);
        final _location = store._locaton;
        return Scaffold(
          key:       _scaffoldKey,
          endDrawer: _buildDrawer(context),
          body: Container(
             child: SvgPicture.asset(
                'images/weather-icon/wi-cloudy-gusts.svg',
                height: 200.0,
                width: 200.0,
                color: Colors.grey,
              )
          ),
         // Image(
         //   image: AssetImage('images/dog-call.png'),
         //   fit:   BoxFit.cover
         // ),
          appBar:    AppBar(
            titleSpacing: 0.0,
            centerTitle: false,
            title: Container(
              margin:  EdgeInsets.only(left: 7.0),
              child: ButtonTheme(
                child: TextButton(
                  onPressed: () async {
                    String res = await _openDialog(context);
                    store.notify(res);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Icon(Icons.place_outlined,size: _iconSize, color: Colors.grey)
                      ),
                      Container(
                        padding:  EdgeInsets.only(left: 6.0),
                        child: Text(
                          _location,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: _fontSize, color: Colors.grey)
                        ),
                      )
                    ]
                  )
                )
              )
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.menu,color: Colors.grey),
                onPressed: () => _scaffoldKey.currentState.openEndDrawer()
              )
            ],
            backgroundColor: Colors.white,
            shadowColor:     Colors.white,
          ),
        );
      })
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Los Angeles'),
            onTap: () => Navigator.pop(context)
          ),
          ListTile(
            title: Text('Honolulu'),
            onTap: () => Navigator.pop(context)
          ),
          ListTile(
            title: Text('Dallas'),
            onTap: () => Navigator.pop(context)
          ),
        ],
      ),
    );
  }

  Future<String> _openDialog(BuildContext context) {
    return showDialog(
      context:  context,
      builder:  (BuildContext context) => new Dialog(
        insetPadding: EdgeInsets.all(15),
        child: Form(
          key:   _formKey,
          child: TextFormField(
            controller:      locationController,
            textInputAction: TextInputAction.next,
            autofocus:       true,
            onChanged: (v) => print('changed'),
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.all(20),
              labelText:      'location',
              labelStyle:     TextStyle(color: Colors.grey),
              suffixIcon:     IconButton(
                icon:      Icon(Icons.arrow_right),
                onPressed: () {
                  if(this._formKey.currentState.validate()) {
                    print('aaaa');
                    this._formKey.currentState.save();
                  }
                  print('presed');
                }
              ),
            ),
            validator: (v) => v.isEmpty ? 'valid' : null,
            onSaved: (v) {
              print('saved');
              Navigator.pop(context,this.locationController.text);
            }
          ),
        )
      )
    ).then((v) => this.locationController.text);
  }
}
