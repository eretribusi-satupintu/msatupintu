part of 'tagihan_bloc.dart';

sealed class TagihanEvent extends Equatable {
  const TagihanEvent();

  @override
  List<Object> get props => [];
}

class TagihanNewestGet extends TagihanEvent {}

class TagihanRetribusiGet extends TagihanEvent {
  final int itemRetribusiId;
  const TagihanRetribusiGet(this.itemRetribusiId);
}

class TagihanWajibRetribusiGet extends TagihanEvent {
  final int wajibRetribusiId;
  const TagihanWajibRetribusiGet(this.wajibRetribusiId);
}

class TagihanGetDetail extends TagihanEvent {
  final int tagihanId;
  const TagihanGetDetail(this.tagihanId);
}

class PetugasPaidTagihanGet extends TagihanEvent {
  final String status;
  const PetugasPaidTagihanGet(this.status);
}

class TagihanGetDetailUpdateStatus extends TagihanEvent {
  final String tagihanStatus;
  const TagihanGetDetailUpdateStatus(this.tagihanStatus);
}

class TagihanWajibRetribusiMasyarakatGet extends TagihanEvent {}

class TagihanWajibRetribusiMasyarakatProgressGet extends TagihanEvent {
  final int kontrakId;
  const TagihanWajibRetribusiMasyarakatProgressGet(this.kontrakId);
}
