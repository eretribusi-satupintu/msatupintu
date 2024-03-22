part of 'item_retribusi_sewa_bloc.dart';

sealed class ItemRetribusiSewaEvent extends Equatable {
  const ItemRetribusiSewaEvent();

  @override
  List<Object> get props => [];
}

class ItemRetribusiSewaGet extends ItemRetribusiSewaEvent {
  final int retribusiId;
  const ItemRetribusiSewaGet(this.retribusiId);
}

class KontrakWajibRetribusiGet extends ItemRetribusiSewaEvent {
  final int wajibRetribusiId;
  final int subWilayahId;

  const KontrakWajibRetribusiGet(this.wajibRetribusiId, this.subWilayahId);
}
