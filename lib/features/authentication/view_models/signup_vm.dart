import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/utils.dart';

// 계정 생성 시 로딩화면을 보여주고 계정생성을 트리거하기만 하는 viewmodel이기 때문에 expose할 필요X
class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading(); // 로딩중으로 만들고
    final form = ref.read(signUpForm);

    // guard(): future func을 보내면 try catch로 에러를 잡음
    // 문제가 생기면 state에 에러가 들어오고 없으면 future func 결과 데이터가 들어옴
    state = await AsyncValue.guard(
      () async => await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      ),
    );

    if (state.hasError) {
      showFirbaseErrorSnack(context, state.error);
    } else {
      context.goNamed(InterestsScreen.routeName);
    }
  }
}

// StateProvider: 외부에서 수정할 수 있는 value를 expose하게 해줌
final signUpForm = StateProvider((ref) => {});

final signUpProvider =
    AsyncNotifierProvider<SignUpViewModel, void>(() => SignUpViewModel());
