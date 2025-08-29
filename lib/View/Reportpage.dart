import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/report_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Reportpage extends StatelessWidget {
    Reportpage({super.key});
  final ReportController controller = Get.find<ReportController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.userState.value == null) {
          return Center(child: CircularProgressIndicator());
        }

        final user = controller.userState.value!;
        final bmiValue = user.bmiValue;
        Color bmiColor;
        if (bmiValue >= 18.5 && bmiValue < 25) {
          bmiColor = Colors.green;
        } else if (bmiValue >=25 && bmiValue < 30) {
          bmiColor = Colors.yellow;
        }else if(bmiValue<18.5){
           bmiColor = Colors.cyan;
        }
         else {
          bmiColor = Colors.red;
        }
        double percent = (bmiValue / 50).clamp(0.0, 1.0);

        return ListView(
          padding: EdgeInsets.all(16),
          children: [
             Center(
              child: Text(
                "Your achievement",
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,fontSize: 18, fontWeight: FontWeight.bold),
              ),),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAchievementCard(
                  context: context,
                  icon: Icons.local_fire_department,
                  value: "${user.totalCalories} kcal",
                  label: "Calories Burned",
                  color: Theme.of(context).brightness == Brightness.dark
        ? Colors.orange.shade400
        : Colors.orange.shade100,
                ),
                SizedBox(width: 16),
                _buildAchievementCard(
                  context: context,
                  icon: Icons.access_time,
                  value: "${user.totalMinutes} min",
                  label: "Workout Time",
                  color: Theme.of(context).brightness == Brightness.dark
        ? Colors.blue.shade400
        : Colors.blue.shade100,
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "BMI",
                style: TextStyle(color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            Card(color:  Theme.of(context).brightness == Brightness.dark
        ? Colors.grey.shade600
        : Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularPercentIndicator(
                      radius: 80.0,
                      lineWidth: 10.0,
                      percent: percent,
                      center: Text(
                        user.bmi,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      progressColor: bmiColor,
                      backgroundColor:  Colors.grey[200]!,
                      animation: true,
                      animateFromLastPercent: true,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "BMI is a measurement of a person's leanness or corpulence based on their height and weight, intended to quantify tissue mass.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color:Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.grey[700]),
                    ),
                    SizedBox(height: 20),
                      GridView(
                    shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(), 
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,     
    crossAxisSpacing: 10,   
    mainAxisSpacing: 10,  
    childAspectRatio: 3,    ),
                      children: [
                        _buildLegendBox(Colors.green, "Healthyweight"),
                        _buildLegendBox(Colors.yellow, "Overweight"),
                        _buildLegendBox(Colors.red, "Obese"),
                        _buildLegendBox(Colors.cyan, "Underweight"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

Widget _buildLegendBox(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      SizedBox(width: 6),
      Text(label, style: TextStyle(fontSize: 14)),
    ],
  );
}

Widget _buildAchievementCard({
  required BuildContext context,
  required IconData icon,
  required String value,
  required String label,
  required Color color,
}) {
  return Expanded(
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32, color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(fontSize: 14, color: Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black,),
            ),
          ],
        ),
      ),
    ),
  );
}
