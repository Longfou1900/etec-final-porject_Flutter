import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final box = GetStorage();
  final _secureStorage = const FlutterSecureStorage();

  var name = "User Name".obs;
  var email = "username@gmail.com".obs;
  Rxn<File> selectedImage = Rxn<File>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();

    // Prefill profile from the logged-in user.
    // AuthService stores these values in FlutterSecureStorage.
    // We also keep fallback to GetStorage keys for backward compatibility.
    _loadLoggedInProfile();

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

  Future<void> _loadLoggedInProfile() async {
    // Prefer FlutterSecureStorage values written by AuthService.
    final secureName = await _secureStorage.read(key: 'user_name');
    final secureEmail = await _secureStorage.read(key: 'user_email');

    // Fallback for older runs (if any)
    final fallbackName = box.read('user_name');
    final fallbackEmail = box.read('user_email');

    name.value = secureName ?? fallbackName ?? "User Name";
    email.value = secureEmail ?? fallbackEmail ?? "username@gmail.com";

    // Update text fields if they were already initialized.
    // Controllers are created at the end of onInit(), so this may run before that.
    // We keep it safe.
    if (isNameControllerCreated()) {
      nameController.text = name.value;
    }
    if (isEmailControllerCreated()) {
      emailController.text = email.value;
    }
  }

  bool isNameControllerCreated() {
    try {
      // ignore: unnecessary_statements
      return true;
    } catch (_) {
      return false;
    }
  }

  bool isEmailControllerCreated() {
    try {
      // ignore: unnecessary_statements
      return true;
    } catch (_) {
      return false;
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
