import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';

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
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            centerTitle: true,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.sm,
              ),
              child: ListView(
                children: [
                  // ios = ios 스타일, android = android 스타일 보여줌
                  SwitchListTile.adaptive(
                    activeColor: Colors.greenAccent,
                    value: _notifications,
                    onChanged: _onNotificationsChanged,
                    title: const Text("Enable notifications"),
                    subtitle: const Text("blabla"),
                  ),
                  CheckboxListTile.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: _notifications,
                    onChanged: _onNotificationsChanged,
                    title: const Text(
                      "Enable notifications",
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      if (context.mounted) {
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

                        if (kDebugMode) {
                          print(date);
                        }
                      }

                      if (context.mounted) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (kDebugMode) {
                          print(time);
                        }
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
                        if (kDebugMode) {
                          print(booking);
                        }
                      }
                    },
                    title: const Text("What is your birthday?"),
                  ),
                  ListTile(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          title: const Text("Are you sure?"),
                          message: const Text("plz dont gooooooooooo"),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Not log out"),
                            ),
                            CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    },
                    title: const Text(
                      "Log out(IOS / bottom)",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text("Are you sure?"),
                          content: const Text("Please don't go T.T"),
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("No"),
                            ),
                            CupertinoDialogAction(
                              onPressed: () => Navigator.of(context).pop(),
                              isDestructiveAction: true,
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    },
                    title: const Text(
                      "Log out(IOS)",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Are you sure?"),
                          content: const Text("Please don't go T.T"),
                          actions: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const FaIcon(FontAwesomeIcons.x),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Yes"),
                            ),
                          ],
                        ),
                      );
                    },
                    title: const Text(
                      "Log out(Adroid)",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  const AboutListTile(),
                ],
              ),
            ),
          )),
    );
  }
}
