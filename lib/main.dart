import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unnecessary_import
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation layer/controller/audiocontroller.dart';
import 'presentation layer/controller/playercontroller.dart';
import 'presentation layer/controller/playlist_controller.dart';
import 'presentation layer/controller/usercontroller.dart';
import 'presentation layer/models/playlist_model.dart';
import 'presentation layer/models/user_model.dart';
import 'views/homepage.dart';
import 'views/preloaderscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlaylistModelAdapter());
  await Hive.openBox<PlaylistModel>('playlists');
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('userBox');


//  Get.put(AudioController());
  Get.put(PlayerController());
  Get.put(PlaylistController()); // <-- inject here

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    Get.put(AudioController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: userController.isLoggedIn ? const HomeScreen() : PreloaderScreen(),
    );
  }
}
