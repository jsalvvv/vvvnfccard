import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/business_card.dart';

class TemplateSelector extends StatelessWidget {
  const TemplateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessCardProvider>(context);
    
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _TemplateCard(
          name: 'Modern',
          template: 'modern',
          isSelected: provider.card.template == 'modern',
          onTap: () => provider.updateField('template', 'modern'),
          preview: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 8,
                  width: 80,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
        _TemplateCard(
          name: 'Classic',
          template: 'classic',
          isSelected: provider.card.template == 'classic',
          onTap: () => provider.updateField('template', 'classic'),
          preview: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 8,
                  width: 80,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
        _TemplateCard(
          name: 'Minimalist',
          template: 'minimalist',
          isSelected: provider.card.template == 'minimalist',
          onTap: () => provider.updateField('template', 'minimalist'),
          preview: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 8,
                  width: 80,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ),
        // Add other templates...
      ],
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final String name;
  final String template;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget preview;

  const _TemplateCard({
    required this.name,
    required this.template,
    required this.isSelected,
    required this.onTap,
    required this.preview,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Expanded(child: preview),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(name),
            ),
          ],
        ),
      ),
    );
  }
}