import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/View/timer.dart';
import 'package:homeworkout_flutter/controllers/exercises_controller.dart';

class ExercisebyTypePage extends StatefulWidget {
  final int exerciseId;
  const ExercisebyTypePage({super.key, required this.exerciseId});

  @override
  State<ExercisebyTypePage> createState() => _ExercisebyTypePageState();
}

class _ExercisebyTypePageState extends State<ExercisebyTypePage> {
  final controller2 = Get.find<ExercisesController>();

  @override
  void initState() {
    super.initState();
    controller2.fetchExercise(widget.exerciseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDEBD5),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Obx(() {
        final exerciseDetail = controller2.exercisebytype.value;
        if (exerciseDetail == null) {
          return const SizedBox();
        }

        final ex = exerciseDetail;
        const String baseUrl = "http://91.144.22.63:4567";
        final String imageUrl = "$baseUrl${ex.image}";

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
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator(color: Colors.blueAccent,)),
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
                            fontSize: 14, fontWeight: FontWeight.bold),
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
                              subtitle: "${ex.baseDurationSeconds} sec",
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InfoBox(
                              title: "Repetitions",
                              subtitle: "x${ex.baseRepetitions}",
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
                              subtitle: "${ex.baseCaloriesBurned} ",
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
                              () => TimerScreen( exercise: ex),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ).copyWith(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            elevation: WidgetStateProperty.all(4),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 247, 238, 228),
                              borderRadius: BorderRadius.circular(12),
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
              fontSize: 14,
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
