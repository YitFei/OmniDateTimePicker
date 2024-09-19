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
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
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
                List<DateTime>? dateTimeList =
                    await showOmniDateTimeRangePicker(
                  context: context,
                  // 其余参数和之前一样
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
