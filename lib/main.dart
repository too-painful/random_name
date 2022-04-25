import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:math';

List _adjective = [];
List _noun = [];
String _nickName = '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    loadDataList();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '추천닉네임:',
            ),
            Text(
              _nickName,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _nickName = _adjective[Random().nextInt(_adjective.length)][0].toString()
                +_noun[Random().nextInt(_adjective.length)][0].toString();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

Future<List> _loadCSV(String path) async {
  final _rawData = await rootBundle.loadString(path);
  List<List<dynamic>> _listData =
  const CsvToListConverter().convert(_rawData);

  print(_listData);

  return _listData;
}

Future<void> loadDataList() async {

  _adjective = await _loadCSV('assets/adjective.csv');
  _noun = await _loadCSV('assets/noun.csv');

}
