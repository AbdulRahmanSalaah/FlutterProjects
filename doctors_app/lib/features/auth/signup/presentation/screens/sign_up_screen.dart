import 'package:doctors_app/features/auth/signup/presentation/controller/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/data/networking/api_error_model.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/theming/text_style.dart';
import '../../../../../core/widgets/app_text_button.dart';
import '../../../login/presentation/widgets/terms_and_conditions_text.dart';
import '../widgets/already_have_account_text.dart';
import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
                  style: TextStyles.font24BlueBold,
                ),
                // verticalSpace(8),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                  style: TextStyles.font14GrayRegular,
                ),
                // verticalSpace(36),
                SizedBox(
                  height: 36.h,
                ),
                Column(
                  children: [
                    const SignupForm(),
                    SizedBox(
                      height: 40.h,
                    ),
                    AppTextButton(
                      buttonText: "Create Account",
                      textStyle: TextStyles.font16WhiteSemiBold,
                      onPressed: () {
                        validateThenDoSignup(context);
                      },
                    ),
                    // verticalSpace(16),
                    SizedBox(
                      height: 16.h,
                    ),
                    const TermsAndConditionsText(),
                    // verticalSpace(30),
                    SizedBox(
                      height: 30.h,
                    ),
                    const AlreadyHaveAccountText(),

                    BlocListener<SignUpCubit, SignUpState>(
                      listener: (context, state) {
                        if (state is SignUpLoading) {
                          showDialog(
                            context: context,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        if (state is SignUpSuccess) {
                          Navigator.of(context).pop();
                          showSuccessDialog(context);
                        } else if (state is SignUpFailure) {
                          
                          setupErrorState(context, state.apiErrorModel);
                        }
                      },
                      child: const SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoSignup(BuildContext context) {
    if (context.read<SignUpCubit>().formKey.currentState!.validate()) {
    context.read<SignUpCubit>().signUp();
    }
  }
}

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Signup Successful'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Congratulations, you have signed up successfully!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              disabledForegroundColor: Colors.grey.withOpacity(0.38),
            ),
            onPressed: () {
              // context.pushNamed(Routes.loginScreen);
              GoRouter.of(context).pushReplacement(AppRoutes.loginRoute);
            },
            child: const Text('Continue'),
          ),
        ],
      );
    },
  );
}

void setupErrorState(BuildContext context, ApiErrorModel apiErrorModel) {
  context.pop();
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 32,
      ),
      content: Text(
        apiErrorModel.getAllErrorMessages(),
        style: TextStyles.font15DarkBlueMedium,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            'Got it',
            style: TextStyles.font14BlueSemiBold,
          ),
        ),
      ],
    ),
  );
}
