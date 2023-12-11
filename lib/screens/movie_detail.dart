import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieDetailScreen extends StatefulWidget {
  final String imdbID;

  const MovieDetailScreen({Key? key, required this.imdbID}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Map<String, dynamic> movie = {}; // Initialisation avec un Map vide

  @override
  void initState() {
    fetchMovieDetails(widget.imdbID);
    super.initState();
  }

  Future<void> fetchMovieDetails(String imdbID) async {
    Uri uri = Uri.http('www.omdbapi.com', '', {'i': imdbID, 'apikey': 'a14bcdf5'});
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      setState(() {
        movie = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails du Film', style: TextStyle(color: Colors.purple)),
        backgroundColor: Colors.white24,
      ),
      body: movie.isNotEmpty // Vérifie si le Map n'est pas vide
          ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movie['Poster']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Titre: ${movie['Title']}',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Année: ${movie['Year']}',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Acteurs: ${movie['Actors']}',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Synopsis:',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                movie['Plot'],
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      )
          : const Center(
        child: CircularProgressIndicator(color: Colors.deepOrange, strokeCap: StrokeCap.round),
      ),
    );
  }
}