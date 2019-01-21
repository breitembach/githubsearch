import 'package:dio/dio.dart';
import 'package:programacaoreativa/models/SearchResult.dart';

class GithubService {
  final dio = Dio();

  Future<SearchResult> search(String text) async {
    Response response =
        await dio.get("https://api.github.com/search/repositories?q=${text}");
    print("response ${response.data} ");
    return SearchResult.fromJson(response.data);
  }
}
