import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:satupintu_app/services/auth_services.dart';
import 'package:satupintu_app/services/wajib_retribusi_services.dart';

part 'qr_payment_event.dart';
part 'qr_payment_state.dart';

class QrPaymentBloc extends Bloc<QrPaymentEvent, QrPaymentState> {
  QrPaymentBloc() : super(QrPaymentInitial()) {
    on<QrPaymentEvent>((event, emit) async {
      // if (event is QrPatmentTagihanGet) {
      //   try {
      //     emit(QrPaymentLoading());
      //     final splittedCode = event.code.split('-');
      //     if (splittedCode.length > 2) {
      //       emit(const QrPaymentFailed('Format kode tidak sesuai'));
      //       return;
      //     }

      //     if (splittedCode[0] == 'list') {
      //       final petugasId = await AuthService().getRoleId();
      //       final wajibRetribusi = await WajibRetribusiService()
      //           .getWajibRetribusi(int.parse(petugasId));

      //       bool isPresent = false;
      //       int? wajibRetribusiId;

      //       for (var item in wajibRetribusi) {
      //         if (item.nik == this.splitted) {
      //           isPresent = true;
      //           wajibRetribusiId = item.id;
      //         }
      //       }

      //       if (isPresent) {
      //         emit(QrPaymentSuccess(wajibRetribusiId!, splittedCode[0]));
      //       } else {
      //         emit(
      //             const WajibRetribusiFailed('Waji Retribusi tidak terdaftar'));
      //       }
      //     }
      //   } catch (e) {
      //     emit(QrPaymentFailed(e.toString()));
      //   }
      // }
    });
  }
}
