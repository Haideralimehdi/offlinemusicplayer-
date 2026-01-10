import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation layer/controller/auth_controller.dart';
import '../presentation layer/utils/managekeyboard.dart';
import 'homepage.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController auth = Get.put(AuthController());
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

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
                  SizedBox(height: size.height * 0.08),

                  /// 🎵 APP LOGO
                  const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white12,
                    child: Icon(
                      Icons.person_add_alt_1,
                      size: 42,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// APP NAME
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Join MuzikFlow today",
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: size.height * 0.05),

                  /// FULL NAME
                  _field(
                    controller: name,
                    label: "Full Name",
                    icon: Icons.person_outline,
                  ),

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

                  const SizedBox(height: 28),

                  /// REGISTER BUTTON
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
                          onPressed: auth.isLoading.value
                              ? null
                              : () async {
                                  if (name.text.trim().isEmpty ||
                                      email.text.trim().isEmpty ||
                                      password.text.length < 6) {
                                    Get.snackbar(
                                      "Error",
                                      "Please fill all fields correctly",
                                    );
                                    return;
                                  }

                                  await auth.register(
                                    name: name.text.trim(),
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                  );

                                  Get.offAll(() => const HomeScreen());
                                },
                          child: auth.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text(
                                  "Create Account",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      )),

                  const SizedBox(height: 22),

                  /// GO TO LOGIN
                  TextButton(
                    onPressed: () => Get.to(() => LoginScreen()),
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                      ),
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

  /// 🔹 INPUT FIELD (Reusable)
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
