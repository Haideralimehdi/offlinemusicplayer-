import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation layer/controller/login_controller.dart';
import '../presentation layer/utils/managekeyboard.dart';
import 'homepage.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => KeyboardUtil.hideKeyboard(context),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0F2027),
                Color(0xFF203A43),
                Color(0xFF2C5364),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.1),
                  /// 🎵 APP LOGO
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white12,
                    child: Icon(
                      Icons.music_note_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// APP NAME
                  const Text(
                    "MuzikFlow",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Sign in to continue",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: size.height * 0.06),

                  /// EMAIL
                  _field(
                    controller: email,
                    label: "Email",
                    icon: Icons.email_outlined,
                  ),

                  /// PASSWORD
                  _field(
                    controller: password,
                    label: "Password",
                    icon: Icons.lock_outline,
                    isPassword: true,
                  ),

                  const SizedBox(height: 30),

                  /// LOGIN BUTTON
                  Obx(() => SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  if (email.text.trim().isEmpty ||
                                      password.text.length < 6) {
                                    Get.snackbar(
                                      "Error",
                                      "Invalid email or password",
                                    );
                                    return;
                                  }

                                  final success = await controller.login(
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                  );

                                  if (success) {
                                    Get.offAll(() => const HomeScreen());
                                  }
                                },
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      )),

                  const SizedBox(height: 24),

                  /// BACK TO REGISTER
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Create new account",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔹 INPUT FIELD
  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white12,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
