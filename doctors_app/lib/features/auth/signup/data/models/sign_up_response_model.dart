import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response_model.g.dart';
@JsonSerializable()
class SignUpResponse extends Equatable {
  final String? message;
  @JsonKey(name: 'data')
  final UserData? userData;
  final bool? status;
  final int? code;

  const SignUpResponse({this.message, this.userData, this.status, this.code});

  factory SignUpResponse.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseFromJson(json);

  @override
  List<Object?> get props => [message, userData, status, code];
}

@JsonSerializable()
class UserData extends Equatable {
 final  String? token;
  @JsonKey(name: 'username')
 final String? userName;

  const UserData({this.token, this.userName});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  @override
  List<Object?> get props => [token, userName];
}
