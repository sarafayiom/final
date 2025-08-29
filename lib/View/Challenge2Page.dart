import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'WorkoutDayPage.dart';

class Challenge2Page extends StatefulWidget {
   final int challengeId;
  const Challenge2Page({super.key,required this.challengeId});

  @override
  State<Challenge2Page> createState() => _Challenge2PageState();
}

class _Challenge2PageState extends State<Challenge2Page> {
  
  int totalDays = 28;
  final Color dayColor = const Color.fromARGB(255, 191, 179, 212);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Container(
                    height: 240,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/image/photo_2025-08-23_00-50-04.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

         
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LinearProgressIndicator(
                  value: totalDays / 28,
                  backgroundColor: Colors.grey.shade300,
                  color: dayColor,
                ),
              ),
            ),

           
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, weekIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Week ${weekIndex + 1}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 7,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemBuilder: (context, dayIndex) {
                            final globalDayIndex = weekIndex * 7 + dayIndex + 1;
                            return GestureDetector(
                              onTap: () {
                                Get.to(() =>
                                    WorkoutDayPage(day: globalDayIndex, challengeId: widget.challengeId,));
                              },
                              child: CircleAvatar(
                                backgroundColor: dayColor,
                                child: Text(
                                  "$globalDayIndex",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                },
                childCount: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}