import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/business_card.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusinessCardProvider>(context);
    final card = provider.card;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: card.firstName,
            decoration: const InputDecoration(labelText: 'First Name'),
            onChanged: (value) => provider.updateField('firstName', value),
          ),
          TextFormField(
            initialValue: card.lastName,
            decoration: const InputDecoration(labelText: 'Last Name'),
            onChanged: (value) => provider.updateField('lastName', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: card.organization,
            decoration: const InputDecoration(labelText: 'Organization'),
            onChanged: (value) => provider.updateField('organization', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: card.title,
            decoration: const InputDecoration(labelText: 'Title'),
            onChanged: (value) => provider.updateField('title', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: card.email,
            decoration: const InputDecoration(labelText: 'Email'),
            onChanged: (value) => provider.updateField('email', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: card.phone,
            decoration: const InputDecoration(labelText: 'Phone'),
            onChanged: (value) => provider.updateField('phone', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: card.website,
            decoration: const InputDecoration(labelText: 'Website'),
            onChanged: (value) => provider.updateField('website', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: card.address,
            decoration: const InputDecoration(labelText: 'Address'),
            onChanged: (value) => provider.updateField('address', value),
          ),
          const SizedBox(height: 16),
          TextFormField(
            initialValue: card.socialMedia,
            decoration: const InputDecoration(labelText: 'Social Media'),
            onChanged: (value) => provider.updateField('socialMedia', value),
          ),
        ],
      ),
    );
  }
}