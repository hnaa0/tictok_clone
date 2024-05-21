import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_vm.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreen();
}

class _BirthdayScreen extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdaycontroller = TextEditingController();

  late DateTime today;
  late DateTime initialDate;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    initialDate = DateTime(today.year - 12);
    _setTextFieldDate(initialDate);
  }

  // 위젯이 사라질 때 컨트롤러도 dispose.
  // dispose해주지 않으면 메모리 부족으로 충돌이 일어날 수도 있음
  @override
  void dispose() {
    _birthdaycontroller.dispose();
    super.dispose();
  }

  void _onNextTap() {
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "birthday": _birthdaycontroller.text,
    };
    ref.read(signUpProvider.notifier).signUp(context);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdaycontroller.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When's your birthday?",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: Sizes.size24,
              ),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(
                color: Colors.black38,
                fontSize: Sizes.size16,
              ),
            ),
            Gaps.v16,
            // TextField: 문자를 입력할 수 있는 위젯
            TextField(
              enabled: false,
              controller: _birthdaycontroller,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),
            Gaps.v16,
            GestureDetector(
              onTap: _onNextTap,
              child: FormButton(
                disabled: ref.watch(signUpProvider).isLoading,
                text: "Next",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 200,
        child: CupertinoDatePicker(
          maximumDate: initialDate,
          initialDateTime: initialDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
