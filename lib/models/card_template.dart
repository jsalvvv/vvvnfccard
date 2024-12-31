import 'package:flutter/material.dart';

class CardTemplate {
  final String id;
  final String name;
  final String description;
  final bool supportsLogo;
  final bool supportsPrimaryColor;
  final bool supportsCustomFont;
  final Color defaultPrimaryColor;
  final String previewImagePath;

  const CardTemplate({
    required this.id,
    required this.name,
    required this.description,
    this.supportsLogo = true,
    this.supportsPrimaryColor = true,
    this.supportsCustomFont = true,
    this.defaultPrimaryColor = Colors.blue,
    required this.previewImagePath,
  });
}

class CardTemplates {
  static const modern = CardTemplate(
    id: 'modern',
    name: 'Modern Minimal',
    description: 'Clean and minimal design with emphasis on typography',
    previewImagePath: 'assets/templates/modern_preview.png',
    defaultPrimaryColor: Colors.blue,
  );

  static const classic = CardTemplate(
    id: 'classic',
    name: 'Classic Professional',
    description: 'Traditional business card layout with a professional feel',
    previewImagePath: 'assets/templates/classic_preview.png',
    defaultPrimaryColor: Colors.blueGrey,
  );

  static const gradient = CardTemplate(
    id: 'gradient',
    name: 'Gradient Style',
    description: 'Modern gradient background with dynamic colors',
    previewImagePath: 'assets/templates/gradient_preview.png',
    defaultPrimaryColor: Colors.purple,
  );

  static const split = CardTemplate(
    id: 'split',
    name: 'Split Design',
    description: 'Two-tone design with a distinct sidebar',
    previewImagePath: 'assets/templates/split_preview.png',
    defaultPrimaryColor: Colors.indigo,
  );

  static const minimalistPlus = CardTemplate(
    id: 'minimalist_plus',
    name: 'Minimalist Plus',
    description: 'Enhanced minimal design with subtle accents',
    previewImagePath: 'assets/templates/minimalist_plus_preview.png',
    defaultPrimaryColor: Colors.teal,
  );

  static const creative = CardTemplate(
    id: 'creative',
    name: 'Creative Pattern',
    description: 'Playful pattern background with modern elements',
    previewImagePath: 'assets/templates/creative_preview.png',
    defaultPrimaryColor: Colors.deepPurple,
  );

  // List of all available templates
  static const List<CardTemplate> all = [
    modern,
    classic,
    gradient,
    split,
    minimalistPlus,
    creative,
  ];

  // Get template by ID
  static CardTemplate? getTemplateById(String id) {
    try {
      return all.firstWhere((template) => template.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get default template
  static CardTemplate get defaultTemplate => modern;

  // Get templates by category (you can extend this based on your needs)
  static List<CardTemplate> getTemplatesByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'professional':
        return [modern, classic, minimalistPlus];
      case 'creative':
        return [gradient, creative];
      case 'all':
      default:
        return all;
    }
  }
}

// Extension to add color utility methods for templates
extension CardTemplateColors on CardTemplate {
  // Get a list of recommended colors for this template
  List<Color> get recommendedColors {
    switch (id) {
      case 'modern':
        return [
          Colors.blue,
          Colors.blueGrey,
          Colors.grey[800]!,
          Colors.teal,
        ];
      case 'gradient':
        return [
          Colors.purple,
          Colors.blue,
          Colors.teal,
          Colors.deepPurple,
        ];
      case 'creative':
        return [
          Colors.deepPurple,
          Colors.pink,
          Colors.orange,
          Colors.green,
        ];
      default:
        return [
          Colors.blue,
          Colors.blueGrey,
          Colors.teal,
          Colors.purple,
          Colors.indigo,
        ];
    }
  }

  // Get darker shade of the primary color if needed
  Color getDarkerShade(Color primaryColor) {
    final HSLColor hslColor = HSLColor.fromColor(primaryColor);
    return hslColor.withLightness((hslColor.lightness - 0.1).clamp(0.0, 1.0)).toColor();
  }

  // Get lighter shade of the primary color if needed
  Color getLighterShade(Color primaryColor) {
    final HSLColor hslColor = HSLColor.fromColor(primaryColor);
    return hslColor.withLightness((hslColor.lightness + 0.1).clamp(0.0, 1.0)).toColor();
  }
}

// Extension to add font utility methods for templates
extension CardTemplateFonts on CardTemplate {
  // Get recommended fonts for this template
  List<String> get recommendedFonts {
    switch (id) {
      case 'modern':
        return ['Roboto', 'Open Sans', 'Lato'];
      case 'classic':
        return ['Times New Roman', 'Georgia', 'Playfair Display'];
      case 'creative':
        return ['Poppins', 'Montserrat', 'Quicksand'];
      default:
        return ['Roboto', 'Open Sans', 'Lato'];
    }
  }

  // Get default font for this template
  String get defaultFont {
    switch (id) {
      case 'classic':
        return 'Times New Roman';
      case 'creative':
        return 'Poppins';
      default:
        return 'Roboto';
    }
  }
}