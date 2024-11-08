part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final SignUpResponse signUpResponse;

  const SignUpSuccess(this.signUpResponse);

  @override
  List<Object> get props => [signUpResponse];
}

final class SignUpFailure extends SignUpState {
  final ApiErrorModel apiErrorModel;

  const SignUpFailure(this.apiErrorModel);

  @override

  List<Object> get props => [apiErrorModel];
}
