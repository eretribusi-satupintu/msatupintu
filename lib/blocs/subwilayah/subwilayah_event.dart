part of 'subwilayah_bloc.dart';

sealed class SubwilayahEvent extends Equatable {
  const SubwilayahEvent();

  @override
  List<Object> get props => [];
}

class GetPetugasSubWilayah extends SubwilayahEvent {}

class SelectPetugasSubWilayah extends SubwilayahEvent {
  final SubWilayahModel data;

  const SelectPetugasSubWilayah(this.data);
}

class GetSelectedPetugasSubWilayah extends SubwilayahEvent {}
