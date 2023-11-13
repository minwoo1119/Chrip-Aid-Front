import 'dart:io';

import 'package:aws_s3_upload/aws_s3_upload.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void initAWS() {
  HttpOverrides.global = MyHttpOverrides();
}

Future<String?> uploadFileToS3(File file, AwsS3Dir dir) async {
  return await AwsS3.uploadFile(
    accessKey: dotenv.get("AWS_ACCESS_KEY"),
    secretKey: dotenv.get("AWS_SECRET_KEY"),
    bucket: dotenv.get("AWS_S3_BUCKET_NAME"),
    region: dotenv.get("AWS_REGION"),
    file: file,
    destDir: dir.toString(),
    filename: "${DateTime.now().toString()}.${file.path.split(".").last}",
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

enum AwsS3Dir {
  orphanage,
  post,
  product,
  user;

  @override
  String toString() => name;
}