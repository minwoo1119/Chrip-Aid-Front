import 'package:flutter/material.dart';

class CustomDetailInfo extends StatelessWidget {
  final String name;
  final String email;
  final String phoneNumber;
  final String nickname;
  final String age;
  final String sex;
  final String region;

  const CustomDetailInfo({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.nickname,
    required this.age,
    required this.sex,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Image(
                     image: AssetImage('./assets/image/logo.png'),
                     height: 100,
                     width: 100,
                   ),
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text('이름  ${name}'),
                       Text('아이디 ${email}'),
                       Text('별명 ${nickname}'),
                     ],
                   )
                 ],
               )
             ],
           ),
           Column(
             children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text('나이 ${age}'),
                   Text('성별 ${sex}'),
                 ],
               )
             ],
           ),
           Column(
             children: [
               Text('전화번호 ${phoneNumber}'),
             ],
           ),
           Column(
             children: [
               Text('지역 ${region}'),
             ],
           ),
           Column(
             children: [
               Text('활동 내역'),
             ],
           ),
        ],
      ),
    );
  }
}
