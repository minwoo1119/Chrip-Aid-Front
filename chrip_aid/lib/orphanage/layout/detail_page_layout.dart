import 'package:flutter/material.dart';

class DetailPageLayout extends StatelessWidget {
  final String? title;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget child;

  const DetailPageLayout({
    Key? key,
    this.title,
    this.backgroundColor = Colors.white,
    this.bottomNavigationBar,
    this.floatingActionButton,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: child,
      ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? _appBar(BuildContext context) => title == null
      ? null
      : AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            title!,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          foregroundColor: Colors.black,
        );
}
