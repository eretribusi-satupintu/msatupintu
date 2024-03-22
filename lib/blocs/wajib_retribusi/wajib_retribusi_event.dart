part of 'wajib_retribusi_bloc.dart';

sealed class WajibRetribusiEvent extends Equatable {
  const WajibRetribusiEvent();

  @override
  List<Object> get props => [];
}

class WajibRetribusiGet extends WajibRetribusiEvent {
  final int petugasId;
  final int subWilayahId;

  const WajibRetribusiGet(this.petugasId, this.subWilayahId);
}
