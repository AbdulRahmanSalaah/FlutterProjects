import 'package:dartz/dartz.dart';

import '../../../../core/data/error/failures.dart';
import '../../data/models/specializations_response_model.dart';

abstract class BaseHomeRepo {
  Future<Either<Failure, SpecializationsResponseModel>> getSpecializations();
}
