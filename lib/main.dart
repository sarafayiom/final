import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Bindings/binding.dart';
import 'package:homeworkout_flutter/Controllers/notification_controller.dart';
import 'package:homeworkout_flutter/Controllers/settings_controller.dart';
import 'package:homeworkout_flutter/Services/api_refresh_token.dart';
import 'package:homeworkout_flutter/Services/api_wallet.dart';
import 'package:homeworkout_flutter/View/Challenge1Page.dart';
import 'package:homeworkout_flutter/View/Challenge2Page.dart';
import 'package:homeworkout_flutter/View/ExerciseDetailPage.dart';
import 'package:homeworkout_flutter/View/WorkOutDayPage.dart';
import 'package:homeworkout_flutter/View/create_challenge.dart';
import 'package:homeworkout_flutter/View/exercisespage.dart';
import 'package:homeworkout_flutter/View/home.dart';
import 'package:homeworkout_flutter/View/login.dart';
import 'package:homeworkout_flutter/View/signup..dart';
import 'package:homeworkout_flutter/View/signup_step3.dart';
import 'package:homeworkout_flutter/View/signup_step4.dart';
import 'package:homeworkout_flutter/View/startupscreen.dart';
import 'package:homeworkout_flutter/View/temporarypage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:homeworkout_flutter/View/timer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ApiRefreshToken());
  Get.put(ApiWallet());
  final settingsController = Get.put(SettingsController());
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  String? token = await FirebaseMessaging.instance.getToken();
  GetStorage store = GetStorage();
  if (token != null) {
    store.write("fcm_token", token);
    print("FCM Token saved: $token");
  } else {
    print("FCM Token is null!");
  }
  print("FCM Token: $token");

  runApp(MyApp(settingsController: settingsController));
}

class MyApp extends StatefulWidget {
  final SettingsController settingsController;

  const MyApp({super.key, required this.settingsController});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          cardColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
          ),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: widget.settingsController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,
        initialBinding: Binding(),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => StartupScreen()),
          GetPage(name: '/login', page: () => LogIn()),
          GetPage(name: '/signup_step1', page: () => SignUp()),
          GetPage(name: '/signup_step3', page: () => SignupStep3()),
          GetPage(name: '/signup_step4', page: () => SignupStep4()),
          GetPage(name: '/CreateChallenge', page: () => CreateChallenge()),
          GetPage(name: '/TrainingPage', page: () => TrainingPage()),
          GetPage(
            name: '/Challenge1Page',
            page: () {
              final challengeId = Get.arguments as int;
              return Challenge1Page(challengeId: challengeId);
            },
          ),
          GetPage(
            name: '/Challenge2Page',
            page: () {
              final challengeId = Get.arguments as int;
              return Challenge2Page(challengeId: challengeId);
            },
          ),
          GetPage(
            name: '/WorkoutDayPage',
            page: () {
              final day = int.tryParse(Get.parameters['day'] ?? '1') ?? 1;
              final challengeId =
                  int.tryParse(Get.parameters['challengeId'] ?? '0') ?? 0;
              return WorkoutDayPage(day: day, challengeId: challengeId);
            },
          ),
          GetPage(
            name: '/exercise_page',
            page: () {
              final int exerciseId =
                  int.tryParse(Get.parameters['id'] ?? '1') ?? 0;

              final List<dynamic> exercises = Get.arguments?['exercises'] ?? [];
              final int startIndex = Get.arguments?['startIndex'] ?? 0;

              return ExerciseDetailPage(
                exerciseId: exerciseId,
                exercises: exercises,
                startIndex: startIndex,
              );
            },
          ),
          GetPage(
            name: '/WorkoutTimerScreen',
            page: () {
              final exercise = Get.arguments;
              return WorkoutTimerScreen(exercise: exercise);
            },
          ),
          GetPage(
            name: '/TimerScreen',
            page: () {
              final exercise = Get.arguments;
              return TimerScreen(
                exercise: exercise,
              );
            },
          ),
          GetPage(
            name: '/MusclesPage',
            page: () {
              final muscleId = Get.parameters['muscleId'] ?? '';
              final muscleName = Get.parameters['muscleName'] ?? '';
              return MusclesPage(
                muscleId: muscleId,
                muscleName: muscleName,
              );
            },
          ),
          GetPage(
            name: '/ExercisesPage',
            page: () {
              final type = Get.parameters['type'] ?? '';
              return ExercisesPage(type: type);
            },
          ),
        ],
      );
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
