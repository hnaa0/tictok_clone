import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  // GlobalKey: 고유 식별자의 역할. 폼의 state에 접근 가능하고 폼의 메서드 실행 가능.
  // form + GlobalKey = 엄청나게 간편하게 유효성검사 가능
  // 여러 개의 입력이 필요할 땐 form을 사용하는게 적합한데 이 form의 value를 간편하게 다루기 위해선 GlobalKey를 사용
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    // null check 방법1.
    // if (_formKey.currentState != null) {
    //   _formKey.currentState!.validate();
    // }

    // null check 방법2.
    // _formKey.currentState?.validate();

    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // 저장된 값마다 함수 돌릴 수 있음
        _formKey.currentState!.save();
        // pushAndRemoveUntil: 새로운 화면을 push하고 이전 화면들은 제거. 화면수 선택도 가능
        // return false => 이전 화면 삭제 true => 유지
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const InterestsScreen(),
            ),
            (route) => false);
      }
    }
  }

  void _onScaffoldTap() {
    // focus된 걸 모두 unfocus시키는 api
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Log in"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gaps.v28,
                  TextFormField(
                    // 유효성검사 규칙
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please write correct email";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData["email"] = newValue;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: Sizes.size2,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v16,
                  TextFormField(
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Please write correct password";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData["password"] = newValue;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: Sizes.size2,
                        ),
                      ),
                    ),
                  ),
                  Gaps.v28,
                  GestureDetector(
                    onTap: _onSubmitTap,
                    child: const FormButton(
                      disabled: false,
                      text: "Log In",
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
