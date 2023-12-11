import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omdb Demo pour prépa TP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter Demo JSON API FROM OMDB'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late Map<String, dynamic> film;
  bool dataOK = false;

  @override
  void initState() {
    recupFilm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: dataOK ? affichage() : attente(),
      backgroundColor: Colors.blueGrey[900],
    );
  }

  Future<void> recupFilm() async {
    Uri uri = Uri.http('www.omdbapi.com', '', {'i': 'tt3896198', 'apikey': 'a14bcdf5'});
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      film = jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        dataOK = true;
      });
    }
  }

  Widget attente() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'En attente des données',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          CircularProgressIndicator(
            color: Colors.deepOrange,
            strokeWidth: 3.0,
          ),
        ],
      ),
    );
  }

  Widget affichage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${film['Title']}',
            style: const TextStyle(
              color: Colors.amberAccent,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${film['Year']}',
            style: const TextStyle(color: Colors.white),
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 7.0),
                  spreadRadius: 3.0,
                  blurRadius: 15.0,
                ),
              ],
            ),
            child: Image.network('${film['Poster']}'),
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          Text(
            '${film['Plot']}',
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          const Padding(padding: EdgeInsets.all(15.0)),
          Text(
            '${film['Actors']}',
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}