import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:omni_datetime_picker/src/components/button_row.dart';
import 'package:omni_datetime_picker/src/components/calendar.dart';
import 'package:omni_datetime_picker/src/components/custom_tab_bar.dart';
import 'package:omni_datetime_picker/src/components/time_picker_spinner.dart';

class OmniDtpRange extends StatefulWidget {
  const OmniDtpRange({
    super.key,
    this.startInitialDate,
    this.startFirstDate,
    this.startLastDate,
    this.endInitialDate,
    this.endFirstDate,
    this.endLastDate,
    this.isShowSeconds,
    this.is24HourMode,
    this.minutesInterval,
    this.secondsInterval,
    this.isForce2Digits,
    bool? isForceEndDateAfterStartDate,
    this.constraints,
    this.type,
    this.selectableDayPredicate,
    this.defaultView = DefaultView.start,
    required this.calendarConfig,
    //* Time Spinner
    required this.timePickerSpinnerConfig,
  }) : isForceEndDateAfterStartDate = isForceEndDateAfterStartDate ?? false;

  final DateTime? startInitialDate;
  final DateTime? startFirstDate;
  final DateTime? startLastDate;

  final DateTime? endInitialDate;
  final DateTime? endFirstDate;
  final DateTime? endLastDate;

  final bool? isShowSeconds;
  final bool? is24HourMode;
  final int? minutesInterval;
  final int? secondsInterval;
  final bool? isForce2Digits;
  final bool isForceEndDateAfterStartDate;
  final BoxConstraints? constraints;
  final OmniDateTimePickerType? type;
  final bool Function(DateTime)? selectableDayPredicate;
  final DefaultView defaultView;

  final CalendarConfig? calendarConfig;

  //* Time Spinner
  final TimePickerSpinnerConfig? timePickerSpinnerConfig;

  @override
  State<OmniDtpRange> createState() => _OmniDtpRangeState();
}

class _OmniDtpRangeState extends State<OmniDtpRange>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final ValueNotifier<DateTime> _selectedStartDateTime =
      ValueNotifier(widget.startInitialDate ?? DateTime.now());
  late final ValueNotifier<DateTime> _selectedEndDateTime =
      ValueNotifier(widget.endInitialDate ?? DateTime.now());

  final ValueNotifier<bool> showButtonRow = ValueNotifier(false);

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = widget.defaultView.index;

    assert(
      !(widget.isForceEndDateAfterStartDate &&
          (widget.startLastDate == null && widget.endLastDate != null)),
      'endLastDate cannot be set when startLastDate is null and forceEndDateAfterStartDate is true',
    );
    assert(
      !(widget.isForceEndDateAfterStartDate &&
          (widget.startLastDate != null &&
              widget.endLastDate != null &&
              (widget.startLastDate!.isAfter(widget.endLastDate!) ||
                  widget.startLastDate!
                      .isAtSameMomentAs(widget.endLastDate!)))),
      'endLastDate cannot less than startLastDate when forceEndDateAfterStartDate is true',
    );
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    showButtonRow.value = _tabController.index == 1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _selectedStartDateTime.dispose();
    _selectedEndDateTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasNextButton = widget.calendarConfig?.buildNavigationButton != null;
    return ConstrainedBox(
      constraints: widget.constraints ??
          const BoxConstraints(
            maxWidth: 350,
            maxHeight: 650,
          ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CustomTabBar(
            tabController: _tabController,
            calendarConfig: widget.calendarConfig),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              PickerView(
                calendarConfig: widget.calendarConfig,
                type: widget.type,
                initialDate: widget.startInitialDate,
                firstDate: widget.startFirstDate,
                lastDate: widget.startLastDate,
                isShowSeconds: widget.isShowSeconds,
                is24HourMode: widget.is24HourMode ?? false,
                minutesInterval: widget.minutesInterval,
                secondsInterval: widget.secondsInterval,
                isForce2Digits: widget.isForce2Digits ?? false,
                onDateChange: (value) {
                  DateTime tempDateTime = DateTime(
                    value.year,
                    value.month,
                    value.day,
                    _selectedStartDateTime.value.hour,
                    _selectedStartDateTime.value.minute,
                    widget.isShowSeconds ?? false
                        ? _selectedStartDateTime.value.second
                        : 0,
                  );

                  _selectedStartDateTime.value = tempDateTime;
                },
                onTimeChange: (value) {
                  DateTime tempDateTime = DateTime(
                    _selectedStartDateTime.value.year,
                    _selectedStartDateTime.value.month,
                    _selectedStartDateTime.value.day,
                    value.hour,
                    value.minute,
                    widget.isShowSeconds ?? false ? value.second : 0,
                  );

                  _selectedStartDateTime.value = tempDateTime;
                },
                selectableDayPredicate: widget.selectableDayPredicate,
                timePickerSpinnerConfig: widget.timePickerSpinnerConfig,
              ),
              PickerView(
                calendarConfig: widget.calendarConfig,
                type: widget.type,
                selectedStartDate: widget.isForceEndDateAfterStartDate
                    ? _selectedStartDateTime
                    : null,
                selectedEndDate: widget.isForceEndDateAfterStartDate
                    ? _selectedEndDateTime
                    : null,
                initialDate: widget.endInitialDate,
                firstDate: widget.endFirstDate,
                lastDate: widget.endLastDate,
                isShowSeconds: widget.isShowSeconds,
                is24HourMode: widget.is24HourMode ?? false,
                minutesInterval: widget.minutesInterval,
                secondsInterval: widget.secondsInterval,
                isForce2Digits: widget.isForce2Digits ?? false,
                onDateChange: (value) {
                  DateTime tempDateTime = DateTime(
                    value.year,
                    value.month,
                    value.day,
                    _selectedEndDateTime.value.hour,
                    _selectedEndDateTime.value.minute,
                    widget.isShowSeconds ?? false
                        ? _selectedEndDateTime.value.second
                        : 0,
                  );

                  _selectedEndDateTime.value = tempDateTime;
                },
                onTimeChange: (value) {
                  DateTime tempDateTime = DateTime(
                    _selectedEndDateTime.value.year,
                    _selectedEndDateTime.value.month,
                    _selectedEndDateTime.value.day,
                    value.hour,
                    value.minute,
                    widget.isShowSeconds ?? false ? value.second : 0,
                  );

                  _selectedEndDateTime.value = tempDateTime;
                },
                selectableDayPredicate: widget.selectableDayPredicate,
                timePickerSpinnerConfig: widget.timePickerSpinnerConfig,
              ),
            ],
          ),
        ),
        if (hasNextButton)
          ValueListenableBuilder(
              valueListenable: showButtonRow,
              builder: ((context, showButtonRow, child) {
                return showButtonRow
                    ? buildRowButton()
                    : (widget.calendarConfig?.buildNavigationButton?.call(
                          onPressed: () {
                            _tabController.index = 1;
                          },
                        ) ??
                        Container());
              })),
        if (hasNextButton == false) buildRowButton()
      ]),
    );
  }

  Widget buildRowButton() {
    return ButtonRow(onSavePressed: () {
      Navigator.pop<List<DateTime>>(context, [
        _selectedStartDateTime.value,
        _selectedEndDateTime.value.isBefore(_selectedStartDateTime.value) &&
                widget.isForceEndDateAfterStartDate
            ? _selectedStartDateTime.value.copyWith()
            : _selectedEndDateTime.value
      ]);
    });
  }
}

class PickerView extends StatefulWidget {
  const PickerView(
      {super.key,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.selectedStartDate,
      this.selectedEndDate,
      this.isShowSeconds,
      required this.onTimeChange,
      required this.onDateChange,
      this.is24HourMode,
      this.minutesInterval,
      this.secondsInterval,
      this.isForce2Digits,
      this.type,
      this.selectableDayPredicate,
      required this.calendarConfig,
      required this.timePickerSpinnerConfig});

  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueNotifier<DateTime>? selectedStartDate;
  final ValueNotifier<DateTime>? selectedEndDate;

  final bool? isShowSeconds;
  final bool? is24HourMode;
  final int? minutesInterval;
  final int? secondsInterval;
  final bool? isForce2Digits;

  final void Function(DateTime) onDateChange;
  final void Function(DateTime) onTimeChange;

  final bool Function(DateTime)? selectableDayPredicate;

  final OmniDateTimePickerType? type;

  final TimePickerSpinnerConfig? timePickerSpinnerConfig;
  final CalendarConfig? calendarConfig;

  @override
  State<PickerView> createState() => _PickerViewState();
}

class _PickerViewState extends State<PickerView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final localizations = MaterialLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Calendar(
            calendarConfig: widget.calendarConfig,
            initialDate: widget.initialDate,
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            onDateChanged: widget.onDateChange,
            dynamicFirstDate: widget.selectedStartDate,
            selectableDayPredicate: widget.selectableDayPredicate,
          ),
        ),
        if (widget.type == OmniDateTimePickerType.dateAndTime)
          Padding(
            padding: widget.timePickerSpinnerConfig?.spinnerPadding ??
                EdgeInsets.zero,
            child: TimePickerSpinner(
                time: widget.initialDate,
                amText: localizations.anteMeridiemAbbreviation,
                pmText: localizations.postMeridiemAbbreviation,
                isShowSeconds: widget.isShowSeconds ?? false,
                is24HourMode: widget.is24HourMode ?? false,
                minutesInterval: widget.minutesInterval ?? 1,
                secondsInterval: widget.secondsInterval ?? 1,
                isForce2Digits: widget.isForce2Digits ?? false,
                onTimeChange: widget.onTimeChange,
                dynamicSelectedStartDate: widget.selectedStartDate,
                dynamicSelectedEndDate: widget.selectedEndDate,
                timePickerSpinnerConfig: widget.timePickerSpinnerConfig),
          ),
      ],
    );
  }
}
