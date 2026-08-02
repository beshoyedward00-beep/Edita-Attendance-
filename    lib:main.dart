import 'package:flutter/material.dart';

void main() {
  runApp(const FactoryApp());
}

class FactoryApp extends StatelessWidget {
  const FactoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edita Factory',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HeadcountScreen(),
    );
  }
}

class HeadcountScreen extends StatefulWidget {
  const HeadcountScreen({super.key});

  @override
  State<HeadcountScreen> createState() => _HeadcountScreenState();
}

class _HeadcountScreenState extends State<HeadcountScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edita - حصر العمالة'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.factory, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text('عدد الحضور اليوم', style: TextStyle(fontSize: 22)),
            Text('$count', style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => count++),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('+ إضافة', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => setState(() => count = count > 0 ? count - 1 : 0),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text('- حذف', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
