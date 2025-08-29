import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/View/Exercises_by_type.dart';
import '../controllers/workout_day_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExercisesPage extends StatefulWidget {
  final String type;
  const ExercisesPage({super.key, required this.type});
 
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
    String getBackgroundImage() {
    switch (widget.type) {
      case 'warming up':
        return 'assets/image/istockphoto-1324669937-612x612-4.webp';
      case 'stretching':
        return 'assets/image/images.png';
      default:
        return ''; 
    }
  }
 
  final WorkoutDayController controller2 = Get.find<WorkoutDayController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller2.fetchwarmupExercises(widget.type);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller2.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${controller2.errorMessage.value}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        final exerciseData = controller2.exercisesPyType.value;
        if (exerciseData == null) {
          return const Center(child: CircularProgressIndicator(color: Colors.blue,));
        }

        final exercises = exerciseData.exercises;

        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 230,
              pinned: true,
              backgroundColor: const Color.fromARGB(255, 131, 196, 231),
              elevation: 10,
              automaticallyImplyLeading: false,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  final maxHeight = 230.0;
                  final top = constraints.biggest.height;
                  final opacity = ((top - kToolbarHeight) / (maxHeight - kToolbarHeight)).clamp(0.0, 1.0);

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        top: -(maxHeight - top) * 0.3, 
                        left: 0,
                        right: 0,
                        child: Opacity(
                          opacity: opacity,
                          child: Image.asset(
                           getBackgroundImage(),
                            fit: BoxFit.cover,
                            height: maxHeight,
                          ),
                        ),
                      ),
                      Container(color: Colors.black.withOpacity(0.1)),
                      SafeArea(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Get.back(),
                          ),
                        ),
                      ),
                    ],
                  );
                },
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InfoBox(
                           title: "${(exerciseData.totaldurationminutes ?? 0).toStringAsFixed(1)} mins",
                            subtitle: "Duration",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: InfoBox(
                            title: "${exerciseData.count}",
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
      final ex = exercises![index];
      final isEven = index % 2 == 0;

      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: isEven
                  ?  [const Color.fromARGB(255, 246, 247, 248), const Color(0xFFE1F5FE)]
                  : [const Color.fromARGB(255, 246, 247, 248), const Color(0xFFE1F5FE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              final box = GetStorage();
              box.write('idexercise', ex.id);
              Get.to(() => ExercisebyTypePage(exerciseId: ex.id));
            },
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: ex.image,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              ex.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
            ),
            subtitle: Text(
              "x${ex.duration}",
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ),
      );
    },
    childCount: exercises?.length,
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
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 236, 239, 240), Color.fromARGB(255, 180, 223, 241)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
