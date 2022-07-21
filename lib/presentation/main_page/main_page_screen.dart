import 'package:flutter/material.dart';
import 'package:netflix_bro/presentation/home/screen_downloads/screen_downloads.dart';
import 'package:netflix_bro/presentation/home/screen_fast_laugh/screen_fast_laugh.dart';
import 'package:netflix_bro/presentation/home/screen_home/screen_home.dart';
import 'package:netflix_bro/presentation/home/screen_new_and_hot/screen_new_and_hot.dart';
import 'package:netflix_bro/presentation/home/screen_search/screen_search.dart';
import 'package:netflix_bro/presentation/main_page/widgets/bottom_navigation.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({Key? key}) : super(key: key);

  final _pages = [
    const ScreenHome(),
    const ScreenNewAndHot(),
    const ScreenFastLaugh(),
    ScreenSearch(),
    const ScreenDownloads(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, _) {
            return _pages[index];
          },
        ),
        bottomNavigationBar: const BottomNavigationWidgets(),
      ),
    );
  }
}
