import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step5_controller.dart';

class SignupStep5 extends StatelessWidget {
  final signup5Controller = Get.find<Signup5Controller>();
  final signupController = Get.find<SignupController>();
  SignupStep5({super.key});
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
                child:ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbColor:WidgetStateProperty.all(Colors.deepPurple) ),
            child: SingleChildScrollView(child: 
                 Column(children: [
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
                  Text(
                    "My Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                  ),
                  SizedBox(height: 30,),
                Padding(padding:EdgeInsets.only(left: 10),
                    child: Text(
                      "Which days whould you like to workout?",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                  ),
                   SizedBox(height: 20),
                   MultiSelectContainer(
                      onChange: (all, selectedItem) {
    signup5Controller.daygroupsselected(all.cast<String>());
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
                    items: signup5Controller.daygroups.map((muscle) {
                      return MultiSelectCard(
                          value: muscle["name"],
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
                    }).toList(),),
                    SizedBox(height: 50,),
                    SizedBox(height: 10,),
                      Padding(padding: EdgeInsets.only(left: 10,),
                    child: Text(
                      "Set the right time for training!?",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                      textAlign: TextAlign.left,
                    ),
                  ),
                        SizedBox(height: 10),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      child: Obx(()=> TextFormField(
  keyboardType: TextInputType.none,
  decoration: InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400, width: 2),
    ),
    suffixIcon: Image.asset("assets/image/download2.png", width: 40, height: 40),
    hintText: signup5Controller.timesel.value != null
        ? TimeOfDay.fromDateTime(signup5Controller.timesel.value!)
            .format(context)
        : "Select Time",
  ),
  onTap: () {
    DatePicker.showTimePicker(context,
      showTitleActions: true,
      onChanged: (time) {
        signup5Controller.time(time);
      },
      onConfirm: (time) {
        signup5Controller.time(time);
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  },
                      ),
                    )),),
                ]))));
  }
}