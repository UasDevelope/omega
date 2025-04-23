import 'package:flutter/material.dart';

import '../../utils/constants/color.dart';

class ShareDiaryScreen extends StatefulWidget {
  @override
  _ShareDiaryScreenState createState() => _ShareDiaryScreenState();
}

class _ShareDiaryScreenState extends State<ShareDiaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget buildTabContent({required bool isShareTab}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isShareTab
                ? "Share your diary with a friend"
                : "Invite your friends to APEX BIOTICS!",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            isShareTab
                ? "Allow a trusted friend to view your diary entries."
                : "Send them a link to join and start sharing.",
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 24),
          TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Enter email or username",
              filled: true,
              fillColor: Colors.grey.shade100, // Light background
              hintStyle: TextStyle(color: Colors.grey.shade500),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(color: Colors.grey.shade400), // No blue glow
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Perform share or invite action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.appColor,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(isShareTab ? "Share" : "Send Invite"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Friends",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: AppColors.appColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.appColor,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: "Share Diary"),
              Tab(text: "Invite Friends"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildTabContent(isShareTab: true),
                buildTabContent(isShareTab: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
