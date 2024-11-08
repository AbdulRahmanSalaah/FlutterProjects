import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

// json_serializable is a code generator for converting JSON to Dart classes.
// This library is a set of utilities to aid in the development of JSON serialization.
@JsonSerializable()
class ApiErrorModel extends Equatable {
  final String? message;
  final int? code;
  @JsonKey(name: 'data')
  final dynamic errors;

  const ApiErrorModel({
    required this.message,
    this.code,
    this.errors,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

  @override
  List<Object?> get props => [message, code];

  /// Returns a String containing all the error messages
  String getAllErrorMessages() {
    if (errors == null || errors is List && (errors as List).isEmpty) {
      return message ?? "Unknown Error occurred";
    }


    if (errors is Map<String, dynamic>) {
      final errorMessage =
          (errors as Map<String, dynamic>).entries.map((entry) {
        final value = entry.value;
        return "${value.join(',')}";
      }).join('\n');

      return errorMessage;
    } else if (errors is List) {
      return (errors as List).join('\n');
    }

    return message ?? "Unknown Error occurred";
  }
  
}
