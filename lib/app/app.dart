import 'package:my_schedules/viewmodels/schedules_view_model.dart';
import 'package:my_schedules/views/home_view.dart';
import 'package:my_schedules/views/schedules_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../views/edit_schedule_view.dart';

//TextReverseView
@StackedApp(routes: [
  MaterialRoute(page: ScheduleView),
  MaterialRoute(page: HomeView, initial: true),
  MaterialRoute(page: EditNewScheduleForm),
], dependencies: [
  Singleton(classType: NavigationService),
  Singleton(classType: SnackbarService),
  Singleton(
    classType: ScheduleViewModel,
  ),
])
class App {}
