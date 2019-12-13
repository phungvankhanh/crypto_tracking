import 'package:flutter/material.dart';

class GradientAppBarWithBack extends StatelessWidget {

  final String title;
  final double barHeight = 66.0;

  GradientAppBarWithBack(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return new Column(

      children: <Widget>[
        new Container(
          margin: new EdgeInsets.only(left: 4.2),
          padding: new EdgeInsets.only(top: statusBarHeight - 10.0),
          height: statusBarHeight + barHeight,
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                new BackButton(color: Colors.black),

                new Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: new Center(
                    child: new Text(title, style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 24.0,
                    ),
                  ),
                  ),
                  
                ),
              ],
            ),
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [Colors.white, Colors.white],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
            ),
          ),
        ),
      ],

    );
  }
}