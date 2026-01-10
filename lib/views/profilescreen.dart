import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player2/presentation%20layer/controller/profile_controller.dart';
// import '../presentation layer/controller/usercontroller.dart';
import '../presentation layer/utils/managekeyboard.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final UserController userController = Get.find<UserController>();
  final ProfileController userController = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: StreamBuilder(
          stream: userController.userStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data!.data()!;
            nameController.text = data['name'];
            emailController.text = data['email'];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.08),

                  /// STATIC AVATAR
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// NAME (EDITABLE)
                  _field("Full Name", nameController),

                  /// EMAIL (READ ONLY)
                  _field(
                    "Email",
                    emailController,
                    readOnly: true,
                  ),

                  const SizedBox(height: 30),

                  /// SAVE BUTTON
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        onPressed: userController.isLoading.value
                            ? null
                            : () async {
                                final name = nameController.text.trim();
                                if (name.isEmpty) {
                                  Get.snackbar(
                                      "Error", "Name cannot be empty");
                                  return;
                                }

                                await userController.updateName(name);
                                Get.snackbar(
                                  "Success",
                                  "Profile updated successfully",
                                );
                              },
                        child: userController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Save Changes",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _field(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          filled: readOnly,
          fillColor: readOnly ? Colors.grey.shade100 : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
