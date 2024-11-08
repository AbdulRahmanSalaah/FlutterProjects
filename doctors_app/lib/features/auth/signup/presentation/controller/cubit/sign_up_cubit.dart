import 'package:doctors_app/features/auth/signup/domain/usecases/sign_up_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/data/networking/api_error_model.dart';
import '../../../data/models/sign_up_request_body_model.dart';
import '../../../data/models/sign_up_response_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpUsecase) : super(SignUpInitial());

  final SignUpUsecase signUpUsecase;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  void signUp() async {
    emit(SignUpLoading());

    final response = await signUpUsecase.call(
      SignUpRequestBody(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
        gender: 0,
      ),
    );

    response.fold((apiErrorModel) {
      emit(SignUpFailure(apiErrorModel.apiErrorModel));
    }, (response) {
      emit(SignUpSuccess(response));
    });
  }
}
