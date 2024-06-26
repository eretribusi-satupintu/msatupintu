import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/model/tagihan_local_amount_model.dart';
import 'package:satupintu_app/model/tagihan_local_model.dart';
import 'package:satupintu_app/services/tagihan_local_services.dart';

part 'tagihan_local_event.dart';
part 'tagihan_local_state.dart';

class TagihanLocalBloc extends Bloc<TagihanLocalEvent, TagihanLocalState> {
  TagihanLocalBloc() : super(TagihanLocalInitial()) {
    on<TagihanLocalEvent>((event, emit) async {
      if (event is TagihanLocalStore) {
        try {
          emit(TagihanLocalLoading());
          final tagihan = await TagihanLocalServices().storeTagihan(
              const TagihanLocalModel(
                  tagihanId: 2,
                  subWilayahId: 3,
                  tagihanName: "Tagihan 1",
                  wajibRetribusiName: "Rizki Okto",
                  price: 20000,
                  subwilayah: "Laguboti",
                  dueDate: "12:01:2024:Z01:04:02",
                  status: true));
          emit(TagihanLocalDetailSuccess(tagihan));
        } catch (e) {
          emit(TagihanLocalFailed(e.toString()));
        }
      }

      if (event is TagihanLocalGet) {
        try {
          emit(TagihanLocalLoading());
          final res = await TagihanLocalServices().getTagihan();
          print({"local tagihan record : ": res});
          emit(TagihanLocalSuccess(res));
        } catch (e) {
          emit(TagihanLocalFailed(e.toString()));
        }
      }
      if (event is TagihanLocalFromServerStore) {
        try {
          emit(TagihanLocalLoading());

          final tagihan = await TagihanLocalServices().storeTagihanFromServer();

          emit(TagihanLocalFetchSuccess(tagihan));
        } catch (e) {
          final res = await TagihanLocalServices().getTagihan();
          // print({"local tagihan record becouse server error : ": res});
          // emit(TagihanLocalSuccess(res));
          emit(TagihanLocalFetchFailed(res));
        }
      }
      if (event is TagihanLocalDelete) {
        try {
          emit(TagihanLocalLoading());

          await TagihanLocalServices().deleteTagihan(event.id);

          emit(TagihanLocalDeleteSuccess());
        } catch (e) {
          emit(TagihanLocalFailed(e.toString()));
        }
      }
      if (event is TagihanLocalPaymentConfirmation) {
        try {
          emit(TagihanLocalLoading());

          await TagihanLocalServices()
              .paymentConfirmationTagihan(event.id, event.status);

          emit(TagihanLocalPaymentConfirmationSuccess());
        } catch (e) {
          emit(TagihanLocalFailed(e.toString()));
        }
      }
      if (event is TagihanBillAmount) {
        try {
          emit(TagihanLocalLoading());

          final amount = await TagihanLocalServices().getBillAmountTagihan();

          emit(TagihanBillAmountnSuccess(amount));
        } catch (e) {
          emit(TagihanLocalFailed(e.toString()));
        }
      }
      if (event is TagihanLocalDeleteAll) {
        try {
          emit(TagihanLocalLoading());

          await TagihanLocalServices().deleteAllTagihan();

          emit(TagihanLocalDeleteSuccess());
        } catch (e) {
          emit(TagihanLocalFailed(e.toString()));
        }
      }
      if (event is TagihanLocalSynchronization) {
        try {
          emit(TagihanLocalLoading());
          final sync = await TagihanLocalServices()
              .synchronizationTagihanLocal(event.data);
          print({"status sinkronisasi": sync});

          emit(TagihanLocalSynchronizeSuccess(sync));
        } catch (e) {
          final res = await TagihanLocalServices().getTagihan();
          emit(TagihanLocalFetchFailed(res));
        }
      }
    });
  }
}
