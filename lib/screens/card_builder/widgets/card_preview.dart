import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/business_card.dart';
import '../../../theme/app_theme.dart';

class CardPreview extends StatelessWidget {
  const CardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BusinessCardProvider>(
      builder: (context, provider, child) {
        final card = provider.card;
        
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1.586, // Standard business card ratio
                    child: _buildCardPreview(card),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCardPreview(BusinessCard card) {
    switch (card.template) {
      case 'modern':
        return _ModernTemplate(card: card);
      case 'classic':
        return _ClassicTemplate(card: card);
      case 'neon':
        return _NeonTemplate(card: card);
      case 'gradient':
        return _GradientTemplate(card: card);
      case 'split':
        return _SplitTemplate(card: card);
      case 'minimalist_plus':
        return _MinimalistPlusTemplate(card: card);
      case 'creative':
        return _CreativeTemplate(card: card);
      default:
        return _ModernTemplate(card: card);
    }
  }
}

class _ModernTemplate extends StatelessWidget {
  final BusinessCard card;

  const _ModernTemplate({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (card.logoUrl != null) ...[
            Image.network(
              card.logoUrl!,
              height: 40,
            ),
            const SizedBox(height: 16),
          ],
          Text(
            '${card.firstName} ${card.lastName}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            card.title,
            style: TextStyle(
              fontSize: 16,
              color: card.primaryColor,
            ),
          ),
          if (card.organization.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              card.organization,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
          const SizedBox(height: 16),
          _ContactInfo(
            icon: Icons.email,
            text: card.email,
          ),
          _ContactInfo(
            icon: Icons.phone,
            text: card.phone,
          ),
          if (card.website.isNotEmpty)
            _ContactInfo(
              icon: Icons.language,
              text: card.website,
            ),
          if (card.address.isNotEmpty)
            _ContactInfo(
              icon: Icons.location_on,
              text: card.address,
            ),
        ],
      ),
    );
  }
}

class _ClassicTemplate extends StatelessWidget {
  final BusinessCard card;

  const _ClassicTemplate({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${card.firstName} ${card.lastName}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            card.title,
            style: TextStyle(
              fontSize: 16,
              color: card.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          _ContactInfo(
            icon: Icons.email,
            text: card.email,
          ),
          _ContactInfo(
            icon: Icons.phone,
            text: card.phone,
          ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactInfo({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class _NeonTemplate extends StatelessWidget {
  final BusinessCard card;

  const _NeonTemplate({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: card.primaryColor.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: AppTheme.neonBoxDecoration,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '${card.firstName} ${card.lastName}',
              style: AppTheme.getNeonTextStyle(
                color: AppTheme.neonPink,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            card.title,
            style: AppTheme.getNeonTextStyle(
              color: card.primaryColor,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          _NeonContactInfo(
            icon: Icons.email,
            text: card.email,
            color: AppTheme.neonBlue,
          ),
          _NeonContactInfo(
            icon: Icons.phone,
            text: card.phone,
            color: AppTheme.neonGreen,
          ),
        ],
      ),
    );
  }
}

class _NeonContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _NeonContactInfo({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: AppTheme.getNeonTextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientTemplate extends StatelessWidget {
  final BusinessCard card;

  const _GradientTemplate({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            card.primaryColor,
            card.primaryColor.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (card.logoUrl != null) ...[
                  Image.network(
                    card.logoUrl!,
                    height: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                ],
                Text(
                  '${card.firstName} ${card.lastName}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  card.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const Spacer(),
                _ContactInfoLight(
                  icon: Icons.email,
                  text: card.email,
                ),
                _ContactInfoLight(
                  icon: Icons.phone,
                  text: card.phone,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SplitTemplate extends StatelessWidget {
  final BusinessCard card;

  const _SplitTemplate({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            decoration: BoxDecoration(
              color: card.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (card.logoUrl != null)
                  Image.network(
                    card.logoUrl!,
                    height: 40,
                    color: Colors.white,
                  ),
                const SizedBox(height: 16),
                Container(
                  width: 40,
                  height: 2,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${card.firstName} ${card.lastName}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    card.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: card.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ContactInfo(
                    icon: Icons.email,
                    text: card.email,
                  ),
                  _ContactInfo(
                    icon: Icons.phone,
                    text: card.phone,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MinimalistPlusTemplate extends StatelessWidget {
  final BusinessCard card;

  const _MinimalistPlusTemplate({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (card.logoUrl != null) ...[
                Image.network(
                  card.logoUrl!,
                  height: 30,
                ),
                const SizedBox(width: 16),
              ],
              Container(
                width: 2,
                height: 40,
                color: card.primaryColor,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${card.firstName} ${card.lastName}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      card.title,
                      style: TextStyle(
                        fontSize: 14,
                        color: card.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: card.primaryColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _IconContact(
                  icon: Icons.email,
                  text: card.email,
                  color: card.primaryColor,
                ),
                _IconContact(
                  icon: Icons.phone,
                  text: card.phone,
                  color: card.primaryColor,
                ),
                if (card.website.isNotEmpty)
                  _IconContact(
                    icon: Icons.language,
                    text: card.website,
                    color: card.primaryColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CreativeTemplate extends StatelessWidget {
  final BusinessCard card;

  const _CreativeTemplate({required this.card});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: CirclePatternPainter(
                color: card.primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (card.logoUrl != null) ...[
                  Image.network(
                    card.logoUrl!,
                    height: 40,
                  ),
                  const SizedBox(height: 16),
                ],
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: card.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${card.firstName} ${card.lastName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: card.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    card.title,
                    style: TextStyle(
                      color: card.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                const Spacer(),
                _CreativeContactInfo(
                  icon: Icons.email,
                  text: card.email,
                  color: card.primaryColor,
                ),
                _CreativeContactInfo(
                  icon: Icons.phone,
                  text: card.phone,
                  color: card.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widgets for the templates
class _ContactInfoLight extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactInfoLight({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white70),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconContact extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _IconContact({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: color,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _CreativeContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _CreativeContactInfo({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for the creative template's background pattern
class CirclePatternPainter extends CustomPainter {
  final Color color;

  CirclePatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final radius = size.width * 0.1;
    final spacing = radius * 2;

    for (var x = -radius; x < size.width + radius; x += spacing) {
      for (var y = -radius; y < size.height + radius; y += spacing) {
        canvas.drawCircle(Offset(x, y), radius / 2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}