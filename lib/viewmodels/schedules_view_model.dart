import 'package:flutter/material.dart';
import 'package:my_schedules/app/app.locator.dart';
import 'package:my_schedules/models/schedule.dart';
import 'package:my_schedules/services/schedule_api_servie.dart';
import 'package:my_schedules/views/schedules_view.dart';
import 'package:my_schedules/widgets/loading_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ScheduleViewModel extends FutureViewModel<List<ScheduleModel>?> {
  final sncakbarService = locator<SnackbarService>();

  Future<void> deleteSchedule(String id, context) async {
    LoadingOverlay.show(context);
    try {
      final _res = await ScheduleApiService.deleteSchedule(id);

      if (!disposed) {
        if (_res != null && _res['message'].isNotEmpty) {
          data = await futureToRun();
          rebuildUi();
          sncakbarService.showSnackbar(
              message: _res['message'], duration: const Duration(seconds: 2));
        }
      }
    } catch (e) {
      sncakbarService.showSnackbar(
          message: error.toString(), duration: const Duration(seconds: 2));
    }
    LoadingOverlay.hide();
  }

  Future<void> createNewSchedule(
    context,
    String formattedDate,
    String time,
    String name,
    bool isOnline,
    String email,
  ) async {
    LoadingOverlay.show(context);
    try {
      final _res = await ScheduleApiService.createSchedule(
          formattedDate, time, name, isOnline, email);
      final schedules = await futureToRun();
      if (!disposed) {
        if (_res != null && _res['message'].isNotEmpty) {
          data = await futureToRun();
          rebuildUi();
          sncakbarService.showSnackbar(
              message: _res['message'], duration: const Duration(seconds: 2));
        }
      }
    } catch (e) {
      onError(e);
    }
    LoadingOverlay.hide();
  }

  Future<void> editSchedule(
    context,
    String formattedDate,
    String time,
    String name,
    bool isOnline,
    String email,
    String id,
  ) async {
    LoadingOverlay.show(context);
    try {
      final _res = await ScheduleApiService.updateSchedule(
          formattedDate, time, name, isOnline, email, id);
      if (!disposed) {
        if (_res != null && _res['message'].isNotEmpty) {
          data = await futureToRun();

          rebuildUi();
          sncakbarService.showSnackbar(
              message: _res['message'], duration: const Duration(seconds: 2));
        }
      }
    } catch (e) {
      onError(e);
    }
    LoadingOverlay.hide();
  }

  @override
  void onData(data) {
    // TODO: implement onData
    super.onData(data);
  }

  @override
  void onError(error) {
    // TODO: implement onError
    super.onError(error);

    sncakbarService.showSnackbar(
        message: error.toString(), duration: const Duration(seconds: 2));
  }

  @override
  Future<List<ScheduleModel>?> futureToRun() async {
    // TODO: implement futureToRun
    try {
      final res = await ScheduleApiService.fetchSchedules();

      return res;
    } catch (e, st) {
      print(st);
      onError(e);
    }
  }

  @override
  void dispose() {
    // Dispose of the ScrollController

    super.dispose();
  }
}
