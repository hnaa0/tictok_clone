import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_vm.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';
// import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends ConsumerWidget {
  static String routeURL = "/";
  static String routeName = "signUp";

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    // go()는 route stack에 관계없이 별도의 위치로 이동시킴.
    // 뒤로가기가 불가능해지기 때문에 기존의 stack에서 벗어나 새로운 시작 가능.
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UsernameScreen(),
        ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // if (orientation == Orientation.landscape) {
        //   return const Scaffold(
        //     body: Center(
        //       child: Text("Plz rotate your phone."),
        //     ),
        //   );
        // }
        return Scaffold(
          // safearea: 안에 있는 모든 위젯은 특정 공간에 있을 걸 보장
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUpTitle("Tiktok", DateTime.now()),
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  // 컬러 하드 코딩 수정 방법2.
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubTitle(0),
                      style: const TextStyle(
                        fontSize: Sizes.size16,
                        // 컬러 하드 코딩 수정 방법1.
                        // color: isDarkMode(context)
                        //     ? Colors.grey.shade300
                        //     : Colors.black45,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                        buttonFunc: _onEmailTap,
                        icon: const FaIcon(FontAwesomeIcons.solidUser),
                        text: S.of(context).emailPwButton),
                    Gaps.v16,
                    AuthButton(
                        buttonFunc: (p0) => ref
                            .read(socialAuthProvider.notifier)
                            .githubSignIn(context),
                        icon: const FaIcon(FontAwesomeIcons.github),
                        text: "Continue with Github"),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                              buttonFunc: _onEmailTap,
                              icon: const FaIcon(FontAwesomeIcons.solidUser),
                              text: S.of(context).emailPwButton),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                              buttonFunc: (p0) => ref
                                  .read(socialAuthProvider.notifier)
                                  .githubSignIn(context),
                              icon: const FaIcon(FontAwesomeIcons.github),
                              text: "Continue with Github"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context) ? null : Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).alreadyHaveAnAccount,
                    style: const TextStyle(fontSize: Sizes.size16),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).login("female"),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
