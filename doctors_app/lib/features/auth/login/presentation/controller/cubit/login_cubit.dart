import 'package:doctors_app/core/data/networking/api_constants.dart';
import 'package:doctors_app/core/data/networking/api_error_model.dart';
import 'package:doctors_app/features/auth/login/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/data/networking/dio_factory.dart';
import '../../../../../../core/helper/shared_pref_helper.dart';
import '../../../data/models/login_request_body_model.dart';
import '../../../data/models/login_response_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());

  final LoginUseCase loginUseCase;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void login() async {
    emit(LoginLoading());

    final response = await loginUseCase.call(
      LoginRequestBody(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    response.fold((apiErrorModel) {
      emit(LoginFailure(apiErrorModel.apiErrorModel));
    }, (response) async {
      await saveUserToken(response.userData?.token ?? '');
      userNametohome = response.userData?.userName ?? '';

      // Save the user name in shared preferences
      await SharedPrefHelper.setData(SharedPrefKeys.userName, userNametohome);
      if (rememberMe) {
        // Additional handling for "Remember Me"
        await SharedPrefHelper.setData(SharedPrefKeys.userToken, true);
      } else {
        await SharedPrefHelper.setData(SharedPrefKeys.userToken, false);
      }

      emit(LoginSuccess(response));
    });
  }

  Future<void> saveUserToken(String token) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }
}
