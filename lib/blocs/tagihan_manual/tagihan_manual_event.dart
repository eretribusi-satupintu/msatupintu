part of 'tagihan_manual_bloc.dart';

sealed class TagihanManualEvent extends Equatable {
  const TagihanManualEvent();

  @override
  List<Object> get props => [];
}

class TagihanManualGet extends TagihanManualEvent {}

class TagihanManualPost extends TagihanManualEvent {
  final TagihanManualFormModel tagihanManual;
  const TagihanManualPost(this.tagihanManual);
}
