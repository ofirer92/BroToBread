import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

enum TimerType { making, baking }

// Models
class BreadTimer {
  final String stage;
  int durationMinutes;
  DateTime? startTime;
  Timer? timer;
  bool isRunning = false;
  int remainingSeconds = 0;
  List<int>? foldTimes;
  int completedFolds = 0;
  final String description;
  final IconData icon;

  BreadTimer({
    required this.stage,
    required this.durationMinutes,
    this.foldTimes,
    required this.description,
    required this.icon,
  });

  void reset() {
    timer?.cancel();
    isRunning = false;
    remainingSeconds = 0;
    completedFolds = 0;
    startTime = null;
  }
}

class TimerPage extends StatefulWidget {
  final TimerType timerType;
  
  const TimerPage({
    Key? key,
    required this.timerType,
  }) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late List<BreadTimer> timers;

  @override
  void initState() {
    super.initState();
    _initializeTimers();
  }

  @override
  void dispose() {
    for (var timer in timers) {
      timer.timer?.cancel();
    }
    super.dispose();
  }

  void _initializeTimers() {
    if (widget.timerType == TimerType.making) {
      timers = [
        BreadTimer(
          stage: 'אוטוליזה',
          durationMinutes: 30,
          description: 'ערבוב קמח ומים, מנוחה לשיפור התפתחות הבצק',
          icon: Icons.water_drop,
        ),
        BreadTimer(
          stage: 'ערבוב',
          durationMinutes: 15,
          description: 'הוספת מלח ומחמצת לבצק',
          icon: Icons.sync,
        ),
        BreadTimer(
          stage: 'תסיסה ראשונית',
          durationMinutes: 240,
          foldTimes: [20, 40, 60],
          description: 'תסיסה עיקרית עם קיפולים תקופתיים',
          icon: Icons.bakery_dining,
        ),
      ];
    } else {
      timers = [
        BreadTimer(
          stage: 'אפייה עם מכסה',
          durationMinutes: 20,
          description: 'אפייה בטמפרטורה גבוהה עם מכסה סיר',
          icon: Icons.local_fire_department,
        ),
        BreadTimer(
          stage: 'אפייה ללא מכסה',
          durationMinutes: 20,
          description: 'אפייה להשחמת הקרום העליון',
          icon: Icons.brightness_high,
        ),
      ];
    }
  }

  void _startTimer(BreadTimer timer) {
    if (timer.isRunning) return;

    setState(() {
      timer.startTime = DateTime.now();
      timer.remainingSeconds = timer.durationMinutes * 60;
      timer.isRunning = true;
      timer.completedFolds = 0;
    });

    timer.timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timer.remainingSeconds > 0) {
          timer.remainingSeconds--;
          
          if (timer.stage == 'תסיסה ראשונית' && 
              timer.foldTimes != null &&
              timer.completedFolds < timer.foldTimes!.length) {
            
            int elapsedMinutes = (timer.durationMinutes * 60 - timer.remainingSeconds) ~/ 60;
            
            if (elapsedMinutes == timer.foldTimes![timer.completedFolds]) {
              _showStretchAndFoldDialog(timer.completedFolds + 1);
              timer.completedFolds++;
            }
          }
        } else {
          _showCompletionDialog(timer);
          _stopTimer(timer);
        }
      });
    });
  }

  void _stopTimer(BreadTimer timer) {
    setState(() {
      timer.reset();
    });
  }

  void _showStretchAndFoldDialog(int foldNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(Icons.gesture, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Text('קיפול ומתיחה #$foldNumber'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('הגיע הזמן לקיפול ומתיחה מספר $foldNumber!'),
            const SizedBox(height: 12),
            const Text(
              '1. הרטב את הידיים\n'
              '2. מתח בעדינות צד אחד של הבצק\n'
              '3. קפל למרכז\n'
              '4. סובב את הקערה 90 מעלות\n'
              '5. חזור על התהליך 4 פעמים',
              style: TextStyle(color: Colors.grey),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('סיום'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.start,
      ),
    );
  }

  void _showCompletionDialog(BreadTimer timer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(timer.icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 12),
            Text('${timer.stage} הושלם'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('שלב ${timer.stage} הושלם.'),
            const SizedBox(height: 12),
            if (timer.stage == 'תסיסה ראשונית')
              const Text(
                'הבצק שלך מוכן לעיצוב.\n'
                'חפש את הסימנים הבאים להתססה נכונה:\n'
                '• הבצק גדל בנפח\n'
                '• פני השטח קמורים\n'
                '• בועות נראות בצדדים ובחלק העליון',
                style: TextStyle(color: Colors.grey),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('אישור'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.start,
      ),
    );
  }

  void _editTimerSettings(BreadTimer timer) {
    if (timer.isRunning) return;

    final durationController = TextEditingController(
      text: timer.durationMinutes.toString()
    );
    
    final foldsController = TextEditingController(
      text: timer.foldTimes?.length.toString() ?? '3'
    );
    
    final intervalController = TextEditingController(
      text: timer.foldTimes != null && timer.foldTimes!.isNotEmpty 
        ? (timer.foldTimes![0]).toString() 
        : '20'
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('עריכת טיימר ${timer.stage}'),
        content: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: durationController,
                  decoration: InputDecoration(
                    labelText: 'משך זמן (דקות)',
                    helperText: 'זמן כולל עבור ${timer.stage}',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                if (timer.stage == 'תסיסה ראשונית') ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: foldsController,
                    decoration: const InputDecoration(
                      labelText: 'מספר קיפולים',
                      helperText: 'כמה קיפולים לבצע',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: intervalController,
                    decoration: const InputDecoration(
                      labelText: 'דקות בין קיפולים',
                      helperText: 'זמן בין כל קיפול',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('ביטול'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final newDuration = int.tryParse(durationController.text);
                if (newDuration != null && newDuration > 0) {
                  timer.durationMinutes = newDuration;
                }

                if (timer.stage == 'תסיסה ראשונית') {
                  final folds = int.tryParse(foldsController.text) ?? 3;
                  final interval = int.tryParse(intervalController.text) ?? 20;
                  
                  if (folds > 0) {
                    timer.foldTimes = List.generate(
                      folds,
                      (index) => interval * (index + 1),
                    );
                  }
                }
              });
              Navigator.of(context).pop();
            },
            child: const Text('שמור'),
          ),
        ],
        actionsAlignment: MainAxisAlignment.start,
      ),
    );
  }

 Widget _buildTimerCard(BreadTimer timer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header with title, description, and icons
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  if (!timer.isRunning)
                    IconButton(
                      icon: const Icon(Icons.settings_outlined),
                      onPressed: () => _editTimerSettings(timer),
                      tooltip: 'ערוך הגדרות טיימר',
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            timer.stage,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          Text(
                            timer.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(timer.icon),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Folds information
            if (timer.stage == 'תסיסה ראשונית' && timer.foldTimes != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'קיפולים מתוכננים: ${timer.foldTimes!.length}',
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
              ),
            
            // Progress bar
            LinearProgressIndicator(
              value: timer.isRunning
                  ? 1 - (timer.remainingSeconds / (timer.durationMinutes * 60))
                  : 0,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Timer controls
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (timer.isRunning) {
                        _stopTimer(timer);
                      } else {
                        _startTimer(timer);
                      }
                    },
                    icon: Icon(timer.isRunning ? Icons.stop : Icons.play_arrow),
                    label: Text(timer.isRunning ? 'עצור' : 'התחל'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: timer.isRunning ? Colors.red : null,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        timer.isRunning
                            ? _formatTime(timer.remainingSeconds)
                            : _formatTime(timer.durationMinutes * 60),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      if (timer.isRunning && 
                          timer.stage == 'תסיסה ראשונית' &&
                          timer.completedFolds < (timer.foldTimes?.length ?? 0) &&
                          _getNextFoldTime(timer) > 0)  // Only show if there's time remaining
                        Text(
                          'קיפול הבא בעוד: ${_formatTime(_getNextFoldTime(timer))}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.left,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
             '${minutes.toString().padLeft(2, '0')}:'
             '${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:'
           '${secs.toString().padLeft(2, '0')}';
  }

int _getNextFoldTime(BreadTimer timer) {
    if (!timer.isRunning || timer.foldTimes == null || 
        timer.completedFolds >= timer.foldTimes!.length) {
      return 0;
    }

    int elapsedMinutes = (timer.durationMinutes * 60 - timer.remainingSeconds) ~/ 60;
    int nextFoldMinute = timer.foldTimes![timer.completedFolds];
    
    // Calculate remaining minutes and seconds until next fold
    int remainingMinutes = nextFoldMinute - elapsedMinutes;
    int remainingSeconds = remainingMinutes * 60 - 
        ((timer.durationMinutes * 60 - timer.remainingSeconds) % 60);
    
    return remainingSeconds > 0 ? remainingSeconds : 0;
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.timerType == TimerType.making ? 'טיימר הכנה' : 'טיימר אפייה'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withRed(100),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: timers.length,
          itemBuilder: (context, index) => _buildTimerCard(timers[index]),
        ),
      ),
    );
  }
}