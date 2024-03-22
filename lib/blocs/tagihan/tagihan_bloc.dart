import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/services/tagihan_services.dart';

part 'tagihan_event.dart';
part 'tagihan_state.dart';

class TagihanBloc extends Bloc<TagihanEvent, TagihanState> {
  TagihanBloc() : super(TagihanInitial()) {
    on<TagihanEvent>((event, emit) async {
      if (event is TagihanNewestGet) {
        try {
          emit(TagihanLoading());
          final tagihan = await TagihanService().getNewestTagihan();
          emit(TagihanSuccess(tagihan));
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }
      if (event is TagihanRetribusiGet) {
        try {
          emit(TagihanLoading());
          final tagihan =
              await TagihanService().getRetribusiTagihan(event.itemRetribusiId);
          emit(TagihanSuccess(tagihan));
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }
    });
  }
}
