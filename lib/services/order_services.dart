import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/order_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';

class OrderService {
  var dio = Dio();

  Future<List<OrderModel>> marketOrder({required int id}) async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/orderMarket/$id',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        List data = response.data['data'] ?? [];
        List<OrderModel> orders =
            data.map((orders) => OrderModel.fromJson(orders)).toList();
        return orders;
      } else {
        throw Exception('Belum ada pesanan');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<OrderModel>> userOrder({required int id}) async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/orderUser/$id',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        List data = response.data['data'] ?? [];
        List<OrderModel> orders =
            data.map((order) => OrderModel.fromJson(order)).toList();
        return orders;
      } else {
        throw Exception('Belum ada pesanan');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> statusOrder({required int id, required String status}) async {
    try {
      var data = {
        'status': status,
      };
      var response = await dio.put(
        Service.apiUrl + '/statusOrder/$id',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
        data: data,
      );
      print(response.data);
      if (response.statusCode != 200) {
        throw Exception('Gagal ubah status');
      }
      OrderModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception(e);
    }
  }
}
