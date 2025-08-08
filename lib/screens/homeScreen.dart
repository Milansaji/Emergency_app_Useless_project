import 'package:emergency/screens/veenaScreen.dart';
import 'package:emergency/widgets/callAction.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isalertclicked = false;
  bool alertlogo = true;
  final AudioPlayer _emergencyPlayer = AudioPlayer();

  @override
  void dispose() {
    _emergencyPlayer.dispose();
    super.dispose();
  }

  Future<void> _playEmergencyTone() async {
    await _emergencyPlayer.setReleaseMode(ReleaseMode.loop);
    await _emergencyPlayer.play(AssetSource('music/Ring.mp3'));
  }

  Future<void> _stopEmergencyTone() async {
    await _emergencyPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: alertlogo
          ? AppBar(
              foregroundColor: Colors.red,
              title: Text(
                'Emergency',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF7A2018),
              centerTitle: true,
            )
          : null,
      backgroundColor: const Color(0xFFF8F9FA),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isalertclicked
            ? _buildEmergencyUI(context)
            : _buildNormalUI(context),
      ),
    );
  }

  Widget _buildNormalUI(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Choose the type of emergency and tap the siren to initiate a call.",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // Dropdown
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Visibility(
              visible: alertlogo,
              child: DropdownMenu<String>(
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                      value: 'Option 1', label: "🚑 Medical Emergency"),
                  DropdownMenuEntry(
                      value: 'Option 2', label: "🔥 Fire Emergency"),
                  DropdownMenuEntry(
                      value: 'Option 3', label: "🚔 Police Emergency"),
                ],
                initialSelection: "Option 1",
                enabled: true,
                textStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                menuStyle: MenuStyle(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.white.withOpacity(0.95)),
                  elevation: WidgetStateProperty.all(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Siren Button
          InkWell(
            borderRadius: BorderRadius.circular(100),
            splashColor: Colors.red.withOpacity(0.3),
            onTap: () async {
              await Future.delayed(const Duration(milliseconds: 300));

              setState(() {
                isalertclicked = true;
                alertlogo = false;
              });

              // Play emergency tone
              _playEmergencyTone();

              // Show emergency UI for 5 seconds
              await Future.delayed(const Duration(seconds: 5));

              _stopEmergencyTone();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Veenascreen()),
              );

              setState(() {
                isalertclicked = false;
                alertlogo = true;
              });
            },
            child: Visibility(
              visible: alertlogo,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/img/siren.png",
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),

          const SizedBox(height: 50),

          // Tips Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  "⚠️ Emergency Tips",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                  ),
                ),
                const SizedBox(height: 10),
                _buildTip("Stay calm and speak clearly when calling."),
                _buildTip("Provide your exact location immediately."),
                _buildTip("Follow operator instructions carefully."),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyUI(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFF7A2018),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'EMERGENCY CALL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '100',
              style: TextStyle(
                color: Colors.white,
                fontSize: 96,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Calling...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: const [
                Callaction(icon: Icons.call, label: "Call"),
                Callaction(icon: Icons.dialpad, label: 'Keypad'),
                Callaction(icon: Icons.volume_up, label: 'Audio'),
                Callaction(icon: Icons.add, label: 'Add call'),
                Callaction(icon: Icons.videocam, label: 'FaceTime'),
                Callaction(icon: Icons.person_outline, label: 'Contact'),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
              ),
              onPressed: () {
                _stopEmergencyTone();
                setState(() {
                  isalertclicked = false;
                  alertlogo = true;
                });
              },
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
                size: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
