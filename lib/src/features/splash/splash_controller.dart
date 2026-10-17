import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_design/index.dart';

part 'splash_state.dart';

class SplashController extends Cubit<SplashState> {
  SplashController() : super(SplashInitialState());

  Future<void> checkLoginStatus() async {
    // simulator check login logic
    await SdHelperV5.delay(milliseconds: 1000);

    emit(LoggedInLState());
  }
}
