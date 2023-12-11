import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void navigateTo(String routeName, {dynamic arguments}) {
    navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  static void goBack() {
    navigatorKey.currentState!.pop();
  }

  static void navigateToMovieList() {
    navigatorKey.currentState!.pushReplacementNamed('/movie_list');
  }

  static void navigateToSearchResult(String searchQuery) {
    navigatorKey.currentState!.pushNamed('/search_result', arguments: searchQuery);
  }

  static void navigateToMovieDetail(String imdbID) {
    navigatorKey.currentState!.pushNamed('/movie_detail', arguments: imdbID);
  }
}
