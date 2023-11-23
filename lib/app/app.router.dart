// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i5;
import 'package:flutter/material.dart';
import 'package:my_schedules/viewmodels/schedules_view_model.dart' as _i6;
import 'package:my_schedules/views/edit_schedule_view.dart' as _i4;
import 'package:my_schedules/views/home_view.dart' as _i3;
import 'package:my_schedules/views/schedules_view.dart' as _i2;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i7;

class Routes {
  static const scheduleView = '/schedule-view';

  static const homeView = '/';

  static const editNewScheduleForm = '/edit-new-schedule-form';

  static const all = <String>{
    scheduleView,
    homeView,
    editNewScheduleForm,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.scheduleView,
      page: _i2.ScheduleView,
    ),
    _i1.RouteDef(
      Routes.homeView,
      page: _i3.HomeView,
    ),
    _i1.RouteDef(
      Routes.editNewScheduleForm,
      page: _i4.EditNewScheduleForm,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.ScheduleView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.ScheduleView(),
        settings: data,
      );
    },
    _i3.HomeView: (data) {
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.HomeView(),
        settings: data,
      );
    },
    _i4.EditNewScheduleForm: (data) {
      final args = data.getArgs<EditNewScheduleFormArguments>(nullOk: false);
      return _i5.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.EditNewScheduleForm(
            key: args.key,
            scheduleViewModel: args.scheduleViewModel,
            date: args.date,
            time: args.time,
            name: args.name,
            email: args.email,
            online: args.online,
            id: args.id),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class EditNewScheduleFormArguments {
  const EditNewScheduleFormArguments({
    this.key,
    required this.scheduleViewModel,
    required this.date,
    required this.time,
    required this.name,
    required this.email,
    required this.online,
    required this.id,
  });

  final _i5.Key? key;

  final _i6.ScheduleViewModel scheduleViewModel;

  final String date;

  final String time;

  final String name;

  final String email;

  final bool online;

  final String id;

  @override
  String toString() {
    return '{"key": "$key", "scheduleViewModel": "$scheduleViewModel", "date": "$date", "time": "$time", "name": "$name", "email": "$email", "online": "$online", "id": "$id"}';
  }

  @override
  bool operator ==(covariant EditNewScheduleFormArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.scheduleViewModel == scheduleViewModel &&
        other.date == date &&
        other.time == time &&
        other.name == name &&
        other.email == email &&
        other.online == online &&
        other.id == id;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        scheduleViewModel.hashCode ^
        date.hashCode ^
        time.hashCode ^
        name.hashCode ^
        email.hashCode ^
        online.hashCode ^
        id.hashCode;
  }
}

extension NavigatorStateExtension on _i7.NavigationService {
  Future<dynamic> navigateToScheduleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.scheduleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditNewScheduleForm({
    _i5.Key? key,
    required _i6.ScheduleViewModel scheduleViewModel,
    required String date,
    required String time,
    required String name,
    required String email,
    required bool online,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editNewScheduleForm,
        arguments: EditNewScheduleFormArguments(
            key: key,
            scheduleViewModel: scheduleViewModel,
            date: date,
            time: time,
            name: name,
            email: email,
            online: online,
            id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithScheduleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.scheduleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditNewScheduleForm({
    _i5.Key? key,
    required _i6.ScheduleViewModel scheduleViewModel,
    required String date,
    required String time,
    required String name,
    required String email,
    required bool online,
    required String id,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editNewScheduleForm,
        arguments: EditNewScheduleFormArguments(
            key: key,
            scheduleViewModel: scheduleViewModel,
            date: date,
            time: time,
            name: name,
            email: email,
            online: online,
            id: id),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
