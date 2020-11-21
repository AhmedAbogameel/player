import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../constants.dart';

class PlayerDialog extends StatefulWidget {
  @override
  _PlayerDialogState createState() => _PlayerDialogState();
}

class _PlayerDialogState extends State<PlayerDialog> {
  double sliderValue = 0.0;
  Duration playerDuration;
  double speed = 1;
  var player = AudioPlayer();
  bool isPlaying = false;
  @override
  void initState() {
    initialAudio();
    super.initState();
  }

  void initialAudio() async {
    playerDuration = await player.setAsset('assets/clip.wav');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: sizeFromHeight(context, 1),
        width: sizeFromWidth(context, 1.2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(icon: Icon(Icons.save), onPressed: () {}),
                      IconButton(
                          icon: Icon(Icons.download_sharp), onPressed: () {}),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.volume_up_outlined),
                          onPressed: () {}),
                    ],
                  ),
                  Image.network(
                      'https://st2.depositphotos.com/3474805/7901/v/950/depositphotos_79017550-stock-illustration-detailed-mosque-contour.jpg'),
                  Text('قل هو الله احد'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('3/10/2020'),
                      Icon(Icons.calendar_today_outlined),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(icon: Icon(Icons.swipe), onPressed: (){}),
                      IconButton(
                          icon: Icon(Icons.skip_previous_outlined),
                          onPressed: () {
                            int value = sliderValue.toInt();
                            if (value >= 10) {
                              value -= 10;
                              player.seek(Duration(seconds: value));
                            }
                          }),
                      IconButton(
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          onPressed: () async {
                            setState(() => isPlaying = !isPlaying);
                            player.getPositionStream().listen((event) {
                              setState(()=> sliderValue = event.inSeconds.toDouble());
                            });
                            !isPlaying
                                ? await player.pause()
                                : await player.play();
                            setState(() {
                              isPlaying = !isPlaying;
                              speed = 1;
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.skip_next_rounded),
                          onPressed: () {
                            int value = sliderValue.toInt();
                            if (value < playerDuration.inSeconds - 10) {
                              value += 10;
                              player.seek(Duration(seconds: value));
                            }
                          },
                      ),
                      IconButton(
                        icon: Text('x$speed'),
                        onPressed: () {
                          setState(() => speed++);
                          player.setSpeed(speed);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sliderValue
                          .toStringAsFixed(2)
                          .replaceAll('.', ':')
                          .padLeft(5, '0')),
                      Text(playerDuration != null
                          ? double.parse(playerDuration.inSeconds.toString())
                              .toStringAsFixed(2)
                              .replaceAll('.', ':')
                              .padLeft(5, '0')
                          : '00:00'),
                    ],
                  ),
                  Slider(
                      value: sliderValue,
                      min: 0.0,
                      max: playerDuration != null ? playerDuration.inSeconds.toDouble() : 0,
                      onChanged: (double value) {
                        player.seek(Duration(seconds: value.toInt()));
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}