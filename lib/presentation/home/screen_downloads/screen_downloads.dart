import 'dart:core';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bro/application/downloads/downloads_bloc.dart';
import 'package:netflix_bro/core/constants.dart';
import 'package:netflix_bro/presentation/widgets/appbar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  const ScreenDownloads({Key? key}) : super(key: key);
  // final _widgetList = [
  //   const _SmartDownloads(),
  //   const Section2(),
  //   const Section3(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarWidget(
              title: 'Downloads',
            )),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: const [
            _SmartDownloads(),
            SizedBox(height: 20),
            Section2(),
            SizedBox(height: 20),
            Section3(),
          ],
          // itemBuilder: ((context, index) => _widgetList[index]),
          //separatorBuilder: ((context, index) => const SizedBox(
          //height: 20,
          //)),
          //itemCount: _widgetList.length),
        ));
  }
}

class Section2 extends StatelessWidget {
  const Section2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    BlocProvider.of<DownloadsBloc>(context)
        .add(const DownloadsEvent.getDownloadsImages());

    return Column(
      children: [
        const Text(
          "Introdusing Downloads for you",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        khight,
        const Text(
          "We will download a personalised selection\nof movies and shows for you,so there's\nalways somthings to watch on your\ndevice",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        khight,
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            return SizedBox(
                width: size.width,
                height: 350,
                child: Stack(
                  alignment: Alignment.center, 
                  children: [
                          
                  CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    radius: size.width * 0.4,
                  ),
                   state.isLoading
                   ? const Center(child:  CircularProgressIndicator())
                   :
                  DownloadsImageWidget(
                    imageList:
                        '$imageAppendUrl${state.downloads[1].posterPath}',
                    margin: const EdgeInsets.only(left: 170, bottom: 50),
                    angle: 20,
                    size: Size(size.width * 0.3, size.height * 0.35),
                    radius: 15,
                  ),
                  DownloadsImageWidget(
                    imageList:
                        '$imageAppendUrl${state.downloads[2].posterPath}',
                    margin: const EdgeInsets.only(
                      right: 170,
                      bottom: 50,
                    ),
                    angle: -20,
                    size: Size(size.width * 0.3, size.height * 0.35),
                    radius: 20,
                  ),
                  DownloadsImageWidget(
                    imageList:
                        '$imageAppendUrl${state.downloads[3].posterPath}',
                    margin: const EdgeInsets.only(
                      left: 0,
                      bottom: 15,
                    ),
                    size: Size(size.width * 0.45, size.height * 0.40),
                    radius: 15,
                  ),
                ]));
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Colors.blueAccent[700],
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Set Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        khight,
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Colors.white,
          onPressed: () {},
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'See what you can download',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
        Text("Smart Download")
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget(
      {Key? key,
      required this.imageList,
      this.angle = 0,
      required this.margin,
      required this.size,
      this.radius = 10})
      : super(key: key);

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          margin: margin,
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageList),
          )),
        ),
      ),
    );
  }
}
