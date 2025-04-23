import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Holds the index of the selected tab
  var selectedIndex = 0.obs;

  // Function to update the tab index
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
