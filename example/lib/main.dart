import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omni DateTime Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: getDeepPrimaryColor,
            surfaceVariant: surfaceVariant,
          ),
          //ColorScheme.fromSeed(seedColor: Colors.dColor.fromARGB(255, 7, 5, 9)
          useMaterial3: true,
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(getDeepPrimaryColor),
            radius: const Radius.circular(5),
          ),
          textTheme: TextTheme(
            bodySmall: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
            bodyLarge: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
            bodyMedium:
                TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
          ),
          dialogBackgroundColor: Colors.white,
          iconTheme: IconThemeData(size: 16),
          appBarTheme: AppBarTheme(
            color: getDeepPrimaryColor,
            iconTheme: IconThemeData(color: Colors.white, size: 16),
            titleSpacing: 10,
            titleTextStyle: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            toolbarHeight: getDefaultAppbarHeight,
          ),
          timePickerTheme: TimePickerThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Less rounded corners
              ),
              backgroundColor: Colors.white,
              helpTextStyle:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          datePickerTheme: DatePickerThemeData(
              headerHeadlineStyle:
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              inputDecorationTheme: InputDecorationTheme(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  isDense: true,
                  labelStyle: TextStyle(fontSize: 12)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Less rounded corners
              ),
              rangePickerHeaderHeadlineStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              rangePickerHeaderHelpStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              rangePickerHeaderForegroundColor: getDeepPrimaryColor),
          filledButtonTheme: FilledButtonThemeData(
              style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    5.0), // adjust the radius as per your requirement
              ),
            ),
          )),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 12))))),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  context: context,
                  // 其余参数和之前一样
                );

                print("dateTime: $dateTime");
              },
              child: const Text("Show DateTime Picker"),
            ),
            ElevatedButton(
              onPressed: () async {
                //TODO for layout testing
                List<DateTime>? dateTimeList =
                    await showOmniDateTimeRangePicker(
                  calendarConfig: CalendarConfig(
                      // buildNavigationButton: ({required onPressed}) {
                      //   return TextButton(
                      //       onPressed: onPressed, child: Text("Next"));
                      // },
                      dayPickerFlexHeight: true,
                      dayPickerRowHeight: 40,
                      calendarDayPickerColor: Colors.white.withOpacity(0.1),
                      yearPickerRowHeight: 30,
                      yearPickerPadding: 5,
                      yearPickerColumnCount: 3,
                      tabBarHeight: 30,
                      subHeaderHeight: 40,
                      yearItemBorderRadius: 8,
                      yearItemSize: Size(50, 40)),
                  constraints: BoxConstraints(maxHeight: 500),
                  timePickerSpinnerConfig: TimePickerSpinnerConfig(
                    spinnerColor: Colors.greenAccent.withOpacity(0.05),
                    spinnerPadding: EdgeInsets.symmetric(vertical: 8),
                    itemHeight: 20,
                    spacing: 20,
                    itemCount: 3,
                    selectedVerticalContainer: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    unselectedHasRotation: true,
                    textStyle: ({required isSelected}) {
                      TextStyle style = ((isSelected
                                  ? Theme.of(context).textTheme.headlineSmall
                                  : Theme.of(context).textTheme.bodyLarge) ??
                              const TextStyle())
                          .copyWith(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.grey.withOpacity(0.8),
                              fontSize: isSelected ? 12 : 12);
                      return style;
                    },
                    spinnerBoxDeco: ({required isSelected}) {
                      return BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:
                              isSelected ? Colors.grey.withOpacity(0.3) : null);
                    },
                  ),
                  context: context,
                  theme: Theme.of(context).copyWith(
                      tabBarTheme: TabBarTheme(
                        indicatorSize: TabBarIndicatorSize.label,
                      ),
                      dialogBackgroundColor: Colors.white,
                      textTheme: Theme.of(context).textTheme.copyWith(
                          bodyLarge:
                              TextStyle(fontSize: 10, color: Colors.black),
                          //* day picker text style
                          bodySmall:
                              TextStyle(fontSize: 14, color: Colors.black),
                          //* subheader text style
                          titleSmall:
                              TextStyle(fontSize: 14, color: Colors.black),
                          headlineSmall: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      disabledColor: Colors.red,
                      dialogTheme: DialogTheme(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Less rounded corners
                        ),
                      ),
                      textButtonTheme: TextButtonThemeData(
                          style: ButtonStyle(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                      ))),
                );

                print("Start dateTime: ${dateTimeList?[0]}");
                print("End dateTime: ${dateTimeList?[1]}");
              },
              child: const Text("Show DateTime Range Picker"),
            ),
          ],
        ),
      ),
    );
  }
}

double get getDefaultAppbarHeight => 36;

double get getDefaultBottomNavBarHeight => 60;

const Color getPrimaryColor = Color(0xff7E57C2);

const Color surfaceVariant = Color.fromARGB(255, 237, 235, 235);

const Color getPrimaryBGColor = Colors.white;

const Color getSecondaryBGColor = Color(0xffcccccc);

Color get getLightPrimaryColor => const Color(0xff7E57C2).withOpacity(0.1);

const Color getDeepPrimaryColor = Color(0xff55437a);

Color get getSecondaryDeepPrimaryColor =>
    const Color.fromARGB(255, 110, 81, 166);

Color get getDisableColor => Colors.grey.withOpacity(0.25);
Color get getSecondaryDisableColor => Colors.grey.shade400.withOpacity(0.7);

double getScreenHeightRatio(BuildContext context) {
  var screenHeight = MediaQuery.of(context).size.height /
      (MediaQuery.of(context).devicePixelRatio / 160);
  var designHeight = 640.0;
  return screenHeight / designHeight;
}

double get getDefaultDialogTitleFontSize => 16;

double get getDefaultDialogButtonFontSize => 12;

Size get getDefaultDialogButtonSize => Size(110, 35);

Size get getDefaultStandardButtonSize => Size(110, 35);

double get getDefaultDataGridColumnHeight => 40;

double get getDefaultDataGridRowHeight => 40;

double get getDefaultPadding => 8;

double get getDefaultColumnValueSize => 14;

double get getDefaultRowValueSize => 12;

const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);
Color get getShimmerBaseColor => const Color.fromARGB(255, 228, 228, 237);
Color get getShimmerDeepBaseColor =>
    const Color.fromARGB(255, 212, 212, 233).withOpacity(0.5);
Color getShimmerHighlightColor = Colors.white;

Color get getFavoriteItemColor => Colors.yellow;

Color get getNonFavoriteItemColor => const Color.fromARGB(255, 199, 254, 2);

IconData get getFavoriteItemIcon => Icons.star;

IconData get getNonFavoriteItemIcon => Icons.star_border;

Color get getTopSnackbarBarColor => const Color.fromARGB(255, 40, 3, 61);

Color get getHoveringTopSnackbarBarColor =>
    const Color.fromARGB(255, 35, 1, 54);

Color adjustBrightness(Color color, double brightness) {
  var hsv = HSVColor.fromColor(color);
  var newHsv = hsv.withValue((hsv.value * brightness).clamp(0.0, 1.0));
  return newHsv.toColor();
}

Color get getTetiaryColor =>
    const Color.fromARGB(255, 141, 144, 228).withOpacity(0.2);

Color get getRowColorPrimary => Colors.white;

Color get getRowColorSecondary =>
    const Color.fromARGB(206, 252, 244, 255).withOpacity(0.4);
