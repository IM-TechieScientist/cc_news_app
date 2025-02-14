import 'package:flutter/material.dart';
import 'package:news_app/models/listdata_model.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/news_info/news_info.dart';
import 'package:news_app/common/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<News> _searchResults = [];
  bool _isLoading = false;

  Future<void> _searchArticles(String keyword) async {
    setState(() {
      _isLoading = true;
    });

    ListData listData = await NewsProvider().searchArticles(keyword, 1);
    if (listData.status) {
      setState(() {
        _searchResults = listData.data as List<News>;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _searchArticles(value);
            }
          },
        ),
        backgroundColor: AppColors.tertiary,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                News article = _searchResults[index];
                return ListTile(
                  title: Text(
                    article.title ?? 'No Title',
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    article.description ?? '',
                    style: GoogleFonts.poppins(
                      color: textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsInfo(news: article),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}