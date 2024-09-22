import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key, required this.tabController, required this.calendarConfig});

  final TabController tabController;
  final CalendarConfig? calendarConfig;

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);

    return TabBar(
      controller: tabController,
      indicatorSize: Theme.of(context).tabBarTheme.indicatorSize ??
          TabBarIndicatorSize.tab,
      onTap: (index) {
        tabController.animateTo(index);
      },
      labelColor: Theme.of(context).useMaterial3
          ? null
          : Theme.of(context).colorScheme.onSurface,
      indicatorColor: Theme.of(context).useMaterial3
          ? null
          : Theme.of(context).colorScheme.primary,
      tabs: [
        Tab(
          height: calendarConfig?.tabBarHeight,
          child: Text(localizations.dateRangeStartLabel,
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        Tab(
          height: calendarConfig?.tabBarHeight,
          child: Text(localizations.dateRangeEndLabel,
              style: Theme.of(context).textTheme.headlineSmall),
        ),
      ],
    );
  }
}
