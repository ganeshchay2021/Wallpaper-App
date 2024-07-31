import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:wallpaperapp/model/photo_model.dart';

class Repository {
  Dio dio = Dio();

  Future<Either<List<PhotoModel>, String>> getWallPaper(
      String searchText) async {
    String url =
        "https://api.pexels.com/v1/search?query=$searchText";
    try {
      final response = await dio.get(url, queryParameters: {
        "page":1
      },
          options: Options(headers: {
            "Authorization":
                "VXg36GXm3SRBEfUd5wp9X7FGyiTQvClH1JzKbmRQKc4jsJ66WBK3yOuw",
          }));
      final data = List.from(response.data["photos"])
          .map((e) => PhotoModel.fromMap(e))
          .toList();
      return Left(data);
    } catch (e) {
      return Right(e.toString());
    }
  }
}
