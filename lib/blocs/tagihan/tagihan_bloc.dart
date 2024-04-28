import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/blocs/tagihan_local/tagihan_local_bloc.dart';
import 'package:satupintu_app/model/tagihan_model.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/services/tagihan_local_services.dart';
import 'package:satupintu_app/services/tagihan_services.dart';
import 'package:satupintu_app/services/wajib_retribusi_services.dart';
import 'package:satupintu_app/ui/pages/petugas/wajib_retribusi_petugas_page.dart';

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

      if (event is TagihanGetDetail) {
        try {
          emit(TagihanLoading());
          final tagihan =
              await TagihanService().getTagihanDetail(event.tagihanId);
          print({"bloc": tagihan});
          emit(TagihanDetailSuccess(tagihan));
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }

      if (event is TagihanGetDetailUpdateStatus) {
        final updateTagihan = (state as TagihanDetailSuccess)
            .data
            .copyWith(status: event.tagihanStatus);

        emit(TagihanDetailSuccess(updateTagihan));
      }

      if (event is TagihanWajibRetribusiGet) {
        try {
          emit(TagihanLoading());
          final tagihan = await TagihanService()
              .getTagihanWajibRetribusi(event.wajibRetribusiId);
          emit(TagihanSuccess(tagihan));
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }

      if (event is TagihanWajibRetribusiMasyarakatGet) {
        try {
          emit(TagihanLoading());
          final tagihan =
              await TagihanService().getTagihanWajibRetribusiMasyarakat();
          emit(TagihanSuccess(tagihan));
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }

      if (event is TagihanWajibRetribusiMasyarakatProgressGet) {
        try {
          emit(TagihanLoading());
          final tagihan = await TagihanService()
              .getTagihanWajibRetribusiMasyarakatProgress(event.kontrakId);
          emit(TagihanSuccess(tagihan));
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }

      if (event is PetugasPaidTagihanGet) {
        try {
          emit(TagihanLoading());
          final tagihan =
              await TagihanService().getPetugasPaidTagihan(event.status);
          // emit(TagihanSuccess(tagihan));
          TagihanLocalFailed(tagihan.toString());
        } catch (e) {
          emit(TagihanFailed(e.toString()));
        }
      }
    });
  }
}
