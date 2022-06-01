import 'package:dio/dio.dart';
import 'package:flutter_tugas_akhir/models/district_model.dart';
import 'package:flutter_tugas_akhir/services/service.dart';

class DistrictService {
  var dio = Dio();

  Future<List<DistrictModel>> district() async {
    try {
      var response = await dio.get(
        Service.apiUrl + '/districts',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );
      print(response.data);
      return (response.data['data'] as List)
          .map((district) => DistrictModel.fromJson(district))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
