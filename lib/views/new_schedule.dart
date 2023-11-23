import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_schedules/services/schedule_api_servie.dart';
import 'package:my_schedules/viewmodels/schedules_view_model.dart';
import 'package:my_schedules/widgets/loading_overlay.dart';
import 'package:stacked/stacked.dart';

import '../configs/utitliteis.dart';

class NewScheduleForm extends StatefulWidget {
  final ScheduleViewModel scheduleViewModel;
  const NewScheduleForm({Key? key, required this.scheduleViewModel})
      : super(key: key);

  @override
  State<NewScheduleForm> createState() => _NewScheduleFormState();
}

class _NewScheduleFormState extends State<NewScheduleForm> {
  String? formattedDate, location, time, coWorker, hospital;
  bool isSwitched = false;
  final name = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Create  New Schedule',
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
                      print(picked);
                      if (picked != null) {
                        setState(() {
                          // selectedDateTime = picked;
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
                          margin: const EdgeInsets.only(right: 25, left: 15),
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
                      style: const TextStyle(fontSize: 13, color: Colors.black),
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
                          margin: const EdgeInsets.only(right: 25, left: 15),
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
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              children: [
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
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                      isExpanded: true,
                      hint: const Text(
                        'Hospiatl/Site Name',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      underline: const SizedBox(),
                      value: hospital,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Hospital 1'),
                          value: 'Hospital 1',
                        ),
                        DropdownMenuItem(
                          child: Text('Hospital 2'),
                          value: 'Hospital 2',
                        ),
                        DropdownMenuItem(
                          child: Text('Hospital 3'),
                          value: 'Hospital 3',
                        ),
                        DropdownMenuItem(
                          child: Text('Hospital 4'),
                          value: 'Hospital 4',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          hospital = value;
                        });
                      },
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
                      style: const TextStyle(fontSize: 13, color: Colors.black),
                      isExpanded: true,
                      hint: const Text(
                        'Co Worker',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      underline: const SizedBox(),
                      value: coWorker,
                      items: const [
                        DropdownMenuItem(
                          child: Text('Co Worker 1'),
                          value: 'Co Worker 1',
                        ),
                        DropdownMenuItem(
                          child: Text('Co Worker 2'),
                          value: 'Co Worker 2',
                        ),
                        DropdownMenuItem(
                          child: Text('Co Worker 3'),
                          value: 'Co Worker 3',
                        ),
                        DropdownMenuItem(
                          child: Text('Hospital 4'),
                          value: 'Co Worker 4',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          coWorker = value;
                        });
                      },
                    ),
                  ),
                ),
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
                        hintStyle: TextStyle(fontSize: 13, color: Colors.black),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                          FocusScope.of(context).unfocus();
                          // Parse the formatted date string
                          DateTime parsedDate =
                              DateFormat('dd MMM yyyy').parse(formattedDate!);

                          // Format the date in the desired format 'yyyy-MM-dd'
                          String convertedDateString =
                              DateFormat('yyyy-MM-dd').format(parsedDate);
                          if (formattedDate != null &&
                              time != null &&
                              name.text.isNotEmpty) {
                            await widget.scheduleViewModel.createNewSchedule(
                                context,
                                formattedDate!,
                                time!,
                                name.text,
                                isSwitched,
                                email.text);
                            name.clear();
                            email.clear();
                            formattedDate = null;
                            time = null;
                          } else {
                            widget.scheduleViewModel.sncakbarService
                                .showSnackbar(
                                    message: 'Please enter requied fields !',
                                    duration: Duration(seconds: 2));
                          }
                        },
                        child: const Text('Add Schedule')))
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
