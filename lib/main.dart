import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_bro/application/downloads/downloads_bloc.dart';
import 'package:netflix_bro/application/fast_laugh/fastlaugh_bloc.dart';
import 'package:netflix_bro/application/home/home_bloc.dart';
import 'package:netflix_bro/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_bro/core/colors/colors.dart';
import 'package:netflix_bro/domain/core/di/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/search/search_bloc.dart';
import 'presentation/main_page/main_page_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<DownloadsBloc>()),
        BlocProvider(create: (context) => getIt<SearchBloc>()),
        BlocProvider(create: (context) => getIt<FastlaughBloc>()),
        BlocProvider(create: (context) => getIt<HotAndNewBloc>()),
        BlocProvider(create: (context) => getIt<HomeBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Netflix UI',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          primarySwatch: Colors.blue,
          backgroundColor: backgroundColor,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          ),
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        home: ScreenMainPage(),
      ),
    );
  }
}
