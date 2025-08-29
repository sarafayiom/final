import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step4_controller.dart';

class SignupStep4 extends StatelessWidget {
  final signup4Controller = Get.find<Signup4Controller>();
  final signupController = Get.find<SignupController>();
   SignupStep4({super.key});
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child:  ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbColor:WidgetStateProperty.all(Colors.deepPurple) ),
            child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Obx(() {
  if (signupController.currentPage.value > 0) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back,weight: 40,),
        onPressed: () {
          signupController.previousPage();
        },
      ),
    );
  } else {
    return SizedBox.shrink();
  }
}),
                  SizedBox(height: 10),
                  Text(
                    "My Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What is your goal?",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MultiSelectContainer(
                    singleSelectedItem: true,
                    maxSelectableCount: 1,
                    onChange: (all, selectedItem) {
                      signup4Controller.selectedgoal(selectedItem!);
                    },
                    itemsDecoration: MultiSelectDecorations(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selectedDecoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: const [Colors.purple, Colors.blue]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    itemsPadding: const EdgeInsets.all(8),
                    items: signup4Controller.goal.map((goal) {
                      return MultiSelectCard(
                          value: goal["id"],
                          child: Flexible(
                            child: 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  goal["title"]!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  goal["subtitle"]!,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ));
                    }).toList(),
                  ), SizedBox(height: 20,),
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What muscle group whould you like to focus on?",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                  ),
                   SizedBox(height: 20,),
                   MultiSelectContainer(
                      onChange: (all, selectedItem) {
    signup4Controller.musclegroupsselected(all.cast<String>());
  },
                    itemsDecoration: MultiSelectDecorations(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selectedDecoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: const [Colors.purple, Colors.blue]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),wrapSettings: const WrapSettings(spacing: 10, runSpacing: 10),
                    itemsPadding: const EdgeInsets.all(8),
                    items: signup4Controller.musclegroups.map((muscle) {
                      return MultiSelectCard(
                          value: muscle["id"],
                          child: SizedBox(
                          width: 100, 
                      child: Center(
                     child: Text(
                           muscle["name"]!,
                       textAlign: TextAlign.center,
                     style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                            ),
                          ));
                    }).toList(),
                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "What is your current level?",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                  ),
                SizedBox(height: 10),
                  MultiSelectContainer(
                    singleSelectedItem: true,
                    maxSelectableCount: 1,
                    onChange: (all, selectedItem) {
                      signup4Controller.levelselected(selectedItem!);
                    },
                    itemsDecoration: MultiSelectDecorations(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      selectedDecoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: const [Colors.purple, Colors.blue]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    itemsPadding: const EdgeInsets.all(8),
                    items: signup4Controller.level.map((level) {
                      return MultiSelectCard(
                          value: level["id"],
                          child: Flexible(
                            child: 
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  level["title"]!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  level["subtitle"]!,
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ));
                    }).toList(),
                ),
                ])
                )));
  }
}