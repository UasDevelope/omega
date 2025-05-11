import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:omega/app/utils/constants/color.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Help",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Contact Us Card
            _buildHelpCard(
              context,
              title: 'Contact Us',
              subtitle: 'Reach out for support or inquiries',
              email: 'support@apexbiotics.co.uk',
              icon: Icons.email_outlined,
                onTap: () async {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'support@apexbiotics.co.uk',
                  );

                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(emailUri, mode: LaunchMode.externalApplication);
                  } else {
                    print('Could not launch email client');
                    // Optional: Show snackbar or dialog to notify user
                  }
                }

            ),
            const SizedBox(height: 16),
            // FAQ Card
            _buildHelpCard(
              context,
              title: 'Frequently Asked Questions',
              subtitle: 'Answers to common questions about the app',
              email: 'support@apexbiotics.co.uk',
              icon: Icons.question_answer_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FAQScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            // About Us Card
            _buildHelpCard(
              context,
              title: 'About Us',
              subtitle: 'Our mission and story',
              email: 'support@apexbiotics.co.uk',
              icon: Icons.info_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AboutUsScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            // Privacy Policy Card
            _buildHelpCard(
              context,
              title: 'Privacy Policy',
              subtitle: 'Learn how we protect your data',
              email: 'support@apexbiotics.co.uk',
              icon: Icons.lock_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String email,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            Icon(icon, color: Colors.black54, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: AppColors.appColor, size: 20),
          ],
        ),
      ),
    );
  }
}

Future<void> launchEmail(String email, String subject, String body) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=$subject&body=$body',
  );
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri, mode: LaunchMode.externalNonBrowserApplication);
  } else {
    log("Could not launch email client $emailUri");
  }
}
class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'How do i retrieve my password or username?',
        'answer':
        'On the sign in screen you can request a password reset by email by clicking on the forgot password section.How do i make my diary visible to other users?'
      },
      {
        'question': 'How does Apex Biotics protect my personal information?',
        'answer':
        'Your personal information is protected with industry-standard encryption and stored securely. We only collect data necessary for app functionality, such as your profile details and supplement diary entries. You can review our Privacy Policy for more details.'
      },
      {
        'question': 'How do i set up push notifications?',
        'answer':
        'Click on the settings tab and click turn on or off push notifications.'
      },



      {
        'question': 'How do i add a photo to my profile?',
        'answer':
        'Click on the settings tab, then click on profile then click add profile photo.'
      },
      {
        'question': 'How does Apex Biotics protect my personal information?',
        'answer':
            'Your personal information is protected with industry-standard encryption and stored securely. We only collect data necessary for app functionality, such as your profile details and supplement diary entries. You can review our Privacy Policy for more details.'
      },
      {
        'question': 'Can I control who sees my supplement diary?',
        'answer':
            'Yes, your supplement diary is private by default. You can choose to share it with friends by navigating to Settings > Privacy > Diary Sharing and selecting "Friends Only."'
      },
      {
        'question': 'What data does Apex Biotics collect from the app?',
        'answer':
            'We collect data such as your email, profile information, supplement diary entries, and app usage patterns to improve your experience. We do not share this data with third parties except as outlined in our Privacy Policy.'
      },
      {
        'question': 'How do I delete my account and data?',
        'answer':
            'To delete your account, go to Settings > Account > Delete Account. This will remove all your data from our servers. You can also email support@apexbiotics.co.uk for assistance.'
      },
      {
        'question': 'How do I add a supplement to my diary?',
        'answer':
            'Click the "Add Supplement" button on the Dashboard or Supplements page, select the supplement, and save it to your diary.'
      },
      {
        'question': 'Can I copy a friend’s supplement to my diary?',
        'answer':
            'If a friend has shared their diary with you, go to the Friends page, select their profile, tap the supplement you want, and click "Copy to Diary."'
      },
      {
        'question': 'How do I invite a friend to join Apex Biotics?',
        'answer':
            'Go to Settings > Friends > Add Friends, select "Email," and enter their email address to send an invitation.'
      },
      {
        'question': 'What happens if I forget my password?',
        'answer':
            'On the sign-in screen, click "Forgot Password" to receive a password reset link via email.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Frequently Asked Questions",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                title: Text(
                  faqs[index]['question']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                iconColor: AppColors.appColor,
                collapsedIconColor: AppColors.appColor,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      faqs[index]['answer']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "About Us",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                // gradient: const LinearGradient(
                //   colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'At APEX BIOTICS, our mission is to create a world in which people can enjoy a healthy, clean, and satisfying nutritional experience.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Our Story',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'As a family managing professional and personal responsibilities, we struggled with low energy and mental clarity. Frustrated with the lack of effective solutions, we took matters into our own hands.\n\nDriven by our passion for finding a better way, we dedicated ourselves to serving others by developing an effective, bioavailable, and easy-to-swallow solution to elevate nutritional intake and help everyone enjoy an energetic, optimized future.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                // gradient: const LinearGradient(
                //   colors: [Color(0xFF9C27B0), Color(0xFFBA68C8)],
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                // ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apex Biotics Privacy Policy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Last Updated: May 1, 2025',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'At Apex Biotics, we are committed to protecting your privacy and ensuring transparency about how your data is used. This Privacy Policy explains how we collect, use, store, and protect your information when you use our app or website.',
              style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
            ),
            const SizedBox(height: 16),
            _buildPolicySection(
              title: '1. Information We Collect',
              content:
                  '- **Personal Information**: Email address, username, and profile photo (if provided).\n- **Supplement Diary Data**: Details about supplements you add to your diary, including names, dosages, and frequency.\n- **Usage Data**: App interactions, such as page views, clicks, and settings preferences, to improve user experience.\n- **Device Information**: Device type, operating system, and IP address for technical support and analytics.',
            ),
            _buildPolicySection(
              title: '2. How We Use Your Information',
              content:
                  '- To provide and personalize app features, such as your supplement diary and friend-sharing options.\n- To send push notifications (if enabled) about app updates or reminders.\n- To analyze usage trends and improve our services.\n- To respond to your inquiries via email (support@apexbiotics.co.uk).',
            ),
            _buildPolicySection(
              title: '3. Sharing Your Information',
              content:
                  '- Your supplement diary is private by default. If you enable sharing, only selected friends can view it.\n- We do not sell or share your personal data with third parties, except:\n  - With service providers (e.g., cloud storage) who follow strict data protection standards.\n  - If required by law or to protect our rights.',
            ),
            _buildPolicySection(
              title: '4. Data Security',
              content:
                  '- We use encryption (e.g., SSL) and secure servers to protect your data.\n- Access to your data is restricted to authorized personnel only.',
            ),
            _buildPolicySection(
              title: '5. Your Choices',
              content:
                  '- **Push Notifications**: Enable or disable in Settings > Notifications.\n- **Diary Sharing**: Control visibility in Settings > Privacy > Diary Sharing.\n- **Account Deletion**: Delete your account in Settings > Account > Delete Account, or contact support@apexbiotics.co.uk.',
            ),
            _buildPolicySection(
              title: '6. Data Retention',
              content:
                  '- We retain your data only as long as necessary to provide our services or comply with legal obligations.\n- Deleted accounts are removed from our servers within 30 days.',
            ),
            _buildPolicySection(
              title: '7. Children’s Privacy',
              content:
                  '- Our app is not intended for users under 13. We do not knowingly collect data from children.',
            ),
            _buildPolicySection(
              title: '8. Changes to This Policy',
              content:
                  '- We may update this policy periodically. You will be notified of significant changes via email or in-app alerts.',
            ),
            _buildPolicySection(
              title: '9. Contact Us',
              content:
                  '- For questions or concerns, email us at support@apexbiotics.co.uk.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 8),
          MarkdownBody(
            data: content,
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: 14, color: Color(0xFF666666)),
              listBullet:
                  const TextStyle(fontSize: 14, color: Color(0xFF666666)),
            ),
          ),
        ],
      ),
    );
  }
}
