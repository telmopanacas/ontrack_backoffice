import 'package:flutter/material.dart';
import 'package:ontrack_backoffice/controllers/controllers.dart';
import 'package:ontrack_backoffice/routing/router.dart';
import 'package:ontrack_backoffice/routing/routes.dart';

Navigator localNavigator() => Navigator(
  key: navigationController.navigatorKey,
  initialRoute: HomePageRoute,
  onGenerateRoute: generateRoute,
);

