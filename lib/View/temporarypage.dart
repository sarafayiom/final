import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/exercise_model.dart';


class WorkoutTimerScreen extends StatefulWidget {
  final int exerciseId;
  const WorkoutTimerScreen({super.key, required this.exerciseId});

  @override
  _WorkoutTimerScreenState createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  Exercise? exercise;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadExercise(widget.exerciseId);
  }

  Future<void> loadExercise(int id) async {
    setState(() {
      isLoading = true;
    });

   
    await Future.delayed(Duration(seconds: 1)); 
   
    // exercise = Exercise(
    //   id: id,
    //   name: 'تمرين $id',
    //   description: 'وصف التمرين $id',
    // );

    setState(() {
      isLoading = false;
    });
  }

  void nextExercise() {
    int nextId = exercise!.id + 1;
    if (nextId > 3) {
     
      Get.back(); 
      return;
    }
    loadExercise(nextId);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (exercise == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text('Failed to load exercise')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Timer - ${exercise!.name}')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(exercise!.description, style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: nextExercise,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
