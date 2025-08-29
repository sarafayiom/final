import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/View/WorkOutDayPage.dart';
import 'package:homeworkout_flutter/Controllers/challenge_controller.dart';

class Challenge1Page extends StatefulWidget {
   final int challengeId;
  const Challenge1Page({super.key, required this.challengeId});

  @override
  State<Challenge1Page> createState() => _Challenge1PageState();
}

class _Challenge1PageState extends State<Challenge1Page> {
  final ChallengeController challengeController = Get.find<ChallengeController>();

  @override
  void initState() {
    super.initState();
 challengeController.loadCachedDay(); 
challengeController.fetchAvailableDaysFromServer(widget.challengeId);
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 5,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          int availableDays = challengeController.availableDays.value;
            print("availableDays = $availableDays");
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 280,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/image/Healthy lifestyle-rafiki.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    color: Colors.grey.withOpacity(0.4),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Challenge According To Your Goals",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          shadows: [Shadow(blurRadius: 2, color: Colors.white)],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LinearProgressIndicator(
                    value: availableDays / 28,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final weekIndex = index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Week ${weekIndex + 1}",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 8,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 8,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              if (index < 7) {
                                final globalDayIndex = weekIndex * 7 + index;
                                final isUnlocked =
                                    globalDayIndex < availableDays;
                                  print("Day ${globalDayIndex + 1} => ${isUnlocked ? 'OPEN' : 'LOCKED'}");

                                return GestureDetector(
                                  onTap: isUnlocked
                                      ? () {
                                          Get.to(() => WorkoutDayPage(
                                              day: globalDayIndex + 1, challengeId: widget.challengeId));
                                        }
                                      : null,
                                  child: CircleAvatar(
                                    backgroundColor: isUnlocked
                                        ? const Color.fromARGB( 255, 191, 179, 212)
                                        : Colors.grey.shade300,
                                    child: Text(
                                      "${index + 1}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              } else {
                                final isWeekCompleted =
                                    (weekIndex + 1) * 7 <= availableDays;
                                return CircleAvatar(
                                  backgroundColor: isWeekCompleted
                                      ? Colors.amberAccent
                                      : Colors.grey.shade300,
                                  child: const Icon(
                                    Icons.emoji_events,
                                    color: Colors.black26,
                                    size: 20,
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 35),
                        ],
                      ),
                    );
                  },
                  childCount: 4,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}