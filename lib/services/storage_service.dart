import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/business_card.dart';
import 'dart:ui';

class StorageService {
  static const String _cardsKey = 'saved_business_cards';
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // Save a business card
  Future<bool> saveCard(String id, BusinessCard card) async {
    final cards = await getCards();
    cards[id] = card;
    return _saveCards(cards);
  }

  // Get all saved cards
  Future<Map<String, BusinessCard>> getCards() async {
    final String? cardsJson = _prefs.getString(_cardsKey);
    if (cardsJson == null) return {};

    try {
      final Map<String, dynamic> decoded = json.decode(cardsJson);
      return decoded.map((key, value) => MapEntry(
            key,
            BusinessCard.fromJson(value as Map<String, dynamic>),
          ));
    } catch (e) {
      print('Error loading cards: $e');
      return {};
    }
  }

  // Get a specific card by ID
  Future<BusinessCard?> getCard(String id) async {
    final cards = await getCards();
    return cards[id];
  }

  // Delete a card
  Future<bool> deleteCard(String id) async {
    final cards = await getCards();
    cards.remove(id);
    return _saveCards(cards);
  }

  // Update a card
  Future<bool> updateCard(String id, BusinessCard card) async {
    return saveCard(id, card);
  }

  // Save all cards to storage
  Future<bool> _saveCards(Map<String, BusinessCard> cards) async {
    final encoded = json.encode(
      cards.map((key, value) => MapEntry(key, value.toJson())),
    );
    return _prefs.setString(_cardsKey, encoded);
  }

  // Clear all saved cards
  Future<bool> clearCards() async {
    return _prefs.remove(_cardsKey);
  }

  // Save the last used template
  Future<bool> saveLastUsedTemplate(String templateId) async {
    return _prefs.setString('last_template', templateId);
  }

  // Get the last used template
  String? getLastUsedTemplate() {
    return _prefs.getString('last_template');
  }

  // Save custom color schemes
  Future<bool> saveCustomColorScheme(String name, List<Color> colors) async {
    final colorValues = colors.map((c) => c.value).toList();
    return _prefs.setStringList('color_scheme_$name', 
      colorValues.map((v) => v.toString()).toList()
    );
  }

  // Get saved color schemes
  Future<Map<String, List<Color>>> getCustomColorSchemes() async {
    final Map<String, List<Color>> schemes = {};
    final keys = _prefs.getKeys().where((k) => k.startsWith('color_scheme_'));
    
    for (final key in keys) {
      final name = key.replaceFirst('color_scheme_', '');
      final values = _prefs.getStringList(key) ?? [];
      schemes[name] = values.map((v) => Color(int.parse(v))).toList();
    }
    
    return schemes;
  }
}