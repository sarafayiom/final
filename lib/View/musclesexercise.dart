import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkoutTimerScreen extends StatefulWidget {
  final exercise;

  WorkoutTimerScreen({required this.exercise});

  @override
  _WorkoutTimerScreenState createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  late var exercise;
  Timer? timer;
  late int secondsRemaining;
  final player = AudioPlayer();
  bool isRunning = true;

  @override
  void initState() {
    super.initState();
    exercise = widget.exercise;
    secondsRemaining = exercise.durationSeconds;
    player.play(AssetSource("audio/whistle_sound.mp3"));
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (t) async {
      if (!isRunning) return;

      if (secondsRemaining > 0) {
        setState(() => secondsRemaining--);

        if (secondsRemaining <= 5 && secondsRemaining > 0) {
   
          await player.play(AssetSource("audio/counter_sound.mp3"));
        }
      } else {
        t.cancel();
        await player.play(AssetSource("audio/whistle_sound.mp3"));
        
        
        Get.offAllNamed('/WorkoutDayPage');
      }
    });
  }

  void toggleTimer() {
    setState(() {
      isRunning = !isRunning;
    });
  }

  Color getProgressColor() {
    double progress = secondsRemaining / exercise.durationSeconds;
    if (secondsRemaining <= 10) return Colors.red;
    if (progress <= 0.5) return Colors.yellow;
    return Colors.orangeAccent;
  }

  @override
  void dispose() {
    timer?.cancel();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = secondsRemaining / exercise.durationSeconds;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 230, 215),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (exercise.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: exercise.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            const SizedBox(height: 30),
            const Text(
              "READY TO GO",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 128, 94, 55)),
            ),
            const SizedBox(height: 10),
            Text(
              exercise.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 10,
                    backgroundColor: Colors.grey.shade300,
                    color: getProgressColor(),
                  ),
                ),
                Text(
                  "$secondsRemaining s",
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: toggleTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 241, 230, 218),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                isRunning ? 'Stop' : 'Resume',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}