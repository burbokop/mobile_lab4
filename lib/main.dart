import 'package:flutter/material.dart';
import 'package:mobile_lab4/repospage.dart';

void main() {
  runApp(MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (ctx) => HomePage(),
          "/repos": (ctx) => ReposPage(),
        }
    ),
  );
}

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => Container(
    color: Colors.deepPurple,
    padding: EdgeInsets.all(60),
    child: ElevatedButton(
      onPressed: () {
        final f = Navigator.pushNamed(context, "/repos");
        f.whenComplete(() => {
          print("push completed")
        });
      },
      child: Text("repos"),
    ),
  );
}
