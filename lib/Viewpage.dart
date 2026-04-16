import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chesmistry.dart';
import 'physics.dart';
import 'biology.dart';
import 'math.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> with TickerProviderStateMixin {

  final Color boxColor = const Color(0xFFF5F7FB);
  final Color softText = const Color(0xFF132E35);
  final Color borderColor = const Color(0xFF132E35);
  final Color primaryDark = const Color(0xFF132E35);

  late AnimationController _slideController;
  late Animation<Offset> _slideH;
  late Animation<Offset> _slideI;
  late Animation<Offset> _slideEx;

  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideH = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.0, 0.33, curve: Curves.easeOut),
    ));

    _slideI = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.33, 0.66, curve: Curves.easeOut),
    ));

    _slideEx = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: const Interval(0.66, 1.0, curve: Curves.easeOut),
    ));

    _slideController.forward();

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _bounceAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _bounceController,
        curve: Curves.easeInOut,
      ),
    );

    _bounceController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          children: [

            // Top Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90,
                color: primaryDark,
              ),
            ),

            // Animated Hi
            Positioned(
              top: 100,
              left: 60,
              child: Row(
                children: [
                  SlideTransition(
                    position: _slideH,
                    child: Text("H",
                        style: GoogleFonts.pacifico(
                            color: primaryDark, fontSize: 85)),
                  ),
                  SlideTransition(
                    position: _slideI,
                    child: Text("i",
                        style: GoogleFonts.pacifico(
                            color: primaryDark, fontSize: 85)),
                  ),
                  SlideTransition(
                    position: _slideEx,
                    child: Text("!",
                        style: GoogleFonts.pacifico(
                            color: primaryDark, fontSize: 80)),
                  ),
                ],
              ),
            ),

            // Animated Picture (ani.png) Top-Right
            Positioned(
              top: 100,
              left: 250,
              child: ScaleTransition(
                scale: _bounceAnimation,
                child: Image.asset(
                  "assets/images/ani.png",
                  height: 120,
                ),
              ),
            ),

            // Question Box
            Positioned(
              top: 240,
              left: 30,
              right: 30,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: borderColor, width: 2),
                ),
                child: Center(
                  child: Text(
                    "What do you want to learn?",
                    style: GoogleFonts.pacifico(
                        color: primaryDark, fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // Subjects Title
            Positioned(
              top: 450,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Subjects:",
                  style: TextStyle(
                      color: primaryDark,
                      fontSize: 34,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // SUBJECT BUTTONS WITH ICONS

            Positioned(
              top: 520,
              left: 45,
              child: subjectButton(
                  "assets/images/Biology.png", "Biology", const biology()),
            ),

            Positioned(
              top: 520,
              left: 240,
              child:
              subjectButton("assets/images/Math.png", "Math", const MathPage()),
            ),

            Positioned(
              top: 700,
              left: 45,
              child: subjectButton("assets/images/7614875.png",
                  "Chemistry", const ChemistryPage()),
            ),

            Positioned(
              top: 700,
              left: 240,
              child: subjectButton(
                  "assets/images/physics.png", "Physics", const Physics()),
            ),
          ],
        ),
      ),
    );
  }

  Widget subjectButton(String imagePath, String text, Widget page) {
    return _HoverSubjectButton(
      imagePath: imagePath,
      text: text,
      page: page,
      boxColor: boxColor,
      borderColor: borderColor,
      primaryDark: primaryDark,
    );
  }

}

class _HoverSubjectButton extends StatefulWidget {
  final String imagePath;
  final String text;
  final Widget page;
  final Color boxColor;
  final Color borderColor;
  final Color primaryDark;

  const _HoverSubjectButton({
    required this.imagePath,
    required this.text,
    required this.page,
    required this.boxColor,
    required this.borderColor,
    required this.primaryDark,
  });

  @override
  State<_HoverSubjectButton> createState() =>
      _HoverSubjectButtonState();
}

class _HoverSubjectButtonState extends State<_HoverSubjectButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovering = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.page),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 120,
          height: 140,
          decoration: BoxDecoration(
            color: isHovering
                ? widget.boxColor.withOpacity(0.7)
                : widget.boxColor,
            border: Border.all(color: widget.borderColor, width: 2),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isHovering ? 0.2 : 0.1),
                blurRadius: isHovering ? 15 : 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.imagePath,
                  height: 50, width: 50, fit: BoxFit.contain),
              const SizedBox(height: 10),
              Text(
                widget.text,
                style: TextStyle(
                  color: widget.primaryDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
