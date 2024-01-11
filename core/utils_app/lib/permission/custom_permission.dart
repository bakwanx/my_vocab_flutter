import 'package:common_dependency/common_dependency.dart';

class CustomPermission {
  Future<bool> checkPermissionStorage() async {
    final permission = await Permission.storage.status;
    if (permission.isDenied) {
      await Permission.storage.request();
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkPermissionLocation() async {
    final permission = await Permission.location.status;
    if (permission.isDenied) {
      await Permission.location.request();
      return false;
    } else {
      return true;
    }
  }
}
