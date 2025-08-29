import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' show DatePicker, LocaleType;
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/edit_profile_controller.dart';
import 'package:homeworkout_flutter/View/home.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final controller = Get.find<EditProfileController>();
  @override
  Widget build(BuildContext context) {
     final controller = Get.find<EditProfileController>();

  @override
  // ignore: unused_element
  void initState() {
    super.initState();
    controller.loadStoredData();
  }
    return Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: (){  Get.off(() => TrainingPage());}, icon:Icon(Icons.arrow_back) ,),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.isFormValid) controller.basicInfo();
                if (controller.isFormValid1) controller.moreDetails();
                if (controller.isFormValid2) controller.submitCompleteProfile();
                Get.off(() => TrainingPage());
              },
              child: const Icon(
                Icons.drive_file_rename_outline_rounded,
                color: Colors.purple,size: 20,
              ),
            )
          ],
          backgroundColor: Colors.white,
          title: const Text(
            "Edit your profile",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ListView(children: [
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child:
                Text("Gender", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(
              () => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Select Gender'),
                  items: controller.genderItems
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item,
                                style: const TextStyle(fontSize: 16)),
                          ))
                      .toList(),
                  value: controller.selectedGender.value.isEmpty
                      ? null
                      : controller.selectedGender.value,
                  onChanged: (value) {
                    if (value != null) controller.setGender(value);
                  },
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Date of birth",
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Obx(
              () => TextFormField(
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.deepPurple.shade400, width: 3),
                  ),
                  suffixIcon: Image.asset(
                    "assets/image/calendar.png",
                    width: 40,
                    height: 40,
                  ),
                  hintText: controller.datesel.value != null
                      ? "${controller.datesel.value!.toLocal()}".split(' ')[0]
                      : controller.datesel.value.toString(),
                ),
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1950, 3, 5),
                      maxTime: DateTime(2025, 4, 29), onChanged: (datesel) {
                    controller.date(datesel);
                  }, onConfirm: (date) {
                    controller.date(date);
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child:
                Text("Weight", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (val) => controller.weight.value = val,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "${controller.weight}",
                border: const UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurple.shade400, width: 3),
                ),
                suffixIcon: const Text(
                  'kg',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child:
                Text("Height", style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (val) => controller.height.value = val,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "${controller.height}",
                border: const UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurple.shade400, width: 3),
                ),
                suffixIcon: const Text(
                  'cm',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("your weight goal is",
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (val) => controller.weightgoal.value = val,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "${controller.weightgoal}",
                border: const UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurple.shade400, width: 2),
                ),
                suffixIcon: Image.asset(
                  "assets/image/award.png",
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [Text(
              "your goal is : ",
              style: TextStyle(fontWeight:FontWeight.w600,fontSize: 20),
              textAlign: TextAlign.left,
            ),Text(
              "${controller.selectedgoal}",
              style: TextStyle(fontWeight:FontWeight.w600,fontSize: 20,color: Colors.purple),
              textAlign: TextAlign.left,
            ),],) 
          ),
          SizedBox(
            height: 20,
          ),
          MultiSelectContainer(
            singleSelectedItem: true,
            maxSelectableCount: 1,
            onChange: (all, selectedItem) {
              controller.selectedgoal(selectedItem!);
            },
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              selectedDecoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: const [Colors.purple, Colors.blue]),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            itemsPadding: const EdgeInsets.all(8),
            items: controller.goal.map((goal) {
              return MultiSelectCard(
                  value: goal["id"],
                  child: Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          goal["title"]!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          goal["subtitle"]!,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ));
            }).toList(),
          ),
          SizedBox(
            height: 20,
          ),
         Align(
  alignment: Alignment.centerLeft,
  child: Row(children: [Text(
    "muscle group you focus on is :",
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    textAlign: TextAlign.left,
  ),Expanded(child:Text(
    controller.selectedmusclegroups.map((id) {
      final muscle = controller.musclegroups.firstWhere(
        (m) => m['id'] == id,
        orElse: () => {'name': 'Unknown'},
      );
      return muscle['name'];
    }).join(', '),
    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.purple),
    textAlign: TextAlign.left,
  ),)],) 
),
          SizedBox(
            height: 20,
          ),
          MultiSelectContainer(
            onChange: (all, selectedItem) {
              controller.musclegroupsselected(all.cast<String>());
            },
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              selectedDecoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: const [Colors.purple, Colors.blue]),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            wrapSettings: const WrapSettings(spacing: 10, runSpacing: 10),
            itemsPadding: const EdgeInsets.all(8),
            items: controller.musclegroups.map((muscle) {
              return MultiSelectCard(
                  value: muscle["id"],
                  child: SizedBox(
                    width: 100,
                    child: Center(
                      child: Text(
                        muscle["name"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ));
            }).toList(),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [ Text(
              "your current level is :",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              textAlign: TextAlign.left,
            ), Text(
              "${controller.selectedlevel}",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.purple),
              textAlign: TextAlign.left,
            ),],)
          ),
          SizedBox(height: 10),
          MultiSelectContainer(
            singleSelectedItem: true,
            maxSelectableCount: 1,
            onChange: (all, selectedItem) {
              controller.levelselected(selectedItem!);
            },
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              selectedDecoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: const [Colors.purple, Colors.blue]),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            itemsPadding: const EdgeInsets.all(8),
            items: controller.level.map((level) {
              return MultiSelectCard(
                  value: level["id"],
                  child: Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          level["title"]!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          level["subtitle"]!,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ));
            }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(children: [Text(
              "The days you workout is :  ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              textAlign: TextAlign.left,
            ),Expanded(child: Text(
              " ${controller.selecteddaysgroups} ",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15,color: Colors.purple),
              textAlign: TextAlign.left,
            ),)],)
          ),
          SizedBox(height: 20),
          MultiSelectContainer(
            onChange: (all, selectedItem) {
              controller.daygroupsselected(all.cast<String>());
            },
            itemsDecoration: MultiSelectDecorations(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              selectedDecoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: const [Colors.purple, Colors.blue]),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            wrapSettings: const WrapSettings(spacing: 10, runSpacing: 10),
            itemsPadding: const EdgeInsets.all(8),
            items: controller.daygroups.map((muscle) {
              return MultiSelectCard(
                  value: muscle["name"],
                  child: SizedBox(
                    width: 100,
                    child: Center(
                      child: Text(
                        muscle["name"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ));
            }).toList(),
          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                   "Your training time is ",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  textAlign: TextAlign.left,
                ),),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                child: Obx(
              () => TextFormField(
                keyboardType: TextInputType.none,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.deepPurple.shade400, width: 2),
                  ),
                  suffixIcon: Image.asset("assets/image/download2.png",
                      width: 40, height: 40),
                  hintText: controller.timesel.value != null
                      ? TimeOfDay.fromDateTime(controller.timesel.value!)
                          .format(context)
                      : "Select Time",
                ),
                onTap: () {
                  DatePicker.showTimePicker(
                    context,
                    showTitleActions: true,
                    onChanged: (time) {
                      controller.time(time);
                    },
                    onConfirm: (time) {
                      controller.time(time);
                    },
                    currentTime: controller.timesel.value ?? DateTime.now(),
                    locale: LocaleType.en,
                  );
                },
              ),
            )),
          ),
        ]));
  }
}