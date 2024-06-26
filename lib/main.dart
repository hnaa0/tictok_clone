import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/common/widgets/theme_configuration/theme_configuration.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import "package:flutter_localizations/flutter_localizations.dart";
import 'package:tiktok_clone/features/notifications/notifications_provider.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // bind, widget, engine 초기화-연결

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  // main 말고도 원하는 화면에서 사용 가능
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  final preferences = await SharedPreferences.getInstance();
  final repository = VideoPlaybackConfigRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        playbackConfigProvider.overrideWith(
          () => PlaybackConfigViewModel(repository),
        ),
      ],
      child: const TiktokApp(),
    ),
  );
}

class TiktokApp extends ConsumerWidget {
  const TiktokApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(notificationsProvider);
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'Tiktok Clone',
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
      ],
      themeMode: themeDarkmode.value ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade100,
        ),
        brightness: Brightness.light,
        textTheme: Typography.blackMountainView,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE9435A)),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        // splashColor, highlightColor: onTap시 효과 안보이게
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        // useMaterial3: true,
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
        ),
        tabBarTheme: TabBarTheme(
          unselectedLabelColor: Colors.grey.shade500,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        textTheme: Typography.whiteMountainView,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: const Color(0xFFE9435A),
        appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          surfaceTintColor: Colors.grey.shade900,
          backgroundColor: Colors.grey.shade900,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          padding: EdgeInsets.zero,
          color: Colors.grey.shade900,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
        ),
        iconTheme: IconThemeData(
          color: Colors.grey.shade100,
        ),
      ),
    );
  }
}
