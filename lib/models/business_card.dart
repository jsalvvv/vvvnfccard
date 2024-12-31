import 'package:flutter/material.dart';

class BusinessCard {
  String firstName;
  String lastName;
  String organization;
  String title;
  String email;
  String phone;
  String website;
  String address;
  String template;
  Color primaryColor;
  String? logoUrl;
  String font;
  String socialMedia;

  BusinessCard({
    this.firstName = '',
    this.lastName = '',
    this.organization = '',
    this.title = '',
    this.email = '',
    this.phone = '',
    this.website = '',
    this.address = '',
    this.template = 'modern',
    this.primaryColor = Colors.blue,
    this.logoUrl,
    this.font = 'Roboto',
    this.socialMedia = '',
  });

  factory BusinessCard.fromJson(Map<String, dynamic> json) {
    return BusinessCard(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      organization: json['organization'] ?? '',
      title: json['title'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      website: json['website'] ?? '',
      address: json['address'] ?? '',
      template: json['template'] ?? 'modern',
      primaryColor: Color(json['primaryColor'] ?? 0xFF000000),
      logoUrl: json['logoUrl'],
      font: json['font'] ?? 'Roboto',
      socialMedia: json['socialMedia'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'organization': organization,
      'title': title,
      'email': email,
      'phone': phone,
      'website': website,
      'address': address,
      'template': template,
      'primaryColor': primaryColor.value,
      'logoUrl': logoUrl,
      'font': font,
      'socialMedia': socialMedia,
    };
  }
}

class BusinessCardProvider extends ChangeNotifier {
  BusinessCard _card = BusinessCard();

  BusinessCard get card => _card;

  void updateCard(BusinessCard newCard) {
    _card = newCard;
    notifyListeners();
  }

  void updateField(String field, dynamic value) {
    switch (field) {
      case 'firstName':
        _card.firstName = value;
        break;
      // Add other fields...
    }
    notifyListeners();
  }
}