import 'package:flutter/material.dart';
import 'package:omega/app/widgets/container/guide_widget.dart';

import '../../widgets/container/custom_app_bar.dart';

class GuideView extends StatelessWidget {
  GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Guides"),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: GuideWidget(),
      ),
    );
  }
}
