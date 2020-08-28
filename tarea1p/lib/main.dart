import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isPressed = true;
  int _counterClick = 0;

  Future<void> _showSelectionDialog(
      String title, String date, BuildContext ctx) async {
    await showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          title: Text("Fecha y Hora"),
          content: Text('$date'),
          actions: <Widget>[
            FlatButton(
              child: Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Material App Bar'),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: _isPressed ? Colors.white : Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _isPressed = !_isPressed;
                    _counterClick++;
                  });
                  //_showSelectionDialog("title", _scaffoldKey.currentContext);
                  _scaffoldKey.currentState.removeCurrentSnackBar();
                  if (_counterClick % 2 == 0) {
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Par'),
                      ),
                    );
                  } else {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: Text('Inpar'),
                        action: SnackBarAction(
                          label: "Dialog",
                          onPressed: () {
                            var date = new DateTime.now().toLocal();
                            _showSelectionDialog("title", date.toString(),
                                _scaffoldKey.currentContext);
                          },
                        )));
                  }
                })
          ],
        ),
        body: Center(
          child: Container(
            child: Text('Hello World $_counterClick'),
          ),
        ),
      ),
    );
  }
}
