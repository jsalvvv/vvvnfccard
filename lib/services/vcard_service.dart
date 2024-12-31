import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import '../models/business_card.dart';

class VCardService {
  // Generate vCard string from BusinessCard
  String generateVCard(BusinessCard card) {
    final vCardLines = [
      'BEGIN:VCARD',
      'VERSION:3.0',
      'N:${card.lastName};${card.firstName};;;',
      'FN:${card.firstName} ${card.lastName}',
      if (card.organization.isNotEmpty) 'ORG:${card.organization}',
      if (card.title.isNotEmpty) 'TITLE:${card.title}',
      if (card.email.isNotEmpty) 'EMAIL:${card.email}',
      if (card.phone.isNotEmpty) 'TEL:${card.phone}',
      if (card.website.isNotEmpty) 'URL:${card.website}',
      if (card.address.isNotEmpty) 'ADR:;;${card.address};;;;',
      'END:VCARD',
    ];

    return vCardLines.join('\r\n');
  }

  // Generate and download vCard file
  void downloadVCard(BusinessCard card) {
    final vCardContent = generateVCard(card);
    final bytes = utf8.encode(vCardContent);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', '${card.firstName}_${card.lastName}.vcf')
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  // Generate QR code data for vCard
  String generateQRData(BusinessCard card) {
    return generateVCard(card);
  }

  // Generate shareable link (if you have a web platform)
  String generateShareableLink(String cardId) {
    // Replace with your actual web domain
    return 'https://yourdomain.com/card/$cardId';
  }

  // Parse vCard string to BusinessCard object
  BusinessCard? parseVCard(String vCardString) {
    try {
      final lines = vCardString.split('\r\n');
      final Map<String, String> fields = {};

      for (var line in lines) {
        if (line.contains(':')) {
          final parts = line.split(':');
          final key = parts[0];
          final value = parts.sublist(1).join(':');
          fields[key] = value;
        }
      }

      // Parse name
      String firstName = '';
      String lastName = '';
      if (fields.containsKey('N')) {
        final nameParts = fields['N']!.split(';');
        if (nameParts.length >= 2) {
          lastName = nameParts[0];
          firstName = nameParts[1];
        }
      } else if (fields.containsKey('FN')) {
        final nameParts = fields['FN']!.split(' ');
        if (nameParts.length >= 2) {
          firstName = nameParts[0];
          lastName = nameParts.sublist(1).join(' ');
        } else {
          firstName = fields['FN']!;
        }
      }

      return BusinessCard(
        firstName: firstName,
        lastName: lastName,
        organization: fields['ORG'] ?? '',
        title: fields['TITLE'] ?? '',
        email: fields['EMAIL'] ?? '',
        phone: fields['TEL'] ?? '',
        website: fields['URL'] ?? '',
        address: fields['ADR']?.replaceAll(';', ' ').trim() ?? '',
      );
    } catch (e) {
      // print('Error parsing vCard: $e');
      return null;
    }
  }

  // Share card via Web Share API (if available)
  Future<void> shareCard(BusinessCard card) async {
    final vCardContent = generateVCard(card);
    final shareData = {
      'title': '${card.firstName} ${card.lastName}\'s Business Card',
      'text': 'Contact information for ${card.firstName} ${card.lastName}',
      'files': [
        html.File(
          [vCardContent],
          '${card.firstName}_${card.lastName}.vcf',
          {'type': 'text/vcard'},
        ),
      ],
    };

    try {
      await html.window.navigator.share(shareData);
    } catch (e) {
      // print('Error sharing card: $e');
      // Fallback to download if sharing is not available
      downloadVCard(card);
    }
  }

  // Generate NFC payload
  List<int> generateNFCPayload(BusinessCard card) {
    final vCardContent = generateVCard(card);
    return utf8.encode(vCardContent);
  }

  // Format phone number (helper method)
  String formatPhoneNumber(String phone) {
    // Remove all non-numeric characters
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Check if it's an international number
    if (cleaned.startsWith('+')) {
      return cleaned;
    }
    
    // Format US phone number
    if (cleaned.length == 10) {
      return '(${cleaned.substring(0, 3)}) ${cleaned.substring(3, 6)}-${cleaned.substring(6)}';
    }
    
    return phone;
  }

  // Validate email address (helper method)
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Validate phone number (helper method)
  bool isValidPhone(String phone) {
    // Basic validation - can be expanded based on requirements
    final cleaned = phone.replaceAll(RegExp(r'[^\d+]'), '');
    return cleaned.length >= 10;
  }
}