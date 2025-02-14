// import 'dart:convert';

// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:news_app/common/colors.dart';
// import 'package:news_app/models/listdata_model.dart';
// import 'package:news_app/models/news_model.dart';
// import 'package:news_app/services/Api.dart';

// class NewsProvider {
//   Future<ListData> GetEverything(String keyword, int page) async {
//     ListData articles = ListData([], 0, false);
//     await ApiService().getEverything(keyword, page).then((response) {
//       if (response.statusCode == 200) {
//         Iterable data = jsonDecode(response.body)['articles'];
//         articles = ListData(
//           data.map((e) => News.fromJson(e)).toList(),
//           jsonDecode(response.body)['totalResults'],
//           true,
//         );
//       } else {
//         Fluttertoast.showToast(
//           msg: jsonDecode(response.body)['message'],
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: AppColors.lighterGray,
//           textColor: AppColors.black,
//           fontSize: 16.0,
//         );
//         throw Exception(response.statusCode);
//       }
//     });
//     return articles;
//   }
// }

// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:news_app/common/colors.dart';
// import 'package:news_app/models/listdata_model.dart';
// import 'package:news_app/models/news_model.dart';
// import 'package:news_app/services/Api.dart';

// class NewsProvider {
//   Map<String, ListData> _cache = {};

//   Future<ListData> GetEverything(String keyword, int page) async {
//     String cacheKey = '$keyword-$page';
//     if (_cache.containsKey(cacheKey)) {
//       return _cache[cacheKey]!;
//     }

//     ListData articles = ListData([], 0, false);
//     await ApiService().getEverything(keyword, page).then((response) {
//       if (response.statusCode == 200) {
//         Iterable data = jsonDecode(response.body)['articles'];
//         articles = ListData(
//           data.map((e) => News.fromJson(e)).toList(),
//           jsonDecode(response.body)['totalResults'],
//           true,
//         );
//         _cache[cacheKey] = articles;
//       } else {
//         Fluttertoast.showToast(
//           msg: jsonDecode(response.body)['message'],
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: AppColors.lighterGray,
//           textColor: AppColors.black,
//           fontSize: 16.0,
//         );
//         throw Exception(response.statusCode);
//       }
//     });
//     return articles;
//   }
// }

// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:news_app/common/colors.dart';
// import 'package:news_app/models/listdata_model.dart';
// import 'package:news_app/models/news_model.dart';
// import 'package:news_app/services/Api.dart';

// class NewsProvider {
//   Map<String, ListData> _cache = {};

//   Future<ListData> getTopHeadlines({String category = ''}) async {
//     String cacheKey = 'topHeadlines-$category';
//     if (_cache.containsKey(cacheKey)) {
//       return _cache[cacheKey]!;
//     }

//     ListData articles = ListData([], 0, false);
//     await ApiService().getTopHeadlines(category: category).then((response) {
//       if (response.statusCode == 200) {
//         Iterable data = jsonDecode(response.body)['articles'];
//         articles = ListData(
//           data.map((e) => News.fromJson(e)).toList(),
//           jsonDecode(response.body)['totalResults'],
//           true,
//         );
//         _cache[cacheKey] = articles;
//       } else {
//         Fluttertoast.showToast(
//           msg: jsonDecode(response.body)['message'],
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: AppColors.lighterGray,
//           textColor: AppColors.black,
//           fontSize: 16.0,
//         );
//         throw Exception(response.statusCode);
//       }
//     });
//     return articles;
//   }

//   Future<ListData> getEverything(String keyword, int page) async {
//     String cacheKey = '$keyword-$page';
//     if (_cache.containsKey(cacheKey)) {
//       return _cache[cacheKey]!;
//     }

//     ListData articles = ListData([], 0, false);
//     await ApiService().getEverything(keyword, page).then((response) {
//       if (response.statusCode == 200) {
//         Iterable data = jsonDecode(response.body)['articles'];
//         articles = ListData(
//           data.map((e) => News.fromJson(e)).toList(),
//           jsonDecode(response.body)['totalResults'],
//           true,
//         );
//         _cache[cacheKey] = articles;
//       } else {
//         Fluttertoast.showToast(
//           msg: jsonDecode(response.body)['message'],
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 1,
//           backgroundColor: AppColors.lighterGray,
//           textColor: AppColors.black,
//           fontSize: 16.0,
//         );
//         throw Exception(response.statusCode);
//       }
//     });
//     return articles;
//   }
// }

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/common/colors.dart';
import 'package:news_app/models/listdata_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/Api.dart';

class NewsProvider {
  Map<String, ListData> _cache = {};

  Future<ListData> getTopHeadlines({String category = '', int page = 1, int pageSize = 20}) async {
    String cacheKey = 'topHeadlines-$category-$page';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    ListData articles = ListData([], 0, false);
    await ApiService().getTopHeadlines(category: category, page: page, pageSize: pageSize).then((response) {
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body)['articles'];
        articles = ListData(
          data.map((e) => News.fromJson(e)).toList(),
          jsonDecode(response.body)['totalResults'],
          true,
        );
        _cache[cacheKey] = articles;
      } else {
        Fluttertoast.showToast(
          msg: jsonDecode(response.body)['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.lighterGray,
          textColor: AppColors.black,
          fontSize: 16.0,
        );
        throw Exception(response.statusCode);
      }
    });
    return articles;
  }

  Future<ListData> getEverything(String keyword, int page, {int pageSize = 20}) async {
    String cacheKey = '$keyword-$page';
    if (_cache.containsKey(cacheKey)) {
      return _cache[cacheKey]!;
    }

    ListData articles = ListData([], 0, false);
    await ApiService().getEverything(keyword, page, pageSize: pageSize).then((response) {
      if (response.statusCode == 200) {
        Iterable data = jsonDecode(response.body)['articles'];
        articles = ListData(
          data.map((e) => News.fromJson(e)).toList(),
          jsonDecode(response.body)['totalResults'],
          true,
        );
        _cache[cacheKey] = articles;
      } else {
        Fluttertoast.showToast(
          msg: jsonDecode(response.body)['message'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.lighterGray,
          textColor: AppColors.black,
          fontSize: 16.0,
        );
        throw Exception(response.statusCode);
      }
    });
    return articles;
  }
}