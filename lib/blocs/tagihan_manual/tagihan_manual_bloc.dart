import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/tagihan_manual_form_model.dart';
import 'package:satupintu_app/model/tagihan_manual_model.dart';
import 'package:satupintu_app/services/tagihan_manual_services.dart';

part 'tagihan_manual_event.dart';
part 'tagihan_manual_state.dart';

class TagihanManualBloc extends Bloc<TagihanManualEvent, TagihanManualState> {
  TagihanManualBloc() : super(TagihanManualInitial()) {
    on<TagihanManualEvent>((event, emit) async {
      if (event is TagihanManualGet) {
        try {
          emit(TagihanManualLoading());
          final tagihanManual =
              await TagihanManualServices().getTagihanManual();

          emit(TagihanManualSuccess(tagihanManual));
        } catch (e) {
          emit(TagihanManualFailed(e.toString()));
        }
      }
      if (event is TagihanManualPost) {
        try {
          emit(TagihanManualLoading());
          final tagihanManual = await TagihanManualServices()
              .postTagihanManual(event.tagihanManual);
          emit(TagihanManualDetailSuccess(tagihanManual));
        } catch (e) {
          emit(TagihanManualFailed(e.toString()));
        }
      }
    });
  }
}
