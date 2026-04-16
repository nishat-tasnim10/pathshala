import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AlgebraNotesPage.dart';
import 'PomodoroPage.dart';

class AppColors {
  static const bg = Colors.white;
  static const darkTeal = Color(0xFF132E35);
  static const midTeal = Color(0xFF1F4B4F);
  static const peach = Color(0xFFFED7A5);
}

class _Feature {
  final String label;
  final IconData icon;
  final Color bg, fg;
  final Widget page;
  final GlobalKey key;

  const _Feature(
      this.label,
      this.icon,
      this.bg,
      this.fg,
      this.page,
      this.key,
      );
}

final _features = [
  _Feature('Courses', Icons.menu_book_rounded, Color(0xFF132E35),
      Colors.white, AlgebraNotesPage(), GlobalKey()),
  _Feature('Quiz', Icons.quiz_rounded, Color(0xFF1F4B4F),
      Colors.white, PomodoroPage(), GlobalKey()),
  _Feature('Pomodoro', Icons.timer_rounded, Color(0xFF132E35),
      Colors.white, PomodoroPage(), GlobalKey()),
  _Feature('Progress', Icons.bar_chart_rounded, Color(0xFF1F4B4F),
      Colors.white, PomodoroPage(), GlobalKey()),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigate(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      appBar: AppBar(
        backgroundColor: AppColors.darkTeal,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(
            color: AppColors.peach,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),

            const SliverToBoxAdapter(child: SizedBox(height: 10)),

            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: Center(child: MovingBoyOnPencil()),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 100)),

            SliverToBoxAdapter(child: _buildSectionLabel(" Features")),

            SliverToBoxAdapter(child: _buildFeatureGrid()),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 40, 24, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back!",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.darkTeal,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Let’s start learning------",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: AppColors.darkTeal,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- LABEL ---------------
  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.darkTeal,
          fontSize: 15,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
  Widget _buildFeatureGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 👈 perfect symmetry
        children: _features.map((f) {
          return GestureDetector(
            onTap: () => _navigate(f.page),
            child: Column(
              children: [
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        f.bg,
                        Color.lerp(f.bg, Colors.black, 0.2)!,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: f.bg.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(f.icon, color: f.fg, size: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  f.label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.darkTeal,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

}
class MovingBoyOnPencil extends StatefulWidget {
  const MovingBoyOnPencil({super.key});

  @override
  State<MovingBoyOnPencil> createState() => _MovingBoyOnPencilState();
}

class _MovingBoyOnPencilState extends State<MovingBoyOnPencil>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxX = constraints.maxWidth -70; // image width buffer

        return Stack(
          children: [
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Positioned(
                  left: animation.value * maxX,
                  top: 10,
                  child: child!,
                );
              },
              child: Image.asset(
                "assets/images/homeboy.png",
                width: 400,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}