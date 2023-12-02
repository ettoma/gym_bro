import 'package:flutter/material.dart';
import 'package:gym_bro/global/text.dart';

import '../widgets/app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar(
      pageTitle: PageNames.profile,
    ));
  }
}
