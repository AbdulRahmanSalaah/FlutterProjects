import 'package:json_annotation/json_annotation.dart';

import 'package:equatable/equatable.dart';

part 'login_request_body_model.g.dart';

@JsonSerializable()
class LoginRequestBody extends Equatable {
  final String email;
  final String password;

  const LoginRequestBody({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> toJson() => _$LoginRequestBodyToJson(this);
}
