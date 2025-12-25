import 'dart:io';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final Box<UserModel> userBox = Hive.box<UserModel>('userBox');
  final ImagePicker _picker = ImagePicker();

  Rxn<UserModel> user = Rxn<UserModel>();
  Rxn<File> pickedImage = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  void loadUser() {
    if (userBox.isNotEmpty) {
      final savedUser = userBox.getAt(0);
      user.value = savedUser;

      // 🔥 VERY IMPORTANT
      if (savedUser!.imagePath.isNotEmpty) {
        pickedImage.value = File(savedUser.imagePath);
      }
    }
  }

  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  Future<void> saveUser(String name) async {
    if (name.trim().isEmpty) return;

    final newUser = UserModel(
      name: name,
      imagePath: pickedImage.value?.path ?? '',
    );

    await userBox.clear();
    await userBox.add(newUser);

    user.value = newUser;
  }

  bool get isLoggedIn => user.value != null;
}
