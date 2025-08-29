import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:homeworkout_flutter/Controllers/signup_step1_controller.dart';
import 'package:homeworkout_flutter/Controllers/signup_step3_controller.dart';
class SignupStep3 extends StatelessWidget {
  final signup3Controller = Get.find<Signup3Controller>();
  final signupController = Get.find<SignupController>();
   SignupStep3({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
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
                SizedBox(height: 20),
                Text(
                  "My Profile",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                ),
                Text(
                  "Please provide the information below:",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                 Align(alignment: Alignment.centerLeft,child: 
                Text(
                  "Gender",
                  textAlign: TextAlign.start,
                   style: TextStyle(fontWeight: FontWeight.w400),
                ),),
                Padding(
                    padding: EdgeInsets.all(10),child: 
                  Obx(
          () =>  DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'Select Gender',
                  ),
                  items: signup3Controller.genderItems
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16),
                            ),
                          ))
                      .toList(),
                  value: signup3Controller.selectedGender.value.isEmpty
                      ? null
                      : signup3Controller.selectedGender.value,
                  onChanged: (value) {
                    if (value != null) {
                      signup3Controller.setGender(value);
                    }
                  },
                  buttonStyleData: ButtonStyleData(
                    height: 50,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.deepPurple.shade400,
                          width: 2,
                        ),
                      ),
                    ),
                    elevation: 0,
                  ),
                  iconStyleData: IconStyleData(
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    iconEnabledColor: Colors.deepPurple.shade400,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.deepPurple.shade400,
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),   Align(alignment: Alignment.centerLeft,child: 
 Text("Date of brith", style: TextStyle(fontWeight: FontWeight.w400),),),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Form(
                      child: Obx(()=> TextFormField(
                        keyboardType: TextInputType.none,
                        decoration: InputDecoration( enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400, width: 3),
    ),suffixIcon: Image.asset("assets/image/calendar.png",width: 40,height: 40,),
                           hintText:  signup3Controller.datesel.value != null
                      ? "${signup3Controller.datesel.value!.toLocal()}".split(' ')[0]
                      : "Select Date",),
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1950, 3, 5),
                              maxTime: DateTime(2025, 4, 29),
                              onChanged: (datesel) {
                            signup3Controller.date(datesel);
                          }, onConfirm: (date) {
                            signup3Controller.date(date);
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                      ),
                    )),), Align(alignment: Alignment.centerLeft,child: 
                Text(
                  "weight",
                  textAlign: TextAlign.left,
                   style: TextStyle(fontWeight: FontWeight.w400),
                ),),
               Padding(
                  padding: EdgeInsets.all(10),child:     TextFormField(
  keyboardType: TextInputType.number,
   onChanged: (val) => signup3Controller.weight.value = val,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  decoration: InputDecoration(
    hintText: "Enter weight",
    border: UnderlineInputBorder(),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400, width: 2),
    ),
    suffixIcon: Text(
      'kg',
      style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w600),
    ),
  ),),),
           Align(alignment: Alignment.centerLeft,child:     Text(
                  "Height", style: TextStyle(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),),
    Padding(
                  padding: EdgeInsets.all(10),child:    TextFormField(
  keyboardType: TextInputType.number,
   onChanged: (val) => signup3Controller.height.value = val,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  decoration: InputDecoration(
    hintText: "Enter Height",
    border: UnderlineInputBorder(),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400, width: 2),
    ),
    suffixIcon: Text(
      'cm',
      style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w600),
    ),
  ),)
),   Align(alignment: Alignment.centerLeft,child:  Text(
                  "What is your weight goal?", style: TextStyle(fontWeight: FontWeight.w400),
                  textAlign: TextAlign.left,
                ),),
             Padding(
                  padding: EdgeInsets.all(10), child:       TextFormField(
  keyboardType: TextInputType.number,
   onChanged: (val) => signup3Controller.weightgoal.value = val,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  decoration: InputDecoration(
    hintText: "Enter weight Kg",
    border: UnderlineInputBorder(),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple.shade400, width: 2),
    ),
    suffixIcon: Image.asset("assets/image/award.png",width: 40,height: 40,
  ),),),)

  ])));
  }
}
