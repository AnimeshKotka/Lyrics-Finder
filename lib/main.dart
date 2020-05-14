import 'package:flutter/material.dart';
import './webservices/webservice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lyrics Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lyrics Finder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _artistController = TextEditingController();
  final _titleController = TextEditingController();
  

  void _onSubmit() async {
    String artist = _artistController.text.toString();
    String title = _titleController.text.toString();

    if (artist == null || title == null) return null;

    //Tdod : new page for lyrics

    String url = 'https://api.lyrics.ovh/v1/$artist/$title';

    print(url);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebService(url,title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  // autofocus: true,
                  decoration: InputDecoration(labelText: 'Artist'),
                  controller: _artistController,
                  keyboardType: TextInputType.text,
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => _onSubmit(),
              ),
            ),
            FlatButton(
              padding: const EdgeInsets.all(10),
              child: Text('Search',style: TextStyle(fontSize: 20),),
              onPressed: _onSubmit,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ));
  }
}
