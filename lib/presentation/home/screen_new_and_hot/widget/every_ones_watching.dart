import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bro/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_bro/core/constants.dart';
import 'package:netflix_bro/presentation/home/screen_new_and_hot/widget/custom_button_widget.dart';

class EveryOnesWatching extends StatelessWidget {
  const EveryOnesWatching({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInEveryOnesWatching());
    } );
      return RefreshIndicator(
        onRefresh: () async{
          BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInEveryOnesWatching());
        },
        child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
          builder: (context, state) {
            if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
          } else if (state.hasError) {
        return const Center(
          child: Text('Error While Loading Coming Soon list'),
        );
          } else if (state.everyOnesWatching.isEmpty) {
        return const Center(
          child: Text('Coming Soon list is empty'),
        );
          } else {
            return ListView.builder(
              itemCount: state.everyOnesWatching.length,
              itemBuilder: (context, index) {
                 final tv = state.everyOnesWatching[index];
                    if(tv.id == null){
                      return const SizedBox();
                    }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    khight,
                    Text(
                      tv.originalName ?? 'No Name',
                      style:const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    khight,
                    Text(
                      tv.overview ?? 'No Description',
                      style:const  TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 50),
                    Stack(
                      children: [
                        Image.network(
                          '$imageAppendUrl${tv.posterPath}',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          loadingBuilder: (_, child,ImageChunkEvent? loadingProgress) {
                            if(loadingProgress == null){
                              return child;
                            }else{
                              return const Center(child: CircularProgressIndicator(strokeWidth: 2),);
                            }
                          },
                          errorBuilder: (_, error,StackTrace? stackTrace) {
                            return const Center(child: Icon(Icons.wifi,size: 50,color: Colors.grey,),);
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.black.withOpacity(0.5),
                            radius: 22,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.volume_off,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    khight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        CustomButtonWidget(
                          icon: Icons.share,
                          title: "share",
                          iconSize: 25,
                          textSize: 16,
                        ),
                        kwidth,
                        CustomButtonWidget(
                          icon: Icons.add,
                          title: "My List",
                          iconSize: 25,
                          textSize: 16,
                        ),
                        kwidth,
                        CustomButtonWidget(
                          icon: Icons.play_arrow,
                          title: "Play",
                          iconSize: 25,
                          textSize: 16,
                        ),
                        kwidth,
                      ],
                    ),
                  ],
                );
              },
            );
          }
          }
        ),
      );
    }
  }

