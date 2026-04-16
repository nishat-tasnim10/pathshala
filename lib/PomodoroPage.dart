import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pathshala/LoginPage.dart';


const Color kDeepTeal    = Color(0xFF132E35);
const Color kPeach       = Color(0xFFFED7A5);
const Color kSlate       = Color(0xFF9BA8AB);
const Color kMedTeal     = Color(0xFF1F4B4F);

enum SessionType{
  focus,
  shortBreak,
  longBreak;
}
extension SessionInfo on SessionType {
  int get totalSeconds {
    switch (this) {
      case SessionType.focus:
        return 25 ; // 25 minutes
      case SessionType.shortBreak:
        return 5 ; // 5 minutes
      case SessionType.longBreak:
        return 15 ; // 15 minutes
    }
  }

  String get label {
    switch (this) {
      case SessionType.focus:
        return 'Focus';
      case SessionType.shortBreak:
        return 'Short Break';
      case SessionType.longBreak:
        return 'Long Break';
    }
  }
}
Color getaccentColor(SessionType type){
  if(type==SessionType.focus){
    return kPeach;
  }
  else if(type==SessionType.shortBreak){
    return kSlate;
  }
  else
  {
    return const Color(0xFF7ECAC8) ;
  }
}
class _RingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  const _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    canvas.drawCircle(center, radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,

    );
    if (progress > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -pi / 2,
        2 * pi * progress,
        false,
        Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) {
    return old.progress != progress || old.progressColor != progressColor;
  }
}

class IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color color;
  final double size;
  const IconBtn({required this.icon,required this.onTap,required this.color,required this.size});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(width: size,
        height: size,
        decoration:  const BoxDecoration(shape: BoxShape.circle,color: kMedTeal, ),
        child: Icon(icon,color: color,size: size*.46),
      ),
    );
  }

}

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});


  @override
  State<PomodoroPage> createState() => _PomodoroPageState();






}

class _PomodoroPageState extends State<PomodoroPage> with TickerProviderStateMixin {
  SessionType _session = SessionType.focus;
  int _pomodorosCompleted = 0;
  int _remaining = SessionType.focus.totalSeconds;
  Timer?_timer;
  bool running = false;
  late AnimationController pulseCtrl;
  late Animation<double>pulseAni;
  late AnimationController ringCtrl;


  @override
  void initState() {
    super.initState();
    pulseCtrl = AnimationController(vsync: this,
      duration: const Duration(seconds: 2),)
      ..repeat(reverse: true);
    _remaining = _session.totalSeconds;
    pulseAni = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: pulseCtrl, curve: Curves.easeInOut),);
    ringCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _timer?.cancel();
    pulseCtrl.dispose();
    ringCtrl.dispose();
    super.dispose();
  }

  void startPause() {
    if (running) {
      _timer?.cancel();
      pulseCtrl.stop();
      setState(() => running = false);
    }
    else {
      pulseCtrl.repeat(reverse: true);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_remaining <= 0) {
          return onSessionComplete();
        } else {
          setState(() => _remaining --);
        }
      });
      setState(() => running = true);
    }
  }

  void onSessionComplete(){
    _timer?.cancel();
    pulseCtrl.stop();
    setState(() {
      running=false;
      if(_session== SessionType.focus)
        _pomodorosCompleted++;

    });
    sessionCompletedSnack();
  }

  void reset(){
    _timer?.cancel();
    pulseCtrl.stop();
    setState(() {
      running=false;
      _remaining=_session.totalSeconds;
    });
  }
  void _switchSession(SessionType type) {
    _timer?.cancel();
    pulseCtrl.stop();
    setState(() {
      _session = type;
      _remaining = type.totalSeconds;
      running = false;
    });
  }

  void sessionCompletedSnack(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar( content: Text(_session==SessionType.focus?'Focus Completed!'
          :'Break over!',style:const TextStyle(color:kPeach,fontWeight: FontWeight.bold)),
        backgroundColor: kMedTeal,behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
  String get _timeLabel{
    final m=_remaining~/60;
    final s = _remaining % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
  double get _progress => 1.0 - (_remaining / _session.totalSeconds);

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: kMedTeal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: kPeach,
                size: 22,
              ),
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            'pomodoro',
            style: TextStyle(
              color: kPeach,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

          const Spacer(),

          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: kMedTeal,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$_pomodorosCompleted',
              style: const TextStyle(
                color: kPeach,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSessionTabs(Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: kMedTeal,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: SessionType.values.map((type) {
            final selected = _session == type;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  _switchSession(type);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? accent : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    type.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selected ? kDeepTeal : kSlate,
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildRing(Color accent) {
    return ScaleTransition(
      scale: running ? pulseAni : const AlwaysStoppedAnimation(1.0),
      child: SizedBox(
        width: 260,
        height: 260,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background glow
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: running
                    ? [
                  BoxShadow(
                    color: accent.withOpacity(0.18),
                    blurRadius: 48,
                    spreadRadius: 12,
                  )
                ]
                    : [],
              ),
            ),
            // Progress ring
            CustomPaint(
              size: const Size(260, 260),
              painter: _RingPainter(
                progress: _progress,
                trackColor: kMedTeal,
                progressColor: accent,
                strokeWidth: 12,
              ),
            ),
            // Inner circle
            Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kMedTeal,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            ),
            // Time display
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _timeLabel,
                  style: TextStyle(
                    color: accent,
                    fontSize: 52,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -2,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _session.label.toUpperCase(),
                  style: TextStyle(
                    color: kSlate,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2.5,
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildControls(Color accent) {
    return Padding(padding:  const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconBtn(icon:Icons.refresh_rounded,onTap:reset,color:kSlate,
              size:48),
          const SizedBox(width: 24,),
          GestureDetector(
            onTap: startPause,
            child: AnimatedContainer(duration:  const Duration(milliseconds: 200),
              width: 72,height: 72,
              decoration: BoxDecoration(shape: BoxShape.circle,
                color: accent,
                boxShadow:[ BoxShadow(color: accent.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
                ],
              ),
              child: Icon(running?Icons.pause_rounded : Icons.play_arrow_rounded,color: kDeepTeal,size: 36,),
            ),
          ),
          const SizedBox(width: 24),
          IconBtn(icon: Icons.skip_next_sharp, onTap: onSessionComplete, color: kSlate, size: 48),
        ],
      ),

    );


  }








  @override
  Widget build(BuildContext context) {
    final Color accent = getaccentColor(_session);
    return Scaffold(
      backgroundColor:Color(0xFF0A1E23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:[
              Color(0xFF0A1E23),
              //Color(0xFF1F4B4F),
              Color(0xFF0A1E23),
              Color(0xFF132E35),
              // Color(0xFF9BA8AB),
              Color(0xFF132E35),
              // Color(0xFFFED7A5),

              Color(0xFF1F4B4F), //
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 8),
              buildSessionTabs(accent),
              const Spacer(),
              _buildRing(accent),
              const Spacer(),
              _buildControls(accent),
              const SizedBox(height: 8),

            ],
          ),
        ),
      ),




    );
  }


}