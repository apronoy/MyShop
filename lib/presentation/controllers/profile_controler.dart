import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final fullNameController = TextEditingController(text: "Pronoy Sarkar");

  final genderController = TextEditingController(text: "Male");

  final birthdayController = TextEditingController(text: "05-01-2004");

  final phoneController = TextEditingController(text: "(+880) 1846624175");

  final emailController = TextEditingController(text: "pronoysarkar@gmail.com");

  final userNameController = TextEditingController(text: "@pronoy_17");

  void saveProfile() {
    print(fullNameController.text);
    print(genderController.text);
    print(birthdayController.text);
    print(phoneController.text);
    print(emailController.text);
    print(userNameController.text);

    // API call here
  }

  @override
  void onClose() {
    fullNameController.dispose();
    genderController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    emailController.dispose();
    userNameController.dispose();
    super.onClose();
  }
}
