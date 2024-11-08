import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/error/failures.dart';
import '../../../../../core/data/networking/api_error_handler.dart';
import '../../../data/models/specializations_response_model.dart';
import '../../../domain/usecases/get_specializations_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSpecializationsUsecase getSpecializationsUsecase;

  HomeCubit(this.getSpecializationsUsecase) : super(HomeInitial());

  List<SpecializationsData?>? specializationsList = [];
  List<Doctors?>? doctorsList = [];

  void getSpecializations() async {
    emit(HomeLoading());

    final response = await getSpecializationsUsecase.getSpecializations();
    response.fold(
      (l) => emit(HomeFailure(l)),
      (r) {
        // Store the fetched specializations in the list
        specializationsList = r.specializationDataList ?? [];
        
        // Fetch doctors for the first specialization by default
        getDoctorsList(specializationId: specializationsList?.first?.id);

        emit(HomeSuccess(
          specializationDataList: r.specializationDataList,
          doctorsList: doctorsList,
        ));
      },
    );
  }

  void getDoctorsList({int? specializationId}) {
    // Only emit a new state for doctors
    doctorsList = getDoctorsListBySpecializationId(specializationId);

    if (doctorsList != null && doctorsList!.isNotEmpty) {
      emit(HomeSuccess(
        specializationDataList: specializationsList,
        doctorsList: doctorsList,
      ));
    } else {
      emit(HomeFailure(ApiErrorHandler.handle('No doctors found') as Failure));
    }
  }

  /// Returns the list of doctors based on the specialization id
  List<Doctors?>? getDoctorsListBySpecializationId(int? specializationId) {
    return specializationsList
        ?.firstWhere((specialization) => specialization?.id == specializationId)
        ?.doctorsList;
  }
}

