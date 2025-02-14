import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:news_app/common/colors.dart';
import 'package:news_app/common/common.dart';
import 'package:news_app/common/widgets/no_connectivity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/listdata_model.dart';
import 'package:news_app/models/news_model.dart' as m;
import 'package:news_app/providers/news_provider.dart';
import 'package:news_app/screens/home/widgets/CategoryItem.dart';
import 'package:news_app/screens/home/widgets/newsCard.dart';
import 'package:provider/provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/screens/home/search_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  int activeCategory = 0;
  int page = 1;
  bool isFinish = false;
  bool data = false;
  List<m.News> articles = [];

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    if (await getInternetStatus()) {
      getNewsData();
    } else {
      Navigator.of(context, rootNavigator: true,)
          .push(
            MaterialPageRoute(
              builder: (context) => const NoConnectivity(),
            ),
          )
          .then(
            (value) => checkConnectivity(),
          );
    }
  }

  Future<bool> getNewsData() async {
    ListData listData = await NewsProvider()
        .getTopHeadlines(category: categories[activeCategory], page: page++);

    if (listData.status) {
      List<m.News> items = listData.data as List<m.News>;
      data = true;

      if (mounted) {
        setState(() {});
      }

      if (items.length == listData.totalContent) {
        isFinish = true;
      }

      if (items.isNotEmpty) {
        articles.addAll(items);
        setState(() {});
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void onCategoryClick(int index) {
    setState(() {
      activeCategory = index;
      articles = [];
      page = 1;
      isFinish = false;
      data = false;
    });
    getNewsData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Text(
                "News",
                style: GoogleFonts.poppins(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                ),
          ),
        ),
        backgroundColor: AppColors.tertiary,
        elevation: 5,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: AppColors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
             icon: Icon(Icons.search, color: AppColors.white),
             onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: size.width,
            child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) => CategoryItem(
                index: index,
                categoryName: categories[index],
                activeCategory: activeCategory,
                onClick: (int index) => onCategoryClick(index),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: LoadMore(
              isFinish: isFinish,
              onLoadMore: getNewsData,
              whenEmptyLoad: true,
              delegate: const DefaultLoadMoreDelegate(),
              textBuilder: DefaultLoadMoreTextBuilder.english,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) =>
                    NewsCard(article: articles[index]),
              ),
            ),
          )
        ],
      ),
    );
  }
}