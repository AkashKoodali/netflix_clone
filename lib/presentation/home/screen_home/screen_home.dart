import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bro/application/home/home_bloc.dart';
import 'package:netflix_bro/core/constants.dart';
import 'package:netflix_bro/presentation/home/screen_home/background_card.dart';
import 'package:netflix_bro/presentation/home/screen_home/number_title_card.dart';
import 'package:netflix_bro/presentation/widgets/main_title.dart';

ValueNotifier<bool> scrolNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
      },
    );
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrolNotifier,
        builder: (BuildContext context, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              
              if (direction == ScrollDirection.reverse) {
                scrolNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrolNotifier.value = true;
              }
              return true;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.hasError) {
                      return const Center(
                        child: Text(
                          "Error while Getting Data",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }


                    final releasedPastYear = state.pastYearMovieList.map((m){
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    final trending = state.trendingMovieList.map((m){
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    final tenseDrama = state.trendsDramaMovieList.map((m){
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    final southIndian = state.southIndianMovieList.map((m){
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    southIndian.shuffle();

                    final top10TvList = state.trendsDramaMovieList.map((t){
                      return '$imageAppendUrl${t.posterPath}';
                    }).toList();
                    top10TvList.shuffle();


                    return ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                       const BackgroundCard(),

                       if(releasedPastYear.length>=10)
                        MainTitleCard(
                          title: "Released in the past year",
                          posterList: releasedPastYear.sublist(0, 10),
                        ),
                        khight,

                        if(trending.length>=10)
                         MainTitleCard(
                          title: "Trending now",
                          posterList: trending,
                        ),
                        khight,
                        NumberTitleCard(
                          posterList: top10TvList,
                        ),
                        khight,

                        if(tenseDrama.length>=10)
                        MainTitleCard(
                          title: "Tense Dramas",
                          posterList: tenseDrama,
                        ),
                        khight,

                        if(southIndian.length>=10)
                        MainTitleCard(
                          title: "South Indian Cinema",
                          posterList: southIndian,
                        ),
                      ],
                    );
                  },
                ),
                scrolNotifier.value == true
                    ? AnimatedContainer(
                        duration: const Duration(microseconds: 1000),
                        width: double.infinity,
                        height: 100,
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5ROwzchebXONmV03zqF-dvfBgmeHRaowXuQ&usqp=CAU",
                                  width: 90,
                                  height: 50,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                kwidth,
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                kwidth
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Text(
                                  "Tv Shows",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Movies",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Categories",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : khight,
              ],
            ),
          );
        },
      ),
    );
  }
}
