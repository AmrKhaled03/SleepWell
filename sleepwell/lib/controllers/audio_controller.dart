import 'package:audio_session/audio_session.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioController extends GetxController with WidgetsBindingObserver {
  late final AudioPlayer player;
  bool isMusicPlaying = true;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    initAudio();
  }

  Future<void> initAudio() async {
    player = AudioPlayer();

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());

    await player.setReleaseMode(ReleaseMode.loop);

    final prefs = await SharedPreferences.getInstance();
    isMusicPlaying = prefs.getBool('isMusicPlaying') ?? true;

    if (isMusicPlaying) {
      await player.play(AssetSource('music/sleep-music-vol16-195422.mp3'));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final prefs = await SharedPreferences.getInstance();
    isMusicPlaying = prefs.getBool('isMusicPlaying') ?? true;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      player.pause();
    } else if (state == AppLifecycleState.resumed) {
      if (isMusicPlaying) {
        player.resume();
      }
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose();
    super.onClose();
  }

  Future<void> toggleMusic() async {
    final prefs = await SharedPreferences.getInstance();

    if (player.state == PlayerState.playing) {
      await player.pause();
      isMusicPlaying = false;
    } else {
      await player.resume();
      isMusicPlaying = true;
    }

    await prefs.setBool('isMusicPlaying', isMusicPlaying);
    update();
  }

Future<void> resumeMusic() async {
  final prefs = await SharedPreferences.getInstance();
  isMusicPlaying = prefs.getBool('isMusicPlaying') ?? true;
  debugPrint("ResumeMusic called - isMusicPlaying: $isMusicPlaying, playerState: ${player.state}");

  if (isMusicPlaying && player.state != PlayerState.playing) {
    await player.resume();
    debugPrint("Music resumed!");
  } else {
    debugPrint("Music not resumed.");
  }
}
}
