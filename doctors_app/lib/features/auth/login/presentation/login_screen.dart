import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/networking/api_error_model.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/theming/text_style.dart';
import '../../../../core/widgets/app_text_button.dart';
import 'controller/cubit/login_cubit.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/dont_have_account_text.dart';
import 'widgets/remember_me_and_forget_pass.dart';
import 'widgets/terms_and_conditions_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 36.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: TextStyles.font24BlueBold,
                ),
                SizedBox(height: 8.h),
                Text(
                  'We\'re excited to have you back, can\'t wait to \n see what you\'ve been up to since you last\n logged in.',
                  style: TextStyles.font13GreyRegular,
                ),

                // Login Form
                SizedBox(height: 36.h),
                const CustomTextField(),
                // SizedBox(height: 24.h),
                const RememberMeAndForgetPass(),
                SizedBox(height: 40.h),
                AppTextButton(
                  buttonText: 'Login',
                  textStyle: TextStyles.font16WhiteSemiBold,
                  onPressed: () {
                    validateThenDoLogin(context);
                  },
                ),
                SizedBox(height: 80.h),
                const TermsAndConditionsText(),
                SizedBox(height: 40.h),
                const Align(
                  alignment: Alignment.center,
                  child: DontHaveAccountText(),
                ),

                BlocListener<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()));
                    } else if (state is LoginSuccess) {
                      Navigator.of(context).pop();
                      GoRouter.of(context).pushReplacement(AppRoutes.homeRoute);
                    } else if (state is LoginFailure) {
                       setupErrorState(context, state.apiErrorModel);
                    
                    }
                  },
                  child: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().login();
    }
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

}
