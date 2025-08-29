import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/home_controller.dart';
import 'package:homeworkout_flutter/Models/user_challenge_model.dart';
import 'package:homeworkout_flutter/View/Articlespage.dart';
import 'package:homeworkout_flutter/View/Challenge1Page.dart';
import 'package:homeworkout_flutter/View/Challenge2Page.dart';
import 'package:homeworkout_flutter/View/ReportPage.dart';
import 'package:homeworkout_flutter/View/SettingsPage.dart';
import 'package:homeworkout_flutter/View/exercisespage.dart';
import 'package:homeworkout_flutter/View/musclesexercise.dart';
import 'package:homeworkout_flutter/constants/app_colors.dart';
import 'package:homeworkout_flutter/constants/app_styles.dart';
import 'package:homeworkout_flutter/widgets/challenge_card.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({Key? key}) : super(key: key);

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    TrainingContent(),
    Articlespage(),
    Reportpage(),
    Settingspage(),
  ];

  void onNavTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 233, 226, 233),
          elevation: 1,
          title: const Text(
            'HOME WORKOUT',
            style: TextStyle(
              color: Color.fromARGB(255, 14, 12, 13),
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onNavTapped,
        backgroundColor: AppColors.background,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center_outlined),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Health Articles',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class TrainingContent extends StatefulWidget {
  const TrainingContent({Key? key}) : super(key: key);

  @override
  State<TrainingContent> createState() => _TrainingContentState();
}

class _TrainingContentState extends State<TrainingContent> {
  final homeController = Get.find<HomeController>();

  final List<Map<String, String>> musclegroups = [
    {"id": "1", "name": "Arms"},
    {"id": "2", "name": "Legs"},
    {"id": "3", "name": "Back"},
    {"id": "4", "name": "Chest"},
    {"id": "5", "name": "Glutes"},
    {"id": "6", "name": "Full_Body"},
  ];

  late final List<String> bodyParts;
  String selectedBodyPart = "Arms";

  @override
  void initState() {
    super.initState();
    bodyParts = musclegroups.map((e) => e['name']!).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 30),
        Text("Challenge", style: AppStyles.headerMedium),
        const SizedBox(height: 10),

        SizedBox(
          height: 230,
          child: Obx(() {
            if (homeController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (homeController.userChallenges.value == null) {
              return const Center(child: Text('No Challenge Found'));
            } else {
              UserChallengeModel userChallenges =
                  homeController.userChallenges.value!;
              List<Widget> challengeCards = [];

              if (userChallenges.userChallenge != null) {
                challengeCards.add(
                  ChallengeCard(
                    title: userChallenges.userChallenge!.name,
                    description: "4 weeks to achieve your goal!",
                    imagePath: 'assets/image/Personalized workouts-amico.png',
                    onTap: () {
                    final challengeId = userChallenges.userChallenge!.id; 
                 Get.to(() => Challenge1Page(challengeId: challengeId));
                    },
                    showStartButton: true,
                  ),
                );
              }

              if (userChallenges.publicChallenges != null) {
                for (var publicChallenge
                    in userChallenges.publicChallenges!) {
                  challengeCards.add(
                    ChallengeCard(
                      title: publicChallenge.name ?? 'Unnamed Public Challenge',
                      imagePath: 'assets/image/Training at home-amico.png',
                      onTap: () {
                       final int challengeId = publicChallenge.id!;
                  Get.to(() => Challenge2Page(challengeId: challengeId));
                      
                      },
                      showStartButton: true,
                    ),
                  );
                }
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: challengeCards.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, i) => challengeCards[i],
              );
            }
          }),
        ),
        
        const SizedBox(height: 40),
        Text("Body Focus", style: AppStyles.headerMedium),
        const SizedBox(height: 10),

        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: bodyParts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final part = bodyParts[index];
              final isSelected = selectedBodyPart == part;
              return _buildBodyTab(part, isSelected);
            },
          ),
        ),

        const SizedBox(height: 30),
        Text("Warm Up & Stretch", style: AppStyles.headerMedium),
        const SizedBox(height: 10),

        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ChallengeCard(
                title: "Warm Up Exercises",
                imagePath: 'assets/image/Physical education-pana.png',
                onTap: () {
                  Get.to(() => ExercisesPage(type: "warming up"));
                },
              ),
              const SizedBox(width: 12),
              ChallengeCard(
                title: "Stretch Exercises",
                imagePath: 'assets/image/stretch.jpg',
                onTap: () {
                  Get.to(() => ExercisesPage(type: "stretching"));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBodyTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        final muscle = musclegroups.firstWhere(
          (element) => element['name']!.toLowerCase() == label.toLowerCase(),
          orElse: () => {"id": "0", "name": "unknown"},
        );
        final muscleId = muscle['id']!;
        Get.to(() => MusclesPage(muscleId: muscleId, muscleName: label));
        setState(() {
          selectedBodyPart = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.background : AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}