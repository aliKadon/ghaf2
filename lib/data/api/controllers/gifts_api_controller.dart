import 'package:dio/dio.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/data/api/api_settings.dart';
import 'package:ghaf_application/domain/model/gift.dart';

class GiftsApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiSettings.baseUrl));

  // get gift.
  Future<List<Gift>> getGifts() async {
    print('send request : read-gift');
    var response = await _dio.get(
      'GiftAndReward/read-gift',
      options: Options(
        headers: headers,
      ),
    );
    print('============================================');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      return List<Gift>.from(
          response.data["data"].map((x) => Gift.fromJson(x)));
    }
    return [];
  }
}
