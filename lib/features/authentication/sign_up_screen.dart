import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';
// import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/";
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(LoginScreen.routeName);
    print(result);
  }

  void _onEmailTap(BuildContext context) {
    // Navigator.of(context).push(
    //   // PageRouteBuilder: page route에 animation, duration 등을 넣을 수 있게 해주는 위젯
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(milliseconds: 500),
    //     reverseTransitionDuration: const Duration(milliseconds: 500),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final offsetAnimation =
    //           Tween(begin: const Offset(0, 1), end: Offset.zero)
    //               .animate(animation);
    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         ),
    //       );
    //     },
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //   ),
    // );
    Navigator.of(context).pushNamed(UsernameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
                        buttonFunc: _onEmailTap,
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        text: S.of(context).appleButton),
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
                              buttonFunc: _onEmailTap,
                              icon: const FaIcon(FontAwesomeIcons.apple),
                              text: S.of(context).appleButton),
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
