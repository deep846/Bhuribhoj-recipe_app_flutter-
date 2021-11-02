import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
final String url;
final String recipename;
RecipeView(this.url,this.recipename);
  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late String finalurl;
  final Completer<WebViewController> controller = Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if(widget.url.toString().contains("http://"))
      {
        finalurl = widget.url.toString().replaceAll("http://", "https://");
      }
    else{
      finalurl = widget.url;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipename),
      ),
      body: Container(
        child: WebView(
          initialUrl: finalurl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webviewController){
            setState(() {
              controller.complete(webviewController);
            });
          },
        ),
      ),
    );
  }
}
