import 'package:get/get.dart';
import 'package:smart_car_park/utils/helpers/network.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
