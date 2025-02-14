import 'package:http/http.dart' as http;
import 'package:news_app/common/constants.dart';

// class ApiService {
//   var client = http.Client();
//   String endpoint = Constants.API_BASE_URL + Constants.API_PREFIX;
//   String apiKey = Constants.API_KEY;

//   Map<String, String> headers = {
//     "Content-Type": "application/json; charset=UTF-8",
//     "Accept": "application/json"
//   };

//   Future<http.Response> getTopHeadlines() {
//     return client.get(
//       Uri.parse('$endpoint/top-headlines?apiKey=$apiKey'),
//       headers: headers,
//     );
//   }

//   Future<http.Response> getEverything(String keyword, int page) {
//     return client.get(
//       Uri.parse('$endpoint/everything?q=$keyword&language=en&sortBy=publishedAt&page=$page&apiKey=$apiKey'),
//       headers: headers,
//     );
//   } 

// }
// class ApiService {
//   var client = http.Client();
//   String endpoint = Constants.API_BASE_URL + Constants.API_PREFIX;
//   String apiKey = Constants.API_KEY;

//   Map<String, String> headers = {
//     "Content-Type": "application/json; charset=UTF-8",
//     "Accept": "application/json"
//   };

//   Future<http.Response> getTopHeadlines() {
//     return client.get(
//       Uri.parse('$endpoint/top-headlines?apiKey=$apiKey'),
//       headers: headers,
//     );
//   }

//   Future<http.Response> getEverything(String keyword, int page, {int pageSize = 20}) {
//     return client.get(
//       Uri.parse('$endpoint/everything?q=$keyword&language=en&sortBy=publishedAt&page=$page&pageSize=$pageSize&apiKey=$apiKey'),
//       headers: headers,
//     );
//   } 
// }

class ApiService {
  var client = http.Client();
  String endpoint = Constants.API_BASE_URL + Constants.API_PREFIX;
  String apiKey = Constants.API_KEY;

  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
    "Accept": "application/json"
  };

  Future<http.Response> getTopHeadlines({String category = '', int page = 1, int pageSize = 20}) {
    String url = '$endpoint/top-headlines?apiKey=$apiKey&page=$page&pageSize=$pageSize';
    if (category.isNotEmpty) {
      url += '&category=$category';
    }
    return client.get(
      Uri.parse(url),
      headers: headers,
    );
  }

  Future<http.Response> getEverything(String keyword, int page, {int pageSize = 20}) {
    return client.get(
      Uri.parse('$endpoint/everything?q=$keyword&language=en&sortBy=publishedAt&page=$page&pageSize=$pageSize&apiKey=$apiKey'),
      headers: headers,
    );
  }
   Future<http.Response> searchArticles(String keyword, int page, {int pageSize = 20}) {
    return client.get(
      Uri.parse('$endpoint/everything?qInTitle=$keyword&language=en&sortBy=publishedAt&page=$page&pageSize=$pageSize&apiKey=$apiKey'),
      headers: headers,
    );
  }

}
