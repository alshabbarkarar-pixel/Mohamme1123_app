import 'package:flutter/material.dart';

void main() {
  runApp(const IrrigationManagementApp());
}

class IrrigationManagementApp extends StatelessWidget {
  const IrrigationManagementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام إدارة مضخات الري',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1E7D32),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. شاشة البداية (Splash Screen)
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E7D32),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.water_drop, size: 80, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'نظام إدارة مضخات الري',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. التنقل الرئيسي
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const RaayaScreen(),
    const ExpensesScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E7D32),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'الرعية'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المصروفات'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'التقارير'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'الإعدادات'),
        ],
      ),
    );
  }
}

// 3. لوحة التحكم
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        backgroundColor: const Color(0xFF1E7D32),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('إحصائيات اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: const [
                StatCard(title: 'إيرادات اليوم', value: '0 ر.ي', icon: Icons.attach_money, color: Colors.green),
                StatCard(title: 'سقايات اليوم', value: '0', icon: Icons.waves, color: Colors.blue),
                StatCard(title: 'الديزل المستهلك اليوم', value: '0.0 لتر', icon: Icons.local_gas_station, color: Colors.orange),
                StatCard(title: 'مخزون الديزل', value: '0.0 لتر', icon: Icons.inventory_2, color: Colors.teal),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NewIrrigationScreen()));
              },
              icon: const Icon(Icons.add),
              label: const Text('سقاية جديدة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E7D32),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({Key? key, required this.title, required this.value, required this.icon, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// 4. شاشة سقاية جديدة ومعاينة الرسائل
class NewIrrigationScreen extends StatelessWidget {
  const NewIrrigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سقاية ري جديدة'),
        backgroundColor: const Color(0xFF1E7D32),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'اختر الرعوي', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'ساعات التشغيل / الوقت', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'المبلغ المدفوع الآن', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E7D32)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('معاينة رسالة الرعوي'),
                    content: const Text(
                      '🌾 سقاية ري جديدة\n\n'
                      '👤 الرعوي: mohammed\n'
                      '📅 التاريخ: 12/10/2026\n'
                      '⏰ من 1:30 ص إلى 5:30 ص\n'
                      '⏱️ إجمالي ساعات الري: 4 ساعات\n\n'
                      '💰 حساب المبلغ:\n'
                      'الرصيد السابق: عليكم 625,000 ر.ي\n'
                      'تكلفة السقاية: +10,000 ر.ي\n'
                      'المدفوع الآن: -200,000 ر.ي\n'
                      'الرصيد الحالي: عليكم 435,000 ر.ي\n\n'
                      '⛽ حساب الديزل:\n'
                      'الرصيد السابق: عليكم 410.0 لتر\n'
                      'المسلم: +500.0 لتر\n'
                      'المستهلك: -20.0 لتر (4 ساعة)\n'
                      'الرصيد الحالي: لكم 70.0 لتر\n\n'
                      'شكراً لتعاملكم معنا 🙏',
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('إغلاق')),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم حفظ السقاية وإرسال الرسالة بنجاح')),
                          );
                        },
                        child: const Text('حفظ وإرسال عبر واتساب'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('حفظ العملية ومعاينة الرسالة'),
            ),
          ],
        ),
      ),
    );
  }
}

class RaayaScreen extends StatelessWidget {
  const RaayaScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('الرعية'), backgroundColor: const Color(0xFF1E7D32)), body: const Center(child: Text('قائمة الرعية')));
}

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('المصروفات'), backgroundColor: const Color(0xFF1E7D32)), body: const Center(child: Text('إدارة المصروفات والتصنيفات')));
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التقارير'), backgroundColor: const Color(0xFF1E7D32)),
      body: ListView(
        children: const [
          ListTile(title: Text('تقرير المديونيات'), leading: Icon(Icons.warning, color: Colors.red)),
          ListTile(title: Text('تقرير قائمة الرعية'), leading: Icon(Icons.people, color: Colors.blue)),
          ListTile(title: Text('التقرير المالي الشامل'), leading: Icon(Icons.account_balance, color: Colors.green)),
          ListTile(title: Text('تقرير نشاط السقايات'), leading: Icon(Icons.water, color: Colors.lightBlue)),
          ListTile(title: Text('تقرير حالة زيت المضخة'), leading: Icon(Icons.oil_barrel, color: Colors.purple)),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: const Color(0xFF1E7D32)),
      body: ListView(
        children: const [
          ListTile(title: Text('تكلفة الساعة'), subtitle: Text('2,500 ريال')),
          ListTile(title: Text('معدل الاستهلاك الافتراضي'), subtitle: Text('12 دقيقة/لتر')),
          ListTile(title: Text('فترة تغيير الزيت'), subtitle: Text('120 ساعة')),
        ],
      ),
    );
  }
}
