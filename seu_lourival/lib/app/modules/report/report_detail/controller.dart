import 'package:get/get.dart';


class ReportDetailController extends GetxController {
   //loading
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;
}
