import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    // push: 화면을 위에 올리는 것.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
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
                  const Text(
                    "Sing up for Tiktok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                        buttonFunc: _onEmailTap,
                        icon: const FaIcon(FontAwesomeIcons.solidUser),
                        text: "Use Email & Password"),
                    Gaps.v16,
                    AuthButton(
                        buttonFunc: _onEmailTap,
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        text: "Continue with Apple"),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                              buttonFunc: _onEmailTap,
                              icon: const FaIcon(FontAwesomeIcons.solidUser),
                              text: "Use Email & Password"),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                              buttonFunc: _onEmailTap,
                              icon: const FaIcon(FontAwesomeIcons.apple),
                              text: "Continue with Apple"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shadowColor: Colors.black,
            elevation: 5,
            surfaceTintColor: Colors.grey.shade100,
            height: 90,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: Sizes.size16),
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      "Log In",
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
