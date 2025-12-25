import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../controllers/user_controller.dart';
import '../presentation layer/controller/usercontroller.dart';
import '../presentation layer/utils/apptheme.dart';
import '../presentation layer/utils/managekeyboard.dart';
// import '../core/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userController = Get.find<UserController>();
  final nameController = TextEditingController();
  // String? imagePath;

 @override
void initState() {
  super.initState();
  final user = userController.user.value;
  if (user != null) {
    nameController.text = user.name;
  }
}


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: Scaffold(
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// PROFILE IMAGE
              Obx(() {
                final imageFile = userController.pickedImage.value;
      
                return GestureDetector(
                  onTap: userController.pickProfileImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        imageFile != null ? FileImage(imageFile) : null,
                    child: imageFile == null
                        ? const Icon(Icons.camera_alt, size: 30)
                        : null,
                  ),
                );
              }),
      
              const SizedBox(height: 20),
      
              /// NAME FIELD
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Your Name",
                ),
              ),
      
              const SizedBox(height: 30),
      
              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final name = nameController.text;
                    if (name.isEmpty) {
                      Get.snackbar("Error", "Please enter your name");
                      return;
                    }
                    await userController.saveUser(name);
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.icon,
                  ),
                  child:  Text("Save", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
