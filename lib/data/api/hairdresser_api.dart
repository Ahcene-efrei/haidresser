import 'package:dio/dio.dart';
import 'package:hairdresser/data/api/api.dart';
import 'package:hairdresser/data/api/error_exception.dart';
import 'package:hairdresser/data/models/Hairdresser.dart';
import 'package:hairdresser/data/models/search_parameters.dart';

class HairdresserApi extends Api{

  Future<dynamic> getHairdresserDetails(Hairdresser hairdresser) async {
    final dio = Dio(BaseOptions(contentType: "application/json; charset=utf-8"));
    String token = await getJTWToken();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${token}";
    var response = await dio.get('https://labonnecoupe.azurewebsites.net/api/Hairdresser',
      queryParameters: {
        "id": hairdresser.id,
      },
    );

    if(response.statusCode == 200 && response.data['succeeded']) {
      return response.data;
    }else{
      throw ErrorException(
          succeeded: response.data['succeeded'],
          errorCode: response.data['errorCode'],
          message: response.data['message'],
          errors: response.data['errors']
      );
    }
  }

  Future<dynamic> getListHairdresser(SearchParameters parameters) async {
    final dio = Dio(BaseOptions(contentType: "application/json; charset=utf-8"));
    String token = await getJTWToken();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["authorization"] = "Bearer ${token}";
    var response = await dio.get('https://labonnecoupe.azurewebsites.net/api/Hairdresser',
      queryParameters: {
        "Name": parameters.name,
        "Latitude": parameters.latitude,
        "Longitude": parameters.longitude,
        "FromDateTime": parameters.fromDateTime,
        "MinPrice": parameters.minPrice,
        "MaxPrice": parameters.maxPrice,
        "Gender": parameters.gender,
        "HairType": parameters.hairType,
        "ProductType": parameters.productType,
        "RealizableAtHome": parameters.realizableAtHome,
        "PageNumber": parameters.pageNumber,
        "PageSize": parameters.pageSize,
      },
    );

    if(response.statusCode == 200 && response.data['succeeded']) {
      return response.data;
    }else{
      throw ErrorException(
          succeeded: response.data['succeeded'],
          errorCode: response.data['errorCode'],
          message: response.data['message'],
          errors: response.data['errors']
      );
    }
  }
}