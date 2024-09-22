// ignore_for_file: public_member_api_docs, sort_constructors_first
/// A DateTime picker to pick a single DateTime or a DateTime range.
///
/// Use [showOmniDateTimePicker] to pick a single DateTime.
///
/// Use [showOmniDateTimeRangePicker] to pick a DateTime range.
///
library omni_datetime_picker;

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:omni_datetime_picker/src/omni_datetime_picker.dart';
import 'package:omni_datetime_picker/src/omni_datetime_range_picker.dart';

/// Show dialog of the [OmniDateTimePicker]
///
/// Returns a DateTime
///
Future<DateTime?> showOmniDateTimePicker(
    {required BuildContext context,
    Widget? title,
    Widget? separator,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool? is24HourMode,
    bool? isShowSeconds,
    int? minutesInterval,
    int? secondsInterval,
    bool? isForce2Digits,
    BorderRadiusGeometry? borderRadius,
    BoxConstraints? constraints,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transitionBuilder,
    Duration? transitionDuration,
    bool? barrierDismissible,
    OmniDateTimePickerType type = OmniDateTimePickerType.dateAndTime,
    final bool Function(DateTime)? selectableDayPredicate,
    ThemeData? theme,
    CalendarConfig? calendarConfig,
    TimePickerSpinnerConfig? timePickerSpinnerConfig}) {
  return showGeneralDialog(
    context: context,
    transitionBuilder: transitionBuilder ??
        (context, anim1, anim2, child) {
          return FadeTransition(
            opacity: anim1.drive(
              Tween(
                begin: 0,
                end: 1,
              ),
            ),
            child: child,
          );
        },
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 200),
    barrierDismissible: barrierDismissible ?? true,
    barrierLabel: 'OmniDateTimePicker',
    pageBuilder: (BuildContext context, anim1, anim2) {
      return Theme(
        data: theme ?? Theme.of(context),
        child: OmniDateTimePicker(
          calendarConfig: calendarConfig,
          timePickerSpinnerConfig: timePickerSpinnerConfig,
          separator: separator,
          title: title,
          type: type,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          is24HourMode: is24HourMode,
          isShowSeconds: isShowSeconds,
          minutesInterval: minutesInterval,
          secondsInterval: secondsInterval,
          isForce2Digits: isForce2Digits,
          borderRadius: borderRadius,
          constraints: constraints,
          selectableDayPredicate: selectableDayPredicate,
        ),
      );
    },
  );
}

/// Show a dialog of the [OmniDateTimePicker]
///
/// Returns a List<DateTime>
/// with index 0 as startDateTime
/// and index 1 as endDateTime
///
Future<List<DateTime>?> showOmniDateTimeRangePicker({
  required BuildContext context,
  DateTime? startInitialDate,
  DateTime? startFirstDate,
  DateTime? startLastDate,
  DateTime? endInitialDate,
  DateTime? endFirstDate,
  DateTime? endLastDate,
  bool? is24HourMode,
  bool? isShowSeconds,
  int? minutesInterval,
  int? secondsInterval,
  bool? isForce2Digits,
  bool? isForceEndDateAfterStartDate,
  BorderRadiusGeometry? borderRadius,
  BoxConstraints? constraints,
  Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
      transitionBuilder,
  Duration? transitionDuration,
  bool? barrierDismissible,
  OmniDateTimePickerType type = OmniDateTimePickerType.dateAndTime,
  bool Function(DateTime)? selectableDayPredicate,
  ThemeData? theme,
  DefaultView defaultView = DefaultView.start,
  CalendarConfig? calendarConfig,
  TimePickerSpinnerConfig? timePickerSpinnerConfig,
}) {
  return showGeneralDialog(
    context: context,
    transitionBuilder: transitionBuilder ??
        (context, anim1, anim2, child) {
          return FadeTransition(
            opacity: anim1.drive(
              Tween(
                begin: 0,
                end: 1,
              ),
            ),
            child: child,
          );
        },
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 200),
    barrierDismissible: barrierDismissible ?? true,
    barrierLabel: 'OmniDateTimeRangePicker',
    pageBuilder: (BuildContext context, anim1, anim2) {
      return Theme(
        data: theme ?? Theme.of(context),
        child: OmniDateTimeRangePicker(
          type: type,
          startInitialDate: startInitialDate,
          startFirstDate: startFirstDate,
          startLastDate: startLastDate,
          endInitialDate: endInitialDate,
          endFirstDate: endFirstDate,
          endLastDate: endLastDate,
          is24HourMode: is24HourMode,
          isShowSeconds: isShowSeconds,
          minutesInterval: minutesInterval,
          secondsInterval: secondsInterval,
          isForce2Digits: isForce2Digits,
          isForceEndDateAfterStartDate: isForceEndDateAfterStartDate,
          borderRadius: borderRadius,
          constraints: constraints,
          selectableDayPredicate: selectableDayPredicate,
          defaultView: defaultView,
          calendarConfig: calendarConfig,
          timePickerSpinnerConfig: timePickerSpinnerConfig,
        ),
      );
    },
  );
}

/// Type of the [OmniDateTimePicker]
/// default to dateAndTime if not selected
enum OmniDateTimePickerType {
  date,
  dateAndTime,
}

/// Decides which tab open by default
enum DefaultView { start, end }

class TimePickerSpinnerConfig {
  final double? itemHeight;
  final double? itemWidth;
  final double? spacing;
  late int itemCount;

  final BoxDecoration? Function({required bool isSelected})? spinnerBoxDeco;
  late Container selectedVerticalContainer;
  final TextStyle? Function({required bool isSelected})? textStyle;
  final bool unselectedHasRotation;
  late int getMedian;
  late int lengthToMedian;

  TimePickerSpinnerConfig(
      {this.itemHeight,
      this.itemWidth,
      this.spacing,
      this.spinnerBoxDeco,
      Container? selectedVerticalContainer,
      this.textStyle,
      this.unselectedHasRotation = false,
      int? itemCount}) {
    this.selectedVerticalContainer =
        selectedVerticalContainer ?? defaultSelectedVerticalContainer();
    this.itemCount = itemCount ?? defaultItemCount;
    if (this.itemCount < defaultItemCount) {
      throw Exception(
          'itemCount cannot less than ${defaultItemCount.toString()}.');
    }
    if (this.itemCount % 2 == 0) {
      throw Exception('itemCount must be an odd number.');
    }
    getMedian = (this.itemCount + 1) ~/ 2;
    lengthToMedian = getMedian - 1;
  }

  static BoxDecoration defaultSpinnerBoxDeco({required bool isSelected}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: isSelected ? Colors.grey.withOpacity(0.3) : null,
    );
  }

  static TextStyle defaultTextStyle(
      {required BuildContext context, required bool isSelected}) {
    TextStyle style = (isSelected
            ? Theme.of(context).textTheme.headlineSmall
            : Theme.of(context).textTheme.bodyLarge) ??
        const TextStyle();
    return style;
  }

  static double getRotationAngle(int index, int selectedIndex, int total) {
    if (index == 0) return 0;
    double maxRotation = pi / 3;

    int distance = (index - selectedIndex + total) % total;
    if (distance > total / 2) {
      distance = total - distance;
    }
    double normalizedDistance = distance / (total / 2.0);
    double rotation = maxRotation * normalizedDistance;

    return rotation;
  }

  static Matrix4 getRotationX(
      {required int selectedIndex,
      required int currentIndex,
      required bool? unselectedHasRotation,
      required bool isSelected,
      required int total,
      required int lengthToMedian}) {
    List<int> indexAround = [];
    List<double> rotations = [];

    for (int i = lengthToMedian * -1; i <= lengthToMedian; i++) {
      int timeIndex = selectedIndex - i;
      indexAround.add(timeIndex);
      rotations.add(getRotationAngle(i, 0, (lengthToMedian * 2) + 1));
    }
    // if (selectedIndex == currentIndex) {
    //   debugPrint("rotation $rotations");
    // }

    double rotation = indexAround.contains(currentIndex)
        ? rotations[indexAround.indexOf(currentIndex)]
        : 0;

    return unselectedHasRotation != null && unselectedHasRotation
        ? (isSelected ? Matrix4.rotationX(0) : Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(rotation))
        : Matrix4.rotationX(0);
  }

  static int defaultItemCount = 3;
  static int defaultMedian = (defaultItemCount + 1) ~/ 2;
  static int defaultLengthToMedian = defaultMedian - 1;

  static defaultSelectedVerticalContainer() {
    return Container(
      color: Colors.black.withOpacity(0),
    );
  }
}

class CalendarConfig {
  final double? tabBarHeight;
  final double? subHeaderHeight;
  final Size? yearItemSize;
  final double? yearItemBorderRadius;

  final int? yearPickerColumnCount;
  final double? yearPickerPadding;
  final double? yearPickerRowHeight;
  final double? yearPickerRowSpacing;
  CalendarConfig({
    this.tabBarHeight,
    this.subHeaderHeight,
    this.yearItemSize,
    this.yearItemBorderRadius,
    this.yearPickerColumnCount,
    this.yearPickerPadding,
    this.yearPickerRowHeight,
    this.yearPickerRowSpacing,
  });
}
