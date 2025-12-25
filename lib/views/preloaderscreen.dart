// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../controllers/user_controller.dart';
import '../presentation layer/controller/usercontroller.dart';
import '../presentation layer/utils/managekeyboard.dart';
import 'homepage.dart';

class PreloaderScreen extends StatelessWidget {
  PreloaderScreen({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Profile Image Picker
              Obx(() {
                final image = userController.pickedImage.value;
                return GestureDetector(
                  onTap: () {
                    userController.pickProfileImage();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 60,
                    backgroundImage: image != null ? FileImage(image) : null,
                    child: image == null
                        ? const Icon(Icons.camera_alt, size: 32)
                        : null,
                  ),
                );
              }),
      
              const SizedBox(height: 24),
      
              /// Name Input
              TextField(
                cursorColor: Colors.black,
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Your Name",
      
                  // Normal border
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey, // jab focus na ho
                      width: 1.5,
                    ),
                  ),
      
                  // Focused border
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.black, // jab focus ho
                      width: 2,
                    ),
                  ),
                ),
              ),
      
              const SizedBox(height: 24),
      
              /// Continue Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    Get.snackbar("Error", "Please enter your name");
                    return;
                  }
      
                  if (userController.pickedImage.value == null) {
                    Get.snackbar("Error", "Please select a profile image");
                    return;
                  }
      
                  await userController.saveUser(name);
                  Get.offAll(() => const HomeScreen());
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
