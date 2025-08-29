import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  final String title;
  final String? description;
  final String imagePath;
  final VoidCallback? onTap;
  final bool showStartButton;

  const ChallengeCard({
    Key? key,
    required this.title,
    this.description,
    required this.imagePath,
    this.onTap,
    this.showStartButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        width: 240,
        height: 240,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.2),
          ),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (description != null && description!.isNotEmpty)
                Text(
                  description!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              const SizedBox(height: 10),
              if (showStartButton && onTap != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'START',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}