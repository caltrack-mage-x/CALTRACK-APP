import 'dart:async';
import 'package:flutter/material.dart';

enum CountdownType { daily, weekly, achievement }

class ChallengeTimer extends StatefulWidget {
  final CountdownType countdownType;
  final int currentMilestone;
  final int totalMilestones;

  ChallengeTimer({
    required this.countdownType,
    this.currentMilestone = 0,
    this.totalMilestones = 40,
  });

  @override
  _ChallengeTimerState createState() => _ChallengeTimerState();
}

class _ChallengeTimerState extends State<ChallengeTimer> {
  late Timer _timer;
  Duration _remainingTime = Duration();

  @override
  void initState() {
    super.initState();
    if (widget.countdownType != CountdownType.achievement) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    if (widget.countdownType != CountdownType.achievement) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _startTimer() {
    _updateRemainingTime();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _updateRemainingTime();
    });
  }

  void _updateRemainingTime() {
    final now = DateTime.now();
    DateTime endTime;

    if (widget.countdownType == CountdownType.daily) {
      endTime = DateTime(now.year, now.month, now.day + 1);
    } else {
      endTime = DateTime(now.year, now.month, now.day + (7 - now.weekday)); // Next Sunday
    }

    setState(() {
      _remainingTime = endTime.difference(now);
    });
  }

  String _formatDuration(Duration duration) {
    // Format the remaining time as Day:Hour:Minutes:Seconds for weekly countdown
    if (widget.countdownType == CountdownType.weekly) {
      String days = duration.inDays.toString();
      String hours = (duration.inHours % 24).toString().padLeft(2, "0");
      String minutes = (duration.inMinutes % 60).toString().padLeft(2, "0");
      String seconds = (duration.inSeconds % 60).toString().padLeft(2, "0");
      return "$days:$hours:$minutes:$seconds";
    } else {
      // Format as HH:mm:ss for daily countdown
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String hours = twoDigits(duration.inHours);
      String minutes = twoDigits(duration.inMinutes.remainder(60));
      String seconds = twoDigits(duration.inSeconds.remainder(60));
      return "$hours:$minutes:$seconds";
    }
  }

  @override
  Widget build(BuildContext context) {
    // If the countdown type is achievement, show the milestone UI
    if (widget.countdownType == CountdownType.achievement) {
      return _buildAchievementMilestone();
    }

    // Otherwise, show the countdown timer
    return _buildCountdownTimer();
  }

  Widget _buildCountdownTimer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7643), Color(0xFFFF516B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Time Left:',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            _formatDuration(_remainingTime),
            style: TextStyle(
              fontSize: 42,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementMilestone() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7643), Color(0xFFFF516B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Milestone:',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${widget.currentMilestone} / ${widget.totalMilestones}',
            style: TextStyle(
              fontSize: 42,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
