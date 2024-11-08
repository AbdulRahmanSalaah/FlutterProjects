import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'specializations_response_model.g.dart';

@JsonSerializable()
class SpecializationsResponseModel extends Equatable {
  @JsonKey(name: 'data')
  final List<SpecializationsData?>? specializationDataList;

  const SpecializationsResponseModel({
    this.specializationDataList,
  });

  factory SpecializationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SpecializationsResponseModelFromJson(json);

  @override
  List<Object?> get props => [specializationDataList];
}

@JsonSerializable()
class SpecializationsData extends Equatable {
  final int? id;
  final String? name;
  @JsonKey(name: 'doctors')
  final List<Doctors?>? doctorsList;

  const SpecializationsData({
    this.id,
    this.name,
    this.doctorsList,
  });

  factory SpecializationsData.fromJson(Map<String, dynamic> json) =>
      _$SpecializationsDataFromJson(json);

  @override
  List<Object?> get props => [id, name, doctorsList];
}

@JsonSerializable()
class Doctors extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? gender;
  @JsonKey(name: 'appoint_price')
  final int? price;
  final String degree;

  const Doctors({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.price,
    required this.degree,
  });

  factory Doctors.fromJson(Map<String, dynamic> json) =>
      _$DoctorsFromJson(json);

  @override
  List<Object?> get props =>
      [id, name, email, phone, photo, gender, price, degree];
}
