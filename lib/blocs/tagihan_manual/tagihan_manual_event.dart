part of 'tagihan_manual_bloc.dart';

sealed class TagihanManualEvent extends Equatable {
  const TagihanManualEvent();

  @override
  List<Object> get props => [];
}

class TagihanManualGet extends TagihanManualEvent {}

class TagihanManualPaidGet extends TagihanManualEvent {}

class TagihanManualImagePost extends TagihanManualEvent {
  final int tagihanManualId;
  final String image;
  const TagihanManualImagePost(this.tagihanManualId, this.image);
}

class TagihanManualPost extends TagihanManualEvent {
  final TagihanManualFormModel tagihanManual;
  const TagihanManualPost(this.tagihanManual);
}
