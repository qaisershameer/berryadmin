import 'package:get/get.dart';

abstract class BaseViewModel extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxBool _isError = false.obs;
  final RxString _errorMessage = ''.obs;

  bool get isLoading => _isLoading.value;
  bool get isError => _isError.value;
  String get errorMessage => _errorMessage.value;

  void setLoading(bool value) => _isLoading.value = value;
  void setError(bool value, [String? message]) {
    _isError.value = value;
    if (message != null) _errorMessage.value = message;
  }

  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 3),
    );
  }

  void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.colorScheme.primary,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 2),
    );
  }
} 