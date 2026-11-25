import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp3/models/reservation.dart';
import '../config/api_config.dart';
import '../models/destination.dart';

class ApiService {
  static const _cleCache = 'cache_destinations';
  static bool depuisCache = false;

  static Uri _url(String chemin)=> Uri.parse('${ApiConfig.baseUrl}$chemin');

  static List<Destination> _decoder(String corps) =>
      (jsonDecode(corps) as List)
          .map((e) => Destination.fromJson(e))
          .toList();

  static Future<List<Destination>> getDestinations() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final reponse = await http
          .get(_url('/destinations'))
          .timeout(ApiConfig.timeout);
      if (reponse.statusCode != 200) {
        throw Exception('Erreur ${reponse.statusCode}');
      }
      final corps = utf8.decode(reponse.bodyBytes);
      await prefs.setString(_cleCache, corps);
      depuisCache = false;
      return _decoder(corps);
    } catch (_) {
      final cache = prefs.getString(_cleCache);
      if (cache == null) rethrow;
      depuisCache = true;
      return _decoder(cache);
    }
  }

  static Future<String> careerReservation(Reservation reservation) async{
    final reponse = await http.post(_url('/reservations'),headers: {'Content-Type':'application/json'},
    body: jsonEncode(reservation.toJson())
    ).timeout(ApiConfig.timeout);
    if(reponse.statusCode!=201){
      throw Exception("erreur d'envoie");
    }
    final Map<String,dynamic> cree=jsonDecode(utf8.decode(reponse.bodyBytes));
    return cree['id'].toString();
  }
}
