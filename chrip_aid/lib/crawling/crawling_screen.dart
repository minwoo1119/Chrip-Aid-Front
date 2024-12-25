import 'package:chrip_aid/common/styles/colors.dart';
import 'package:chrip_aid/common/styles/sizes.dart';
import 'package:chrip_aid/orphanage/layout/detail_page_layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Product {
  final String title;
  final int price;
  final String image;
  final String link;

  Product({required this.title, required this.price, required this.image, required this.link});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      price: json['price'],
      image: json['image'],
      link: json['link'],
    );
  }
}

class CrawlingScreen extends StatefulWidget {
  const CrawlingScreen({Key? key}) : super(key: key);

  @override
  State<CrawlingScreen> createState() => _CrawlingScreenState();
}

class _CrawlingScreenState extends State<CrawlingScreen> {
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    final serverUrl = dotenv.env['IP'];
    final response = await _dio.get('$serverUrl/requests/products');
    List data = response.data;
    return data.map((json) => Product.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DetailPageLayout(
      extendBodyBehindAppBar: false,
      title: 'Requests',
      titleColor: Colors.white,
      appBarBackgroundColor: CustomColor.buttonMainColor,
      backgroundColor: CustomColor.backgroundMainColor,
      leadingColor: CustomColor.textReverseColor,
      actions: [

      ],
      child: Container(),
    );
  }
}
