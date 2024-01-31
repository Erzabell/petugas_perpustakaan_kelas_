import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:petugas_perpustakaan_kelas_c/app/data/constant/endpoint.dart';
import 'package:petugas_perpustakaan_kelas_c/app/data/model/response_book.dart';
import 'package:petugas_perpustakaan_kelas_c/app/data/model/response_pinjam.dart';

import '../../../data/provider/api_provider.dart';

class PeminjamanController extends GetxController  with StateMixin<List<DataPinjam>>{

  @override
  void onInit() {
    super.onInit();
    getpeminjaman();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  getpeminjaman() async {
    change(null, status: RxStatus.loading());
    try {
      final response = await ApiProvider.instance().get(Endpoint.pinjam,);
      if( response.statusCode == 200) {
        final ResponsePinjam responsePinjam = ResponsePinjam.fromJson(response.data);
        if(responsePinjam.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          change(responsePinjam.data, status: RxStatus.success());
        }

      } else {
        change(null, status: RxStatus.error("Gagal mengambil data"));
      }
    } on DioException catch (e) {
      if (e.response != null){
        if (e.response?.data != null){

          change(null, status: RxStatus.error(" dio ${e.response?.data['message']}"));

        }
      } else {
        change(null, status: RxStatus.error("cek" + (e.message??"")));
      }
    }catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
