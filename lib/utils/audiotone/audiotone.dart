import 'package:just_audio/just_audio.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final AudioPlayer _player = AudioPlayer();

  Future<void> playPaymentSuccess() async {
    try {
      await _player.stop(); // Stop any previous playback
      await _player.setAsset('assets/tones/payment.mp3');
      await _player.play();
    } catch (e) {
      // print('Audio playback error: $e');
      // Optional: handle error (e.g., show a message)
    }
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}
