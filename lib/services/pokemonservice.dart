import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:bloctest/models/pokemonmodel.dart';

class PokemonService {
  static Future<List<Pokemon>> fetchPokemonList() async {
    try {
      final response = await http.get(Uri.parse('https://api.restful-api.dev/objects'));
      
      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(response.body); // Decode response body into a list
        final List<Pokemon> pokemonList = decoded.map((json) => Pokemon.fromJson(json)).toList(); // Convert each JSON object to a Pokemon object
        return pokemonList;
      } else {
        throw Exception("Failed to load pokemon list");
      }
    } on SocketException {
      throw Exception("Server error");
    } on HttpException {
      throw Exception("Something went wrong");
    } on FormatException {
      throw Exception("Bad Request");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
