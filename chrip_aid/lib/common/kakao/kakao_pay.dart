import 'dart:convert';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future kakaoPayReady(String itemName, int itemQuantity, int totalAmount) async {
  var url = 'https://kapi.kakao.com/v1/payment/ready';
  var res = await http.post(Uri.parse(url), headers: {
    "Authorization": "KakaoAK ${dotenv.get('KAKAO_ADMIN_KEY')}",
    "Content-type": "application/x-www-form-urlencoded;charset=utf-8"
  }, body: {
    "cid": "TC0ONETIME",
    "partner_order_id": "partner_order_id",
    "partner_user_id": "partner_user_id",
    "item_name": itemName,
    "quantity": itemQuantity.toString(),
    "total_amount": totalAmount.toString(),
    "vat_amount": "0",
    "tax_free_amount": "0",
    "approval_url": "https://developers.kakao.com/success",
    "fail_url": "https://developers.kakao.com/fail",
    "cancel_url": "https://developers.kakao.com/cancel"
  });
  Map<String, dynamic> result = jsonDecode(utf8.decode(res.bodyBytes));
  AndroidIntent intent = AndroidIntent(
    action: 'action_view',
    data: result["next_redirect_mobile_url"],
    arguments: {'txn_id': result['tid']},
  );
  await intent.launch();
}
