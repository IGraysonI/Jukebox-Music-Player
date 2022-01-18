import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];

  @override
  void initState() {
    fuckingAsyncTask();
    super.initState();
  }

  void fuckingAsyncTask() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traks list'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(songs[index].title!),
          );
        },
      ),
    );
  }
}
