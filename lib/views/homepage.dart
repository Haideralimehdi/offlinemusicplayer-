// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player2/presentation%20layer/widget/miniplayerwidget.dart';
import 'package:music_player2/views/playlistscreen.dart';
import '../presentation layer/controller/audiocontroller.dart';
import '../presentation layer/controller/playercontroller.dart';
// import '../presentation layer/controller/themecontroller.dart';
import '../presentation layer/controller/profile_controller.dart';
import '../presentation layer/utils/apptheme.dart';
import '../presentation layer/widget/allsongswidget.dart';
import '../presentation layer/widget/featuredcard.dart';
import 'profilescreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AudioController c = Get.put(AudioController());
    final playerController = Get.put(PlayerController());
    // final UserController userController = Get.put(UserController());
    // final PlaylistController playlistController = Get.put(PlaylistController());
    // final ThemeController themeController = Get.put(ThemeController());
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: AppTheme.icon,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "MuzikFlow",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => PlaylistScreen());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
              child: Icon(
                color: AppTheme.icon,
                Icons.playlist_add,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            /// 🔥 PROFILE HEADER (FIREBASE)
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                String userName = "Guest User";

                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  userName = data['name'] ?? "Guest User";
                }

                return UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: AppTheme.backgroundGradient,
                  ),

                  /// 👤 STATIC AVATAR
                  currentAccountPicture: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.black,
                    ),
                  ),

                  /// USER NAME
                  accountName: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  accountEmail: const Text(
                    "Welcome back 👋",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),

                  /// SUBTITLE
                );
              },
            ),

            /// 🏠 HOME
            ListTile(
              leading:  Icon(Icons.home, color: Colors.black),
              title:  Text(
                "Home",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                // Get.back();
                Get.to(() =>  HomeScreen());
              },
            ),

            /// 🎵 PLAYLISTS
            ListTile(
              leading:  Icon(Icons.playlist_play, color: Colors.black),
              title:  Text(
                "Playlists",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                // Get.back();
                Get.to(() =>  PlaylistScreen());
              },
            ),

            /// 👤 PROFILE
            ListTile(
              leading:  Icon(Icons.person, color: Colors.black),
              title:  Text(
                "Profile",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                // Get.back();
                Get.to(() =>  ProfileScreen());
              },
            ),

            const Divider(thickness: 1),

            /// ⚙ SETTINGS
            ListTile(
              leading:  Icon(Icons.settings, color: Colors.black),
              title:  Text(
                "Settings",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),

      // ✅ Filhal body empty rakhi hai (next step mein widgets add karenge)
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: Get.height / 65),
            // Row(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            //       child: Text(
            //         "Featured Album",
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: Get.width * 0.06,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //     const Spacer(),

            //   ],
            // ),
            SizedBox(height: Get.height / 90),
            // ✅ Featured Album Widget
            const FeaturedAlbumWidget(),
            SizedBox(height: Get.height / 65),
            AllSongsWidget(),
          ],
        ),
      ),
      bottomNavigationBar: MiniPlayer(),
    );
  }
}
