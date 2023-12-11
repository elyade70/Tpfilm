import 'package:flutter/material.dart';
import 'movie_detail.dart';

class SearchResultsPage extends StatelessWidget {
  final List<dynamic> searchResults;

  const SearchResultsPage({Key? key, required this.searchResults}) : super(key: key);

  void navigateToDetailPage(BuildContext context, String imdbID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetailScreen(imdbID: imdbID)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultats de recherche', style: TextStyle(color: Colors.purple),),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              navigateToDetailPage(context, searchResults[index]['imdbID']);
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.network(
                  searchResults[index]['Poster'],
                  width: 50.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
                title: Text('${searchResults[index]['Title']}'),
                subtitle: Text('${searchResults[index]['Year']}'),
              ),
            ),
          );
        },
      ),
    );
  }
}