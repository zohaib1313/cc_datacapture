import 'package:cc_datacapture/pages/dashboard/controllers/dashboard_page_controller.dart';
import 'package:cc_datacapture/pages/dashboard/dashboard_page.dart';
import 'package:get/get.dart';

List<GetPage> appRoutes() {
  return [
    ///...............put dependencies not being used as lazy .................../////
    GetPage(
      name: DashBoardPage.id,
      page: () => DashBoardPage(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(
        () {
          Get.put(DashboardPageController(), permanent: true);
        },
      ),
    ),
  ];
}
