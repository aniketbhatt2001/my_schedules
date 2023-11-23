// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import 'package:my_schedules/services/schedule_api_servie.dart';
import 'package:my_schedules/viewmodels/schedules_view_model.dart';
import 'package:my_schedules/widgets/loading_overlay.dart';

import '../configs/utitliteis.dart';

class EditNewScheduleForm extends StatefulWidget {
  final ScheduleViewModel scheduleViewModel;
  final String date;
  final String time;
  final String name;
  final String email;
  final bool online;
  final String id;
  const EditNewScheduleForm({
    Key? key,
    required this.scheduleViewModel,
    required this.date,
    required this.time,
    required this.name,
    required this.email,
    required this.online,
    required this.id,
  }) : super(key: key);

  @override
  State<EditNewScheduleForm> createState() => _EditNewScheduleFormState();
}

class _EditNewScheduleFormState extends State<EditNewScheduleForm> {
  DateTime? selectedDateTime;
  String? formattedDate, location, time, coWorker, hospital;
  bool isSwitched = false;
  final name = TextEditingController();
  final email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        formattedDate = widget.date;
        time = widget.time;
        isSwitched = widget.online;
        name.text = widget.name;
        email.text = widget.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Edit Schedule',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (picked != null && picked != selectedDateTime) {
                            setState(() {
                              selectedDateTime = picked;
                              formattedDate =
                                  DateFormat('dd MMM yyyy').format(picked);
                              print(formattedDate);
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black45),
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            // value: formattedDate,
                            underline: const SizedBox(),
                            hint: Container(
                              margin:
                                  const EdgeInsets.only(right: 25, left: 15),
                              child: Text(
                                formattedDate ?? 'Select a Date *',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                            items: [],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        margin: const EdgeInsets.all(8),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: DropdownButton(
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black),
                          isExpanded: true,
                          hint: const Text(
                            'Location/Station',
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          underline: const SizedBox(),
                          value: location,
                          items: const [
                            DropdownMenuItem(
                              child: Text('Borivali'),
                              value: 'Borivali',
                            ),
                            DropdownMenuItem(
                              child: Text('Andheri'),
                              value: 'Andheri',
                            ),
                            DropdownMenuItem(
                              child: Text('Bandra'),
                              value: 'Bandra',
                            ),
                            DropdownMenuItem(
                              child: Text('Vasai'),
                              value: 'Vasai',
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              location = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            setState(() {
                              time = timeOfDayToString(pickedTime);
                            });
                          }
                        },
                        child: Container(
                          //   width: MediaQuery.of(context).size.width / 2.5,
                          margin: const EdgeInsets.all(8),

                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.black45),
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            // value: formattedDate,
                            underline: const SizedBox(),
                            hint: Container(
                              margin:
                                  const EdgeInsets.only(right: 25, left: 15),
                              child: Text(
                                time ?? 'Select Time *',
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ),
                            items: [],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      height: 40,
                      child: TextField(
                        controller: name,
                        decoration: const InputDecoration(
                            hintText: 'Prospects *',
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45))),
                      ),
                    ))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                    const Text(
                      'Schedule Online Meeting',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      height: 40,
                      child: TextField(
                        controller: email,
                        decoration: const InputDecoration(
                            hintText: 'CC Email ID ',
                            hintStyle:
                                TextStyle(fontSize: 13, color: Colors.black),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45))),
                      ),
                    )),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue.shade900),
                            onPressed: () async {
                              // Parse the formatted date string
                              DateTime parsedDate = DateFormat('dd MMM yyyy')
                                  .parse(formattedDate!);

                              // Format the date in the desired format 'yyyy-MM-dd'
                              String convertedDateString =
                                  DateFormat('yyyy-MM-dd').format(parsedDate);
                              if (formattedDate != null &&
                                  time != null &&
                                  name.text.isNotEmpty) {
                                await widget.scheduleViewModel.editSchedule(
                                    context,
                                    formattedDate!,
                                    time!,
                                    name.text,
                                    isSwitched,
                                    email.text,
                                    widget.id);
                              } else {
                                widget.scheduleViewModel.sncakbarService
                                    .showSnackbar(
                                        message:
                                            'Please enter requied fields !',
                                        duration: Duration(seconds: 2));
                              }
                            },
                            child: const Text('Edit Schedule')))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
