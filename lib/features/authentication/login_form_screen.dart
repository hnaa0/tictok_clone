import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/login_vm.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  ConsumerState<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  // GlobalKey: 고유 식별자의 역할. 폼의 state에 접근 가능하고 폼의 메서드 실행 가능.
  // form + GlobalKey = 엄청나게 간편하게 유효성검사 가능
  // 여러 개의 입력이 필요할 땐 form을 사용하는게 적합한데 이 form의 value를 간편하게 다루기 위해선 GlobalKey를 사용
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref
            .read(loginProvider.notifier)
            .login(formData["email"]!, formData["password"]!, context);
        // context.goNamed(InterestsScreen.routeName);
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
                    child: FormButton(
                      disabled: ref.watch(loginProvider).isLoading,
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
