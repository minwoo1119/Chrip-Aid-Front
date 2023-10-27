import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailPageLayout extends StatelessWidget {
  final String? title;
  final Color? appBarBackgroundColor;
  final Color backgroundColor;
  final Color? leadingColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? bottom;
  final Widget child;

  const DetailPageLayout({
    Key? key,
    this.title,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.floatingActionButton,
    required this.child,
    this.leadingColor,
    this.bottom,
    this.appBarBackgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? _appBar(BuildContext context) => AppBar(
        centerTitle: true,
        backgroundColor: appBarBackgroundColor,
        elevation: 0,
        title: title == null
            ? null
            : Text(
                title!,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: leadingColor),
          onPressed: context.pop,
        ),
        foregroundColor: Colors.black,
        bottom: bottom,
      );
}
