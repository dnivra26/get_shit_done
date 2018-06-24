import 'package:flutter/material.dart';
import 'auth.dart';
import 'home.dart';

void main() => runApp(
    MaterialApp(
      title: 'Navigation Basics',
      home: MyApp(),
    )
);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Get Shit Done',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Get Shit Done'),
        ),
        body: new Center(
          child: new RaisedButton(
            child: const Text('SignIn with Google'),
            color: Theme.of(context).accentColor,
            elevation: 4.0,
            splashColor: Colors.blueGrey,
            onPressed: () {
              var signInWithGoogle2 = signInWithGoogle();
              signInWithGoogle2.then((user) {
                  print(user.displayName);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen(userId: user.uid)),
                  );
              });
              // Perform some action
            },
          ),
        ),
      ),
    );
  }
}