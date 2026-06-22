import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  var name = "User Name".obs;
  var email = "username@gmail.com".obs;
  Rxn<File> selectedImage = Rxn<File>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    // Load persisted data
    name.value = box.read('user_name') ?? "User Name";
    email.value = box.read('user_email') ?? "username@gmail.com";

    // Load persisted image path
    String? savedImagePath = box.read('profile_image_path');
    if (savedImagePath != null) {
      selectedImage.value = File(savedImagePath);
    }

    nameController = TextEditingController(text: name.value);
    emailController = TextEditingController(text: email.value);
  }

  void saveProfile() {
    name.value = nameController.text;
    email.value = emailController.text;
    box.write('user_name', name.value);
    box.write('user_email', email.value);
    Get.back();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      // Persist the image path
      box.write('profile_image_path', pickedFile.path);
    }
  }

  void resetProfileData() {
    box.erase();
    name.value = "User Name";
    email.value = "username@gmail.com";
    selectedImage.value = null;
    nameController.text = "User Name";
    emailController.text = "username@gmail.com";
  }
}
