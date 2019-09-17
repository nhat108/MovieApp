import 'package:flutter/material.dart';

class NuxBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<NuxBottomBarItem> items;
  final ValueChanged<int> onItemSelected;

  NuxBottomNavigationBar(
      {Key key,
      this.selectedIndex = 0,
      this.showElevation = true,
      this.iconSize = 24,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 270),
      @required this.items,
      @required this.onItemSelected}) {
    assert(items != null);
    assert(items.length >= 2 && items.length <= 5);
    assert(onItemSelected != null);
  }
  Widget _buildItem(NuxBottomBarItem item, bool isSelected) {
    return AnimatedContainer(
      width: isSelected ? 130 : 50,
      height: double.maxFinite,
      duration: animationDuration,
      padding: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconTheme(
                  data: IconThemeData(
                      size: iconSize,
                      color: isSelected
                          ? item.activeColor.withOpacity(1)
                          : item.inactiveColor == null
                              ? item.activeColor
                              : item.inactiveColor),
                  child: item.icon,
                ),
              ),
              isSelected
                  ? DefaultTextStyle.merge(
                      style: TextStyle(
                          color: item.activeColor, fontWeight: FontWeight.bold),
                      child: item.title)
                  : SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;
    return Container(
      decoration: BoxDecoration(color: bgColor, boxShadow: [
        if (showElevation) BoxShadow(color: Colors.black12, blurRadius: 2)
      ]),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: 56,
          padding: EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () {
                  onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class NuxBottomBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  NuxBottomBarItem(
      {this.icon, this.title, this.activeColor, this.inactiveColor});
}
