import 'package:flutter/material.dart';
import 'package:netflix_bro/core/constants.dart';
import 'package:netflix_bro/presentation/widgets/main_image_card.dart';
import 'package:netflix_bro/presentation/widgets/main_title_card.dart';

class MainTitleCard extends StatelessWidget {
  const MainTitleCard({Key? key, required this.title, required this.posterList}) : super(key: key);
  final String title;
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(
          title: title,
        ),
        khight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
              (index) =>  MainImageCard(
                imageUrl: posterList[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
