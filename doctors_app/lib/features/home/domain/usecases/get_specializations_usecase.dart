import 'package:dartz/dartz.dart';
import 'package:doctors_app/features/home/domain/repository/base_home_repo.dart';

import '../../../../core/data/error/failures.dart';
import '../../data/models/specializations_response_model.dart';

class GetSpecializationsUsecase {
  final BaseHomeRepo baseHomeRepo;

  GetSpecializationsUsecase({required this.baseHomeRepo});

  Future<Either<Failure, SpecializationsResponseModel>>
      getSpecializations() async {
    return await baseHomeRepo.getSpecializations();
  }
}
