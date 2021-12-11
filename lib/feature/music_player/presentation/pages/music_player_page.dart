import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/feature/music_player/presentation/bloc/music_bloc.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({Key? key}) : super(key: key);

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      var str = controller.text;
      context.read<MusicBloc>().add(MusicSearched(str));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
        ),
      ),
      body: BlocBuilder<MusicBloc, MusicState>(
        builder: (context, state) {
          var listMusic = state.listMusic;
          if (listMusic.isNotEmpty) {
            return ListView.builder(
                itemCount: listMusic.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var item = listMusic[index];
                  return Container(
                    height: 100,
                    alignment: Alignment.center,
                    child: Text(item.trackName),
                  );
                });
          } else {
            return Container(
              color: Colors.red,
            );
          }
        },
      ),
    );
  }
}
