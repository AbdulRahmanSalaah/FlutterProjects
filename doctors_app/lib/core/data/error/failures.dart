import 'package:doctors_app/core/data/networking/api_error_model.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final ApiErrorModel apiErrorModel;

  const Failure(this.apiErrorModel);

  @override
  List<Object> get props => [apiErrorModel];
}

class ServerFailure extends Failure {
  const ServerFailure(
    super.message,
  );
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}
