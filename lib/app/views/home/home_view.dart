import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omega/app/controllers/BottomNavController.dart';
import 'package:omega/app/routes/app_routes.dart';
import 'package:omega/app/services/suplement.dart';
import 'package:omega/app/widgets/image/custom_svg.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/profile_ctrl.dart';
import '../../utils/constants/assets.dart';
import '../../utils/helpers/app_size.dart';
import '../../widgets/chart/monthly_bar_chart.dart';
import '../../widgets/container/custom_supplement_container.dart';
import '../../widgets/text/text_widget.dart';

class HomeView extends StatelessWidget {
  final HomeController controller =
      Get.put(HomeController(supplementServices: SupplementServices()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: AppSize.h2,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(),
            WeeklyBarChart(),
            Text(
              "Today",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
            ),
            CustomSupplementContainer(),
            // TextWidget(
            //   title: "Discover",
            //   fontSize: 20,
            //   fontWeight: FontWeight.w800,
            // ),
            // CustomContainer(
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     physics: ScrollPhysics(),
            //     itemCount: 4,
            //     itemBuilder: (itemBuilder, index) {
            //       return ClipRRect(
            //         borderRadius: BorderRadius.circular(12),
            //         child: Image.asset(AppAssets.coverImage, fit: BoxFit.cover),
            //       );
            //     },
            //     separatorBuilder: (BuildContext context, int index) {
            //       return SizedBox(
            //         height: AppSize.h2,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Image.asset(
        AppAssets.logo,
        width: AppSize.getHeight(22),
      ),
    );
  }

  Widget _buildGreeting() {
    final ProfileController controller = Get.find<ProfileController>();

    return Obx(() {
      final user = controller.user.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFEFEFEF),
            backgroundImage: user != null && user.profilePicture.isNotEmpty
                ? NetworkImage(user.profilePicture)
                : AssetImage(AppAssets.noProfile) as ImageProvider,
            radius: 24,
          ),
          SizedBox(width: AppSize.h2),

          // Make text ellipsize
          Flexible(
            flex: 3,
            child: TextWidget(
              title: user != null && user.name.isNotEmpty
                  ? "Hello, ${user.name}!"
                  : "Hello, Max!",
              fontSize: 22,
              fontWeight: FontWeight.w600,
              textOverflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),

          Spacer(),
          InkWell(
              onTap: () {
                final controller = Get.find<BottomNavController>();
                controller.changeTab(1);
              },
              child: CustomSvgIcon(assetName: AppAssets.calender1)),
          SizedBox(width: AppSize.h2),
          InkWell(
              onTap: () async {
                Get.toNamed(Routes.notification);
                // await NotificationUtil().cancelNotification(1001);
              },
              child: CustomSvgIcon(assetName: AppAssets.notification)),
        ],
      );
    });
  }
}
