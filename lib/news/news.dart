import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import './gradient_appbar_with_back.dart';
import 'package:http/http.dart' as http;
import 'package:conditional_builder/conditional_builder.dart';


class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);
  @override
  NewsPageState createState() => new NewsPageState();
}


class NewsPageState extends State<NewsPage> with SingleTickerProviderStateMixin {


  var newsSelection = "bitcoin";
  var excludeDomains = "readwrite.com"
                        + ",slashdot.org"
                        + ",google.com"
                        + ",thenextweb.com"
                        + ",businessinsider.com"
                        + ",sapien.network";
  String apiKey = "97ec2e1bd66c4a83bea5a50471589972";
  var data;
  final FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();

  Future getData() async {
    var response = await http.get(
        Uri.encodeFull(
            'https://newsapi.org/v2/everything?q='
            + newsSelection 
            +'&excludeDomains='
            + excludeDomains),
        headers: {
          "Accept": "application/json",
          "X-Api-Key": apiKey,
        });
    var localData = json.decode(response.body);

    this.setState(() {
      data = localData;
    });

  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  Future refresh() async {
    await getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [
                Colors.white,
                Colors.white
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: new Stack(
          children: <Widget>[
            new GradientAppBarWithBack("News"),
            new Container(

              padding: new EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
              child: data == null
                  ? const Center(child: const CircularProgressIndicator())
                  : data["articles"].length != 0
                      ? new RefreshIndicator(onRefresh: refresh, child: new ListView.builder(
                          itemCount: data == null ? 0 : data["articles"].length,
                          padding: new EdgeInsets.all(8.0),
                          itemBuilder: (BuildContext context, int index) {
                            return new Container(
                              margin: new EdgeInsets.only(top: 25.0),
                              decoration: new BoxDecoration(
                                color: new Color(0xFFFFFFFF),
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(30.0),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 8.0,
                                    offset: new Offset(0.0, 3.0),
                                  ),
                                ],
                              ),
                              child: new Padding(
                                padding: new EdgeInsets.all(5.0),
                                child: new Column(
                                  children: [
                                      new Row(
                                        children: [
                                          new Expanded(
                                            child: new GestureDetector(
                                              child: new Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  new Padding(
                                                    padding: new EdgeInsets.only(
                                                        left: 4.0,
                                                        right: 8.0,
                                                        bottom: 8.0,
                                                        top: 8.0),
                                                    child: new Text(
                                                      data["articles"][index]
                                                          ["title"],
                                                      style: new TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  new Padding(
                                                    padding: new EdgeInsets.only(
                                                        left: 4.0,
                                                        right: 4.0,
                                                        bottom: 4.0),
                                                    child: new Text(
                                                      data["articles"][index]
                                                          ["description"],
                                                      style: new TextStyle(
                                                        color: Colors.grey[800],
                                                        fontStyle: FontStyle.italic,
                                                      ),
                                                    ),
                                                  ),
                                                  new Padding(
                                                    padding:
                                                        new EdgeInsets.only(top: 8.0),
                                                    child: new SizedBox(
                                                      height: 300.0,
                                                      width: 600.0,
                                                      child: new Image.network(
                                                        data["articles"][index]
                                                            ["urlToImage"] ?? 'https://mtame.jp/dcms_media/image/20180215_01_01.jpg',
                                                        fit: BoxFit.cover,
                                                        height: double.infinity,
                                                        width: double.infinity, 
                                                        alignment: Alignment.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              onTap: () {

                                                Navigator.of(context).push(
                                                  new PageRouteBuilder(

                                                    pageBuilder: (_, __, ___) => new WebviewScaffold(
                                                      url: data["articles"][index]["url"],
                                                      appBar: new AppBar(

                                                        centerTitle: true,
                                                        title: new Text("Crypto News", style:const TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 24.0),
                                                        ),
                                                        backgroundColor: Colors.white,
                                                      ),
                                                    ),
                                                    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                                                    new FadeTransition(opacity: animation, child: child),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          new Column(
                                            children: <Widget>[
                                              
                                            ],
                                          )
                                        ],
                                      ),
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                                        children: <Widget>[
                                          new Text(""),
                                          new Padding(
                                            padding: new EdgeInsets.all(5.0),
                                            child: new Text(
                                              data["articles"][index]["source"]
                                                  ["name"] + ", " + timeago.format(DateTime.parse(
                                                  data["articles"][index]
                                                      ["publishedAt"])),
                                              style: new TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[600],
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
              ),
                        )
                      : new Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              new Icon(Icons.chrome_reader_mode,
                                  color: Colors.grey, size: 60.0),
                              new Text(
                                "No articles",
                                style: new TextStyle(
                                    fontSize: 24.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

}