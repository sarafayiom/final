import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/View/ExerciseDetailPage.dart';
import '../controllers/workout_day_controller.dart';

class WorkoutDayPage extends StatefulWidget {
  final int day;
  final int challengeId;
  const WorkoutDayPage(
   , required int challengeId, required int challengeId   {super.key, required this.day, required this.challengeId});

  @override
  _WorkoutDayPageState createState() => _WorkoutDayPageState();
}

class _WorkoutDayPageState extends State<WorkoutDayPage> {
  final WorkoutDayController controller = Get.find<WorkoutDayController>();

  @override
  void initState() {
    super.initState();
    controller.fetchWorkoutDay(widget.day, widget.challengeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Obx(() {
        final workout = controller.workoutDay.value;

        if (workout == null) {
          return const SizedBox();
        }

        final exercises = workout.exercises;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: Colors.black,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/image/photo_2025-08-22_20-43-46.jpg',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DAY ${workout.dayNumber}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InfoBox(
                            title:
                                "${workout.totalDurationMinutes.toStringAsFixed(1)} mins",
                            subtitle: "Duration",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InfoBox(
                            title: "${workout.totalExercises}",
                            subtitle: "Exercises",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final ex = exercises[index];
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? const Color.fromARGB(255, 234, 232, 238)
                            : const Color.fromARGB(255, 234, 232, 238),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () {
                          final box = GetStorage();
                          box.write('idexercise', ex.dayExerciseId);
                          Get.to(
                            () => ExerciseDetailPage(
                              exerciseId: ex.dayExerciseId, 
                              exercises: exercises,
                              startIndex: index, 
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: ex.image,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          ex.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          "x${ex.repetitions}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: exercises.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 202, 195, 216),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    await controller.startchallenge(widget.challengeId);
                    if (exercises.isNotEmpty) {
                      Get.to(
                        () => ExerciseDetailPage(
                          exerciseId:
                              exercises.first.dayExerciseId, // أول تمرين
                          exercises: exercises, // كل التمارين
                          startIndex: 0, // البداية من أول تمرين
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Start",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class InfoBox extends StatelessWidget {
  final String title;
  final String subtitle;

  const InfoBox({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 225, 217, 238),
            Color.fromARGB(255, 247, 244, 246),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}