import 'package:dio/dio.dart';
import '../model/app%20config.dart';
import 'package:get_it/get_it.dart';

class WebService {
  final Dio dio = Dio();
  Appconfig? _appconfig;
  String? _baseUrl;

  WebService() {
    _appconfig = GetIt.I.get<Appconfig>();
    _baseUrl = _appconfig!.baseURL;
  }

  Future<Response?> getData(String endpoint) async {
    try {
     String url = "$_baseUrl$endpoint";
     Response _coinResponse = await dio.get(url);
     return _coinResponse;
    } catch (e) {
      print("$endpoint data not fetched.\nError:\n\t $e");
      return null;
    }
  }
}
