part of 'tagihan_bloc.dart';

sealed class TagihanState extends Equatable {
  const TagihanState();

  @override
  List<Object> get props => [];
}

final class TagihanInitial extends TagihanState {}

final class TagihanLoading extends TagihanState {}

final class TagihanFailed extends TagihanState {
  final String e;
  const TagihanFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class TagihanSuccess extends TagihanState {
  final List<TagihanModel> data;
  const TagihanSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class TagihanScannedSuccess extends TagihanState {}

final class TagihanDetailSuccess extends TagihanState {
  final TagihanModel data;
  const TagihanDetailSuccess(this.data);

  @override
  List<Object> get props => [data];
}
