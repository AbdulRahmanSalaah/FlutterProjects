part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<SpecializationsData?>? specializationDataList;
  final List<Doctors?>? doctorsList;

  const HomeSuccess({
    required this.specializationDataList,
    required this.doctorsList,
  });

  @override
  List<Object> get props => [specializationDataList ?? [], doctorsList ?? []];
}

final class HomeFailure extends HomeState {
  final Failure failure;

  const HomeFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
