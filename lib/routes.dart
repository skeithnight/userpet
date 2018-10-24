import 'package:flutter/material.dart';
import 'package:userpet/screens/main_screen.dart';
import 'package:userpet/screens/login_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/main':         (BuildContext context) => new MainScreen(),
  '/' :          (BuildContext context) => new MainScreen(),
};