import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Physics extends StatefulWidget {
  const Physics({super.key});

  @override
  State<Physics> createState() => PhysicsState();
}

class PhysicsState extends State<Physics>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _animations;

  final List<String> topics = [
    "Mechanics",
    "Electromagnetism",
    "Optics",
    "Thermodynamics",
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animations = List.generate(topics.length, (index) {
      final double start = index * 0.1;
      final double end = (start + 0.5).clamp(0.0, 1.0);

      return Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Physics"),
        backgroundColor: const Color(0xFF132E35),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.bolt, color: Colors.white),
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB2DFDB),
              Color(0xFFE0F7FA),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Physics Topics",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 30),

                /// Animated Buttons
                ...List.generate(topics.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SlideTransition(
                      position: _animations[index],
                      child: PhysicsButton(title: topics[index]),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PhysicsButton extends StatefulWidget {
  final String title;

  const PhysicsButton({super.key, required this.title});

  @override
  State<PhysicsButton> createState() => _PhysicsButtonState();
}

class _PhysicsButtonState extends State<PhysicsButton> {
  bool isHovering = false;
  bool isPressed = false;

  /*Future<void> _launchURL() async {
    final Uri url = Uri.parse('https://drive.google.com/file/d/18Hzw3aFmrdSgGlKuukWrx7uW3zwaPwR8/view?usp=drive_link');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),

      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) => setState(() => isPressed = false),
        onTapCancel: () => setState(() => isPressed = false),

        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BlankPage(title: widget.title),
            ),
          );
          //await _launchURL();
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,

          height: 80,
          width: double.infinity,

          transform: Matrix4.identity()
            ..scale(isPressed ? 0.97 : (isHovering ? 1.03 : 1.0)),

          decoration: BoxDecoration(
            color: isHovering
                ? Colors.teal.shade700   // ✅ strong visible hover color
                : Colors.white,

            borderRadius: BorderRadius.circular(20),

            border: Border.all(
              color: isHovering
                  ? Colors.tealAccent
                  : Colors.transparent,
              width: 2,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  isHovering ? 0.35 : 0.1,
                ),
                blurRadius: isHovering ? 25 : 8,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Center(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isHovering ? Colors.white : Colors.teal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Blank Page
class BlankPage extends StatelessWidget {
  final String title;

  const BlankPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF132E35),
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(Icons.bolt, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Welcome to $title",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
