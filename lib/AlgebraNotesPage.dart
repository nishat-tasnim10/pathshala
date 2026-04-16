import 'package:flutter/material.dart';


class AppColors {
  static const bg       = Color(0xFF0C2128);
  static const darkTeal = Color(0xFF132E35);
  static const midTeal  = Color(0xFF1F4B4F);
  static const peach    = Color(0xFFFED7A5);
  static const grayBlue = Color(0xFF9BA8AB);
}


class AlgebraNotesPage extends StatefulWidget {
  const AlgebraNotesPage({super.key});

  @override
  State<AlgebraNotesPage> createState() => _AlgebraNotesPageState();
}

class _AlgebraNotesPageState extends State<AlgebraNotesPage> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;


  final List<String> images = [
    "assets/images/algebra_part1.png",
    "assets/images/algebra_part2.png",
    "assets/images/algebra_part3.png",
    "assets/images/algebra_part4.png",
    "assets/images/algebra_part5.png",


  ];


  final double _imageHeight = 320;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      int page = (offset / _imageHeight).round() + 1;
      if (page != _currentPage && page <= images.length) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.peach),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notes',
          style: TextStyle(
            color: AppColors.peach,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: AppColors.midTeal, height: 1),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.grayBlue,
              AppColors.grayBlue,
              AppColors.midTeal,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [


              ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      NoteImage(images[index]),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),

              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.darkTeal.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$_currentPage/${images.length}',
                      style: const TextStyle(
                        color: AppColors.peach,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class NoteImage extends StatelessWidget {
  final String imagePath;

  const NoteImage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}