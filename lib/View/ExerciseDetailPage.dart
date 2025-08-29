import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/View/temporarypage.dart';
import 'package:homeworkout_flutter/controllers/exercises_controller.dart';

class ExerciseDetailPage extends StatefulWidget {
  final int exerciseId;
  final List<dynamic> exercises;
  final int startIndex;

  const ExerciseDetailPage({
    super.key,
    required this.exerciseId,
    required this.exercises,
    required this.startIndex,
  });
  @override
  State<ExerciseDetailPage> createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  final controller = Get.find<ExercisesController>();
 

  @override
  void initState() {
    super.initState();
    controller.fetchExerciseDetail(widget.exerciseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 230, 215),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        final exerciseDetail = controller.exerciseDetail.value;
        if (exerciseDetail == null) {
          return const SizedBox();
        }

        final ex = exerciseDetail.exercise;

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          imageUrl: ex.image,
                          placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                            color: Colors.deepOrangeAccent,
                          )),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Description:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 247, 238, 228),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          ex.description,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: InfoBox(
                              title: "Duration",
                              subtitle: "${ex.durationSeconds} sec",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InfoBox(
                              title: "Repetitions",
                              subtitle: "x${ex.repetitions}",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: InfoBox(
                              title: "CaloriesBurned",
                              subtitle: "${ex.caloriesBurned} ",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InfoBox(
                              title: "Goal",
                              subtitle: " ${ex.goal}",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(
                              () => WorkoutTimerScreen(exercise: ex),
                            );
                          },
                        

                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ).copyWith(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 247, 238, 228),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "Start",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
        color: const Color.fromARGB(255, 247, 238, 228),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
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