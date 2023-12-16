import 'package:flutter/material.dart';
import 'package:music_player/screens/drawer_screens/screen_about.dart';
import 'package:music_player/screens/drawer_screens/screen_pravicy.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';
import 'package:music_player/variables/varibles.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          color: color.impColor,
          child: Center(
            child: SizedBox(
              width: 200,
              child: Image.asset(
                'assets/musicflow-high-resolution-logo-transparent.png',
                color: color.backGroundColor,
              ),
            ),
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            ListTile(
              onTap: () async {
                final result = await TimePicker.show<DateTime?>(
                  context: context,
                  sheet: TimePickerSheet(
                    sheetCloseIconColor: color.impColor,
                    saveButtonColor: color.impColor,
                    sheetTitleStyle: TextStyle(color: color.textColor),
                    sheetTitle: 'Set meeting schedule',
                    hourTitle: 'Hour',
                    minuteTitle: 'Minute',
                    saveButtonText: 'Save',
                  ),
                );

                if (result != null) {
                  TimeOfDay selectedTime = TimeOfDay.fromDateTime(result);

                  // Convert selected time to duration
                  Duration selectedDuration = Duration(
                    hours: selectedTime.hour,
                    minutes: selectedTime.minute,
                  );

                  // ignore: avoid_print
                  print("Selected time: $selectedDuration");
                  Future.delayed(selectedDuration)
                      .then((value) => play.pause());
                  // play.pause();
                }

                // ignore: avoid_print
                print(result.toString());
              },
              iconColor: color.textColor,
              textColor: color.textColor,
              leading: Icon(
                Icons.timer,
                size: 30,
                color: color.textColor,
              ),
              title: const Text(
                'Sleep timer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ScreenPrivacyPolicy(),
              )),
              iconColor: color.textColor,
              textColor: color.textColor,
              leading: Icon(
                Icons.privacy_tip,
                size: 30,
                color: color.textColor,
              ),
              title: const Text(
                'privicy plicy',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AboutScreen();
                  },
                ));
              },
              iconColor: color.textColor,
              textColor: color.textColor,
              leading: Icon(
                Icons.info,
                size: 30,
                color: color.textColor,
              ),
              title: const Text(
                'about',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ListTile(
              iconColor: color.textColor,
              textColor: color.textColor,
              leading: Icon(
                Icons.conveyor_belt,
                size: 30,
                color: color.textColor,
              ),
              title: const Text(
                'Version',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle: const Text(
                '  0.01',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }
}
