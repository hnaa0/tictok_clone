import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            // ios = ios 스타일, android = android 스타일 보여줌
            Switch.adaptive(
              value: _notifications,
              onChanged: _onNotificationsChanged,
            ),
            CupertinoSwitch(
              value: _notifications,
              onChanged: _onNotificationsChanged,
            ),
            Switch(
              activeColor: Colors.pinkAccent,
              value: _notifications,
              onChanged: _onNotificationsChanged,
            ),
            SwitchListTile(
              activeColor: Colors.greenAccent,
              value: _notifications,
              onChanged: _onNotificationsChanged,
              title: const Text("Switch List Tile"),
            ),
            // ios = ios 스타일, android = android 스타일 보여줌
            SwitchListTile.adaptive(
              activeColor: Colors.greenAccent,
              value: _notifications,
              onChanged: _onNotificationsChanged,
              title: const Text("Switch List Tile"),
            ),
            Checkbox(
              value: _notifications,
              onChanged: _onNotificationsChanged,
            ),
            CheckboxListTile(
              activeColor: Theme.of(context).primaryColor,
              value: _notifications,
              onChanged: _onNotificationsChanged,
              title: const Text(
                "Enable notifications",
              ),
            ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Colors.greenAccent,
                          onPrimary: Colors.black,
                          onSurface: Colors.black,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1984),
                  lastDate: DateTime(2034),
                );
                print(date);

                if (context.mounted) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  print(time);
                }

                if (context.mounted) {
                  final booking = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(1984),
                    lastDate: DateTime(2034),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Colors.greenAccent,
                            onPrimary: Colors.black,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  print(booking);
                }
              },
              title: const Text("What is your birthday?"),
            ),
            const AboutListTile(),
          ],
        ));
  }
}
