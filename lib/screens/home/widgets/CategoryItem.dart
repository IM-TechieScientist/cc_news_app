import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/common/colors.dart';

class CategoryItem extends StatefulWidget {
  final String categoryName;
  final int index;
  final int activeCategory;
  final Function(int) onClick;

  const CategoryItem({
    super.key,
    required this.categoryName,
    required this.index,
    required this.activeCategory,
    required this.onClick,
  });

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDarkMode ? Colors.white : AppColors.black;
    final inactiveColor = isDarkMode ? Colors.grey : AppColors.lighterBlack;

    return GestureDetector(
      onTap: () {
        print("Clicked on: ${widget.categoryName} (Index: ${widget.index})");
        widget.onClick(widget.index);
      },
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.activeCategory == widget.index ? activeColor : inactiveColor,
            width: widget.activeCategory == widget.index ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        margin: const EdgeInsets.only(
          left: 5,
          right: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            widget.categoryName[0].toUpperCase().toString() +
                widget.categoryName.substring(1).toString(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: widget.activeCategory == widget.index ? activeColor : inactiveColor,
                fontWeight: widget.activeCategory == widget.index ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}