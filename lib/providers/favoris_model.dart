import 'package:flutter/foundation.dart';
import '../models/destination.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
class FavorisModel extends ChangeNotifier{
  static const _cle='favoris';
	final Map<String, Destination> _favoris = {};

	List<Destination> get liste => List.unmodifiable(_favoris.values);

	int get nombre => _favoris.length;

	bool estFavori(Destination d) => _favoris.containsKey(d.id);
Future<void> charger() async {
  final prefs= await SharedPreferences.getInstance();
	final List<String> textes = prefs.getStringList(_cle) ?? <String>[];
	for (final texte in textes) {
		final json = jsonDecode(texte) as Map<String, dynamic>;
		final destination = Destination.fromJson(json);
		_favoris[destination.id] = destination;
	}
	notifyListeners();
}
Future<void> _sauvgarder() async {
  final prefs = await SharedPreferences.getInstance();
	final textes = _favoris.values
			.map((destination) => jsonEncode(destination.toJson()))
			.toList();
	await prefs.setStringList(_cle, textes);
}
	bool basculer(Destination d) {
		final ajoute = _favoris.remove(d.id)==null;
    if (ajoute) _favoris[d.id]=d;
    _sauvgarder();
    notifyListeners();
    return ajoute;
	}
}