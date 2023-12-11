import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String apiKey = 'a14bcdf5';
  static const String baseUrl = 'www.omdbapi.com';

  Future<Map<String, dynamic>> getMovieDetails(String imdbID) async {
    Uri uri = Uri.http(baseUrl, '', {'i': imdbID, 'apikey': apiKey});
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erreur lors de la récupération des détails du film');
    }
  }

  Future<List<dynamic>> searchMovies(String query) async {
    Uri uri = Uri.http(baseUrl, '', {'s': query, 'apikey': apiKey});
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('Search')) {
        return data['Search'] as List<dynamic>;
      } else {
        return [];
      }
    } else {
      throw Exception('Erreur lors de la recherche de films');
    }
  }
}
