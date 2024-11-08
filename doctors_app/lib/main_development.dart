import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'core/services/service_locator.dart';
import 'doc_app.dart';

void main() async {

  await ScreenUtil.ensureScreenSize();

  setupServiceLocator();
  runApp(const DocApp());
}


