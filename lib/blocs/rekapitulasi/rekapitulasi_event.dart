part of 'rekapitulasi_bloc.dart';

sealed class RekapitulasiEvent extends Equatable {
  const RekapitulasiEvent();

  @override
  List<Object> get props => [];
}

class TagihanKontrakGet extends RekapitulasiEvent {}

class TagihanManualGet extends RekapitulasiEvent {}
