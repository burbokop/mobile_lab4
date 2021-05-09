

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_lab4/repository.dart';

class ReposPage extends StatefulWidget {
  @override
  _ReposPageState createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> with SingleTickerProviderStateMixin {
  List<Repository> _repositories = [];
  String _status = 'no status';
  final _userNameController = TextEditingController();

  Animation<double> _animation;
  AnimationController _animationController;

  double _textInputWidth = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // #docregion addListener
    _animation = Tween<double>(begin: 0, end: 200).animate(_animationController)
      ..addListener(() {
        setState(() {
          _textInputWidth = _animation.value;
        });
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
          color: Colors.deepPurple,
          padding: EdgeInsets.fromLTRB(0, 32, 0, 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("home"),
                      ),
                      Container(
                        width: _textInputWidth,
                        height: 50,
                        alignment: Alignment.center,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'github user',
                          ),
                          controller: _userNameController,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final username = _userNameController.text;
                          final response = http.get(Uri.https('api.github.com', '/users/$username/repos'));
                          response.then((value) {
                            if (value.statusCode == 200) {
                              final repos = Repository.listFromJson(jsonDecode(value.body));
                              setState(() {
                                _repositories = repos;
                                _status = 'status: OK';
                              });
                            } else {
                              setState(() {
                                _status = 'status: ${value.statusCode}';
                              });
                            }
                          });
                        },
                        child: Text("search"),
                      ),
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8),
                          child: Text(_status, style: Theme.of(context).textTheme.headline5)
                      )
                    ]
                ),
                Container(
                  height: 1,
                  color: Colors.black54,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 400,
                    margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
                    child: ListView.builder(
                        itemCount: _repositories.length,
                        itemBuilder: (_, index) => Text(
                            _repositories[index].name,
                            style: Theme.of(context).textTheme.headline5
                        )
                    ),
                  )
                  ,
                )
              ]
          )
      )
  );
}