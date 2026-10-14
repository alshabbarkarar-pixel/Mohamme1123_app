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
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
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
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardTab(),
    const ClientsTab(),
    const ExpensesTab(),
    const ReportsTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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

// 1. الشاشة الرئيسية (لوحة التحكم)
class DashboardTab extends StatelessWidget {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم'),
        backgroundColor: Colors.green[700],
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('إحصائيات اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                StatCard(title: 'إيرادات اليوم', value: '0 ريال', icon: Icons.attach_money, color: Colors.green),
                StatCard(title: 'سقايات اليوم', value: '0', icon: Icons.water_drop, color: Colors.blue),
                StatCard(title: 'مخزون الديزل', value: '100 لتر', icon: Icons.local_gas_station, color: Colors.teal),
                StatCard(title: 'الديزل المستهلك', value: '0.0 لتر', icon: Icons.ev_station, color: Colors.orange),
                StatCard(title: 'إجمالي الديون', value: '0 ريال', icon: Icons.warning, color: Colors.red),
                StatCard(title: 'ديزل عند الرعية', value: '0.0 لتر', icon: Icons.groups, color: Colors.indigo),
              ],
            ),
            const SizedBox(height: 24),
            const Text('إحصائيات عامة', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: const [
                Expanded(child: StatCard(title: 'الرعية', value: '0', icon: Icons.person, color: Colors.green)),
                SizedBox(width: 12),
                Expanded(child: StatCard(title: 'الجرب', value: '0', icon: Icons.agriculture, color: Colors.brown)),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('إضافة سقاية جديدة')),
          );
        },
        backgroundColor: Colors.green[700],
        icon: const Icon(Icons.add),
        label: const Text('سقاية جديدة'),
      ),
    );
  }
}

// كارت الإحصائيات
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({Key? key, required this.title, required this.value, required this.icon, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6, spreadRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// 2. شاشة الرعية
class ClientsTab extends StatelessWidget {
  const ClientsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرعية'), backgroundColor: Colors.green[700]),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'بحث عن رعوي...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('لا يوجد رعية حالياً', style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}

// 3. شاشة المصروفات
class ExpensesTab extends StatelessWidget {
  const ExpensesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('إدارة المصروفات'),
          backgroundColor: Colors.green[700],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'نظرة عامة'),
              Tab(text: 'العمال'),
              Tab(text: 'الشركاء'),
              Tab(text: 'الصيانة'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildExpenseView('إجمالي المصروفات العامة', '0 ر.ي'),
            _buildExpenseView('مسحوبات العمال', '0 ر.ي'),
            _buildExpenseView('مسحوبات الشركاء', '0 ر.ي'),
            _buildExpenseView('مصروفات الصيانة والأعطال', '0 ر.ي'),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.green[700],
          icon: const Icon(Icons.add),
          label: const Text('إضافة مصروف'),
        ),
      ),
    );
  }

  Widget _buildExpenseView(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[800],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
                Text(amount, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('لا توجد بيانات مسجلة', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}

// 4. شاشة التقارير
class ReportsTab extends StatelessWidget {
  const ReportsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التقارير'), backgroundColor: Colors.green[700]),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text('تقارير الرعية', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ListTile(
            leading: const Icon(Icons.description, color: Colors.blue),
            title: const Text('تقرير قائمة الرعية'),
            subtitle: const Text('تقرير شامل بجميع الرعية'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.book, color: Colors.green),
            title: const Text('كشف حساب رعوي'),
            subtitle: const Text('تقرير مفصل لحساب الرعوي'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          const Text('التقارير المالية والتشغيلية', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ListTile(
            leading: const Icon(Icons.account_balance, color: Colors.teal),
            title: const Text('التقرير المالي الشامل'),
            subtitle: const Text('الإيرادات والمصروفات وصافي الربح'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.oil_barrel, color: Colors.orange),
            title: const Text('تقرير حالة الزيت'),
            subtitle: const Text('الفترة المتبقية لتغيير الزيت'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// 5. شاشة الإعدادات
class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: Colors.green[700]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: const [
                CircleAvatar(backgroundColor: Colors.green, radius: 25, child: Text('م', style: TextStyle(color: Colors.white, fontSize: 20))),
                SizedBox(height: 8),
                Text('محمد عبده محمد مصلح الشبار', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),[span_1](start_span)[span_1](end_span)
                Text('mohammed', style: TextStyle(color: Colors.grey)),[span_2](start_span)[span_2](end_span)
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('الإعدادات العامة', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          const ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('تكلفة الساعة'),
            trailing: Text('2,500 ريال', style: TextStyle(fontWeight: FontWeight.bold)),[span_3](start_span)[span_3](end_span)
          ),
          const ListTile(
            leading: Icon(Icons.oil_barrel),
            title: Text('فترة تغيير الزيت'),
            trailing: Text('120 ساعة', style: TextStyle(fontWeight: FontWeight.bold)),[span_4](start_span)[span_4](end_span)
          ),
          const Divider(),
          const Text('النسخ الاحتياطي', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          ListTile(
            leading: const Icon(Icons.cloud_upload, color: Colors.blue),
            title: const Text('إدارة النسخ الاحتياطي'),
            subtitle: const Text('حفظ بياناتك واستعادتها بأمان'),[span_5](start_span)[span_5](end_span)
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
