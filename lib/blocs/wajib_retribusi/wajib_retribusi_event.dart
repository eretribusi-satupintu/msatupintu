part of 'wajib_retribusi_bloc.dart';

sealed class WajibRetribusiEvent extends Equatable {
  const WajibRetribusiEvent();

  @override
  List<Object> get props => [];
}

class WajibRetribusiGet extends WajibRetribusiEvent {
  final int petugasId;

  const WajibRetribusiGet(this.petugasId);
}

class WajibRetribusiGetDetail extends WajibRetribusiEvent {
  final int wajibRetribusiId;

  const WajibRetribusiGetDetail(this.wajibRetribusiId);
}

class WajibRetribusiGetDetailFromScan extends WajibRetribusiEvent {
  final String nik;

  const WajibRetribusiGetDetailFromScan(this.nik);
}
