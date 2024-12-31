import 'package:flutter/material.dart';
import 'widgets/contact_form.dart';
import 'widgets/template_selector.dart';
import 'widgets/design_customizer.dart';
import 'widgets/card_preview.dart';

class CardBuilderScreen extends StatefulWidget {
  const CardBuilderScreen({super.key});

  @override
  _CardBuilderScreenState createState() => _CardBuilderScreenState();
}

class _CardBuilderScreenState extends State<CardBuilderScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Navigation Rail
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Info'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.style_outlined),
                selectedIcon: Icon(Icons.style),
                label: Text('Template'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.palette_outlined),
                selectedIcon: Icon(Icons.palette),
                label: Text('Design'),
              ),
            ],
          ),
          // Main Content
          Expanded(
            child: Row(
              children: [
                // Form Area
                Expanded(
                  flex: 2,
                  child: _buildContent(),
                ),
                // Preview Area
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: const CardPreview(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const ContactForm();
      case 1:
        return const TemplateSelector();
      case 2:
        return const DesignCustomizer();
      default:
        return const SizedBox.shrink();
    }
  }
}