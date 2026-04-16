import 'package:flutter/material.dart';

class ChemistryPage extends StatefulWidget {
  const ChemistryPage({super.key});

  @override
  State<ChemistryPage> createState() => ChemistryPageState();
}

class ChemistryPageState extends State<ChemistryPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _animations;

  final List<String> topics = [
    "Organic Chemistry",
    "Inorganic Chemistry",
    "Physical Chemistry",
    "Analytical Chemistry",
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
        title: const Text("Chemistry"),
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
            child: Icon(Icons.science, color: Colors.white),
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
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Chemistry Topics",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 30),

                /// Animated clickable boxes
                ...List.generate(topics.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SlideTransition(
                      position: _animations[index],
                      child: ChemistryBox(title: topics[index]),
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

class ChemistryBox extends StatefulWidget {
  final String title;

  const ChemistryBox({super.key, required this.title});

  @override
  State<ChemistryBox> createState() => _ChemistryBoxState();
}

class _ChemistryBoxState extends State<ChemistryBox> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChemistryBlankPage(title: widget.title),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isHovering
                ? const Color(0xFF004D40)
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isHovering ? Colors.tealAccent : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withOpacity(isHovering ? 0.35 : 0.1),
                blurRadius: isHovering ? 20 : 8,
                offset: const Offset(0, 5),
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

class ChemistryBlankPage extends StatelessWidget {
  final String title;

  const ChemistryBlankPage({super.key, required this.title});

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
            child: Icon(Icons.science, color: Colors.white),
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
