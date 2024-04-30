part of 'tagihan_local_bloc.dart';

sealed class TagihanLocalState extends Equatable {
  const TagihanLocalState();

  @override
  List<Object> get props => [];
}

final class TagihanLocalInitial extends TagihanLocalState {}

final class TagihanLocalLoading extends TagihanLocalState {}

final class TagihanLocalSuccess extends TagihanLocalState {
  final List<TagihanLocalModel> data;
  const TagihanLocalSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class TagihanLocalFetchSuccess extends TagihanLocalState {
  final List<TagihanLocalModel> data;
  const TagihanLocalFetchSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class TagihanLocalFetchFailed extends TagihanLocalState {
  final List<TagihanLocalModel> data;
  const TagihanLocalFetchFailed(this.data);

  @override
  List<Object> get props => [data];
}

final class TagihanLocalDeleteSuccess extends TagihanLocalState {}

final class TagihanLocalPaymentConfirmationSuccess extends TagihanLocalState {}

final class TagihanBillAmountnSuccess extends TagihanLocalState {
  final TagihanLocalAmountModel data;
  const TagihanBillAmountnSuccess(this.data);
}

final class TagihanLocalDetailSuccess extends TagihanLocalState {
  final int data;
  const TagihanLocalDetailSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class TagihanLocalFailed extends TagihanLocalState {
  final String e;
  const TagihanLocalFailed(this.e);

  @override
  List<Object> get props => [e];
}
