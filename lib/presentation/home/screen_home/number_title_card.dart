import 'package:flutter/material.dart';
import 'package:netflix_bro/core/constants.dart';
import 'package:netflix_bro/presentation/home/screen_home/number_card.dart';
import 'package:netflix_bro/presentation/widgets/main_title_card.dart';


class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key, required this.posterList,
  }) : super(key: key);
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(
          title: "Top 10 TV Shows in India Today",
        ),
        khight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
              (index) => NumberCard(
                index: index,
                imageUrl: posterList[index],
              ),
            ),
          ),
        )
      ],
    );
  }
}
