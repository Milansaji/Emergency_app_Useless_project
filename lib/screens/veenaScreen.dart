import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Veenascreen extends StatefulWidget {
  const Veenascreen({super.key});

  @override
  State<Veenascreen> createState() => _VeenascreenState();
}

class _VeenascreenState extends State<Veenascreen>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _playMusic();

    // Animation for music dots
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  Future<void> _playMusic() async {
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('music/AUD-20250808-WA0017.mp3'));
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildMusicDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: _animationController,
            curve: Interval(index * 0.1, 1.0, curve: Curves.easeInOut),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 8,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            Text(
              "Don't Panic! ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red[900],
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "listen to music and take immediate action",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // Center Image
            Center(
              child: Image.asset(
                "assets/img/IMG_7035.PNG",
                width: 250,
                height: 250,
              ),
            ),

            const SizedBox(height: 30),

            // Music Dots Animation
            _buildMusicDots(),

            const SizedBox(height: 50),

            // Stop Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.stop, color: Colors.white),
              label: const Text(
                "Stop Alert",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
