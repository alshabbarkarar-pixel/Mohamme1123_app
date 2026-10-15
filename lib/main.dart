import 'package:flutter/material.dart';

void main() {
  runApp(const IrrigationPumpApp());
}

class IrrigationPumpApp extends StatelessWidget {
  const IrrigationPumpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام إدارة مضخات الري',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        fontFamily: 'Cairo',
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  bool isPumpRunning = false;
  bool isAutoMode = true;
  double soilMoisture = 42.0; // نسبة مئوية
  double waterPressure = 2.4; // بار
  int timerMinutes = 30;

  void togglePump(bool value) {
    setState(() {
      isPumpRunning = value;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isPumpRunning ? 'تم تشغيل مضخة الري بنجاح' : 'تم إيقاف مضخة الري',
          style: const TextStyle(fontSize: 16),
        ),
        backgroundColor: isPumpRunning ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة مضخة الري الزراعية'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // بطاقة حالة المضخة الرئيسية
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      isPumpRunning ? Icons.water_drop : Icons.water_drop_outlined,
                      size: 80,
                      color: isPumpRunning ? Colors.blue : Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isPumpRunning ? 'المضخة تعمل الآن' : 'المضخة متوقفة',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isPumpRunning ? Colors.green[800] : Colors.red[800],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Transform.scale(
                      scale: 1.5,
                      child: Switch(
                        value: isPumpRunning,
                        onChanged: togglePump,
                        activeColor: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // القراءات والمؤشرات
            Row(
              children: [
                Expanded(
                  child: _buildSensorCard(
                    title: 'رطوبة التربة',
                    value: '${soilMoisture.toInt()}%',
                    icon: Icons.grass,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildSensorCard(
                    title: 'ضغط الماء',
                    value: '$waterPressure بار',
                    icon: Icons.speed,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // التحكم في الوضع
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.settings_suggest, color: Colors.green[700]),
                title: const Text('الري الأوتوماتيكي الذكي', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('التشغيل التلقائي عند جفاف التربة'),
                trailing: Switch(
                  value: isAutoMode,
                  onChanged: (val) {
                    setState(() {
                      isAutoMode = val;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
