import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_schedules/app/app.locator.dart';
import 'package:my_schedules/app/app.router.dart';

import 'package:my_schedules/services/schedule_api_servie.dart';
import 'package:my_schedules/viewmodels/schedules_view_model.dart';
import 'package:my_schedules/views/new_schedule.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationService = locator<NavigationService>();
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  navigationService.navigateToScheduleView();
                  // ScheduleApiService.createSchedul();

                  ;
                },
                child: const Text('View Schedules')),
          ],
        ),
      ),
    );
  }
}
