import 'package:flutter/material.dart';
import 'package:a_knitting_app/screens/loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
        ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.lightBlue[100],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
               scale: 2,
              ),
              SizedBox(
                height: 10,
              ),
              new ProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressIndicator extends StatefulWidget {
  @override
  _ProgressIndicatorState createState() => new _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          if (animation.value > 0.99) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()));
                              }
                            });
                          });
                        controller.repeat();
                      }
                    
                      @override
                      void dispose() {
                        controller.stop();
                        super.dispose();
                      }
                    
                      @override
                      Widget build(BuildContext context) {
                        return new Center(
                            child: new Container(
                          child: CircularProgressIndicator(
                            value: animation.value,
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        ));
                      }
                    
                      
                    }