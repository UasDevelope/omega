import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Help",
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            HelpCard(
              title: 'Contact Us',
              subtitle: 'Contact us – with email',
              email: 'support@apexbiotics.co.uk',
            ),
            SizedBox(height: 12),
            HelpCard(
              title: 'Frequently asked questions',
              subtitle: 'Contact us – with email',
              email: 'support@apexbiotics.co.uk',
            ),
            SizedBox(height: 12),
            HelpCard(
              title: 'About Us',
              subtitle: 'Contact us – with email',
              email: 'support@apexbiotics.co.uk',
            ),
          ],
        ),
      ),
    );
  }
}

class HelpCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String email;

  const HelpCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Get.width,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff006AB6),
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
