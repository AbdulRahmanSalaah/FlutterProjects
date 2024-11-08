import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class UserData extends Equatable {
  final String? token;
  @JsonKey(name: 'username')
  final String? userName;

  const UserData({
    required this.token,
    required this.userName,
  });

  @override
  List<Object?> get props => [token, userName];

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

@JsonSerializable()
class LoginResponse extends Equatable {
  final String? message;
  @JsonKey(name: 'data')
  final UserData? userData;
  final bool? status;
  final int? code;

  const LoginResponse({
    required this.message,
    required this.userData,
    required this.status,
    required this.code,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  @override
  List<Object?> get props => [message, userData, status, code];
}
