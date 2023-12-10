import 'package:flutter/material.dart';
import 'package:incubation_odyssey/game/main_game.dart';

class InstructionsScreen extends StatelessWidget {
  final MainGame game;
  static const String id = 'instructions';

  const InstructionsScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Material(
      color: Colors.black.withOpacity(0.8), // Dark background
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Stack(
            children: [
              const SizedBox(height: 100,),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeading('🌌 Welcome to the Incubation Odyssey! 🚀'),
                    _buildText(
                        'Welcome, brave adventurer, to the mystical realm of Aetherion, a gas giant of wonders and mysteries that stretches across the cosmos. But this isn\'t just any journey—it\'s an odyssey with an egg, and not just any egg! 🥚✨'),
                    _buildHeading('🎮 How to Play!'),
                    _buildText('''
                    🅩 Use the 'Z' key to jump.
                    🅧 Use the 'X' key to dash.
                    '''),
                    _buildHeading('🎈 Embark on a Whimsical Journey!'),
                    _buildText(
                        'You find yourself suspended high above the swirling clouds in a whimsical hot air balloon, your precious cargo cradled in a delicate nest.'),
                    _buildHeading(
                        '💡 Mission Overview: Guide the Egg with Care!'),
                    _buildText(
                        'Your mission is clear: guide the egg through the ever-changing skies of Aetherion, collecting ethereal snowflakes to cool it down or blazing hot coals to warm it up. The fate of your hatchling rests upon your ability to navigate this fantastical world and manage the delicate balance of temperature.'),
                    _buildHeading(
                        '☁️ Explore the Enchanting Skies of Aetherion!'),
                    _buildText(
                        'As you float among the clouds, the gas giant\'s vibrant colors and mesmerizing storms surround you. Be vigilant, for the skies are filled with challenges and wonders alike.'),
                    _buildHeading(
                        '❄️🔥 Temperature Management: The Key to Success!'),
                    _buildText(
                        'Will your egg hatch into a delightful, waddling penguin, gracefully sliding on icy slopes? Or will it transform into a fierce, fiery dragon, ready to breathe molten fire upon your foes? The choices are as vast as the cosmos itself.'),
                    _buildHeading('🌟 Epic Choices Await!'),
                    _buildText(
                        'So, embark on this enchanting journey, adjust the temperature of your egg with skill and precision, and unveil the mysteries that lie within the cosmic egg as you soar through the skies of Aetherion!'),
                    _buildHeading('🔮 The Fate of Your Hatchling Awaits!'),
                    _buildText(
                        'The fate of your hatchling is in your hands, adventurer—may your journey be as epic as the gas giant that cradles you in its celestial embrace. Safe travels through the magical cosmos of Aetherion! 🚀🌌'),
                    _buildText('''
                    Happy adventuring! 🌟
                    ''')
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_circle_left_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                    onPressed: onClose,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 32,
          color: Colors.yellow,
          fontFamily: 'SinglyLinked',
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontFamily: 'SinglyLinked',
        ),
      ),
    );
  }

  void onClose() {
    game.overlays.remove(id);
  }
}
