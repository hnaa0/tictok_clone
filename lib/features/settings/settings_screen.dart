import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
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
