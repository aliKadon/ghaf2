import 'package:dio/dio.dart';
import 'package:ghaf_application/data/api/api_helper.dart';
import 'package:ghaf_application/data/api/api_settings.dart';
import 'package:ghaf_application/domain/model/api_response.dart';

class AppApiController with ApiHelper {
  late final Dio _dio = Dio(BaseOptions(baseUrl: ApiSettings.baseUrl));

  // review app.
  Future<ApiResponse> reviewApp({
    required String description,
    required int rate,
  }) async {
    // print('send request : add-user-review');
    Map<String, dynamic> data = {
      "description": description,
      "points": rate,
    };
    // print(data);
    var response = await _dio.post(
      'AppReview/add-user-review',
      data: data,
      options: Options(
        headers: headers,
      ),
    );
    print('============================================review');
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      if (response.data['status'] == 200) {
        return ApiResponse(
          message: response.data['message'],
          status: response.data['status'],
        );
      }
    }
    return failedResponse;
  }
}
