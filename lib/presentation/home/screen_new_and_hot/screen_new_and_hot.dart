import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_bro/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_bro/core/constants.dart';
import 'package:netflix_bro/presentation/home/screen_new_and_hot/widget/coming_soon.dart';

import 'widget/every_ones_watching.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              "Hot & New",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
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
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              tabs: const [
                Tab(
                  text: "🍿 Coming Soon",
                ),
                Tab(
                  text: "👀 Everyones Watching",
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ComingSoonList(key: Key('coming soon'),),
            EveryOnesWatching(key: Key('everyones watching'),),
          ],
        ),
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    } );
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
           if(state.isLoading){
                return const Center(child: CircularProgressIndicator(strokeWidth: 2,),);
              }else if(state.hasError){
                return const Center(child:Text('Error While Loading Coming Soon list'),);
              }else if(state.comingSoonList.isEmpty){
                return const Center(child:Text('Coming Soon list is empty'),);
              }else{
                return ListView.separated(
                  separatorBuilder: (context, index) =>const SizedBox(height: 5),
                  itemCount: state.comingSoonList.length, 
                  itemBuilder: (context, index){
                    final movie = state.comingSoonList[index];
                    if(movie.id == null){
                      return const SizedBox();
                    }
    
                    final date = DateTime.parse(movie.releaseDate!);
                    final formattedDate = DateFormat.yMMMMd('en_US').format(date);
                    return Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: ComingSoon(
                        id: movie.id.toString(),
                        month: formattedDate.split(' ').first.substring(0, 3).toUpperCase(),
                        day: movie.releaseDate!.split('-')[1],
                        posterPath: '$imageAppendUrl${movie.posterPath}',
                        movieName: movie.originalTitle ?? 'No Title',
                        description: movie.overview ?? 'No Discription',
            ),
                    );
            } 
          );
        }
      
      },
      ),
    );
}
}
        
   