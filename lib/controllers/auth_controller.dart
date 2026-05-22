import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/login_view.dart';
import '../views/character_view.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  void login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (username == 'tpm' && password == '123230099') {
      await prefs.setBool('isLoggedIn', true);
      isLoggedIn.value = true;

      Get.offAll(() => const CharacterView());
      Get.snackbar(
        'Success',
        'Login Berhasil!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Failed',
        'Username atau Password Salah!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLoggedIn', false);
    isLoggedIn.value = false;

    Get.offAll(() => const LoginView());
    Get.snackbar(
      'Logout',
      'Anda telah keluar dari aplikasi',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
