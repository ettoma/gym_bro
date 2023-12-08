import 'package:flutter/material.dart';

class PageNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print("pushed route");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print("popped route");
  }
}
