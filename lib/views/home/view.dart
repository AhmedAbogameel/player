import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quraan_player/views/home/dialog.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool showPlayerDialog = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChange Called!');
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(),
          body: Center(
            child: RaisedButton(
              child: Text('Play'),
              onPressed: () {
                print('a');
                setState(() => showPlayerDialog = !showPlayerDialog);
              },
            ),
          ),
        ),
        if (showPlayerDialog)
          GestureDetector(
            child: Container(color: Colors.black38),
            onTap: () => setState(() => showPlayerDialog = false),
          ),
        if (showPlayerDialog) PlayerDialog()
      ],
    );
  }
}
