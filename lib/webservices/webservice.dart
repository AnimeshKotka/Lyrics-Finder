import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WebService extends StatefulWidget {
  final String url;
  final String title;
  WebService(this.url, this.title);
  @override
  _WebServiceState createState() => _WebServiceState();
}

class _WebServiceState extends State<WebService> {
  void initState() {
    super.initState();
    loadLyrics();
  }

  String results = '';

  loadLyrics() async {
    try {
      final respo = await http.get(widget.url);
      if (respo.statusCode == 200) {
        final json = jsonDecode(respo.body);
        setState(() {
          results = json['lyrics'];
        });
        //print(results);
      } else {
        throw Exception("Error loading lyrics...");
        results = 'Loading Error!\nPlease enter correct artist name and tile.';
      }
    } on Exception catch (_) {
      throw Exception("Error on server");
      results = 'Loading Error!\nPlease enter correct artist name and tile.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: results.length != 0
          ? SingleChildScrollView(
              child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: Expanded(
                child: Text(
                  results,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.2),
                  Colors.purple.withOpacity(0.6)
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              )),
            ))
          : Container(
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            ),
    );
  }
}
