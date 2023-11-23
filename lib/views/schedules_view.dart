import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_schedules/app/app.router.dart';
import 'package:my_schedules/models/schedule.dart';
import 'package:my_schedules/viewmodels/schedules_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import '../widgets/loading_overlay.dart';
import 'new_schedule.dart';

class ScheduleView extends StackedView<ScheduleViewModel> {
  ScheduleView({super.key});
  final scrolClr = ScrollController();
  double currentPos = 0.0;

  @override
  void onViewModelReady(ScheduleViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
    print('listner registered');
    scrolClr.addListener(() {
      currentPos = scrolClr.offset;
    });
  }

  @override
  bool get createNewViewModelOnInsert => false;

  @override
  void onDispose(ScheduleViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
    scrolClr.dispose();
  }

  @override
  Widget builder(
      BuildContext context, ScheduleViewModel viewModel, Widget? child) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (scrolClr.hasClients) {
    //     Future.delayed(Duration.zero)
    //         .then((value) => scrolClr.jumpTo(currentPos));
    //   }
    // });

    return Scaffold(
        backgroundColor: Colors.blue.shade50,
        body: SafeArea(
          child: Center(
              child: !viewModel.dataReady
                  ? const Center(
                      child: RefreshProgressIndicator(),
                    )
                  : Builder(builder: (context) {
                      if (viewModel.data != null &&
                          viewModel.data!.isNotEmpty) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              NewScheduleForm(scheduleViewModel: viewModel),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, top: 10),
                                    decoration: const BoxDecoration(
                                        color: Colors.white),
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Upcoming Schedules',
                                      style: TextStyle(
                                        color: Colors.blue.shade900,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                                color: Colors.blue.shade900,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height /
                                    2.5, // Set a fixed height or use some constraints based on your requirement
                                child: ListView(
                                  controller: scrolClr,
                                  scrollDirection: Axis.horizontal,
                                  children: _buildDateColumns(
                                      viewModel.data, context, viewModel),
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      scrolClr.animateTo(
                                        currentPos - 100,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.decelerate,
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      scrolClr.animateTo(
                                        currentPos + 100,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.decelerate,
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NewScheduleForm(
                            scheduleViewModel: viewModel,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 2,
                            color: Colors.blue.shade900,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No Schedules Availabe !',
                              style: TextStyle(
                                  //   color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      );
                    })),
        ));
    ;
  }

  @override
  ScheduleViewModel viewModelBuilder(BuildContext context) {
    return ScheduleViewModel();
  }

  List<Widget> _buildDateColumns(List<ScheduleModel>? schedules, context,
      ScheduleViewModel scheduleViewModel) {
    // Sort schedules by date
    schedules?.sort((a, b) => a.date!.compareTo(b.date!));

    // Create a map to group schedules by date
    Map<String, List<ScheduleModel>> groupedSchedules = {};

    // Group schedules by date
    schedules?.forEach((schedule) {
      if (groupedSchedules.containsKey(schedule.date)) {
        groupedSchedules[schedule.date]!.add(schedule);
      } else {
        groupedSchedules[schedule.date!] = [schedule];
      }
    });

    // Build a column for each date
    return groupedSchedules.entries.map((entry) {
      String date = entry.key;
      List<ScheduleModel> dateSchedules = entry.value;

      // Build the column for the current date
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(builder: (ctx) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 1.5,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.1))
                    ]),
                    child: Text(
                      date,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Build a row for each schedule in the current date
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: dateSchedules.map((schedule) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              schedule.time!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                schedule.docName!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                                // maxLines: null,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final navigationService =
                                        locator<NavigationService>();
                                    navigationService
                                        .navigateToEditNewScheduleForm(
                                            id: schedule.id!,
                                            scheduleViewModel:
                                                scheduleViewModel,
                                            date: schedule.date!,
                                            time: schedule.time!,
                                            name: schedule.docName!,
                                            email: schedule.emailCc!,
                                            online:
                                                schedule.onlineMeeting == '1'
                                                    ? true
                                                    : false);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await scheduleViewModel.deleteSchedule(
                                        schedule.id!, context);
                                  },
                                  child: const Icon(
                                    Icons.delete_outline,
                                    size: 22,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          );
        }),
      );
    }).toList();
  }
}
