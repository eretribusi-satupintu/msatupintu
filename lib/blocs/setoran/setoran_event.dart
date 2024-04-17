part of 'setoran_bloc.dart';

sealed class SetoranEvent extends Equatable {
  const SetoranEvent();

  @override
  List<Object> get props => [];
}

class SetoranGet extends SetoranEvent {}

class SetoranPost extends SetoranEvent {
  final SetoranFormModel data;
  const SetoranPost(this.data);
}

class SetoranUpdate extends SetoranEvent {
  final int id;
  final SetoranFormModel data;
  const SetoranUpdate(this.id, this.data);
}
