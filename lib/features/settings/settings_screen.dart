import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

// widgetRef: provide를 가져오거나 읽을 수 있는 레퍼런스
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).muted,
                  onChanged: (value) => {
                    ref.read(playbackConfigProvider.notifier).setMuted(value)
                  },
                  title: const Text("Muted Video"),
                  subtitle: const Text("Video will be muted by default."),
                ),
                SwitchListTile.adaptive(
                  value: ref.watch(playbackConfigProvider).autoplay,
                  onChanged: (value) => {
                    ref.read(playbackConfigProvider.notifier).setAutoplay(value)
                  },
                  title: const Text("Autoplay"),
                  subtitle:
                      const Text("Video will start playing automatically."),
                ),
                // ios = ios 스타일, android = android 스타일 보여줌
                SwitchListTile.adaptive(
                  activeColor: Colors.greenAccent,
                  value: false,
                  onChanged: (value) {},
                  title: const Text("Enable notifications"),
                  subtitle: const Text("blabla"),
                ),
                CheckboxListTile.adaptive(
                  activeColor: Theme.of(context).primaryColor,
                  value: false,
                  onChanged: (value) {},
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

                    if (kDebugMode) {
                      print(date);
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
                            onPressed: () {
                              ref.read(authRepo).signOut();
                              context.go("/");
                            },
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
        ));
  }
}
