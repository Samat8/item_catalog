import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class ApiService {
  static int _currentPage = 1;
  static const String apiUrl = 'https://rickandmortyapi.com/api/character/';

  static Future<List<Item>> getItems() async {
    final response = await http.get(Uri.parse('$apiUrl?page=$_currentPage'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> results = responseData['results'];
      final List<Item> items = results
          .map((json) => Item(
              title: json['name'],
              description: json['species'],
              imageUrl: json['image'],
              gender: json['gender'],
              type: json['type'],
              id: ''))
          .toList();

      // Check if there are more pages
      final nextPageUrl = responseData['info']['next'];
      if (nextPageUrl != null) {
        _currentPage++;
      }

      return items;
    } else {
      throw Exception('Failed to fetch items');
    }
  }
}
