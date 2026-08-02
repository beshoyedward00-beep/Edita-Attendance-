
import 'package:flutter/material.dart';

void main() {
  runApp(FactoryAttendanceApp());
}

class FactoryAttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حضور المصنع',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Cairo',
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final areas = [
    'Mini Dough Area',
    'Mini packaging Area',
    'Bake stix Dough Area',
    'Bake stix packaging Area',
    'Bake Rolz Dough Area',
    'Bake Rolz packaging Area',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                child: Icon(Icons.factory, size: 50, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text('نظام حضور مصنع الإنتاج', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text('Factory Attendance System', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 30),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(decoration: InputDecoration(labelText: 'رقم موبايل المشرف', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                      SizedBox(height: 16),
                      DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'منطقة الإنتاج', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
                        items: areas.map((a) => DropdownMenuItem(value: a, child: Text(a, style: TextStyle(fontSize: 13)))).toList(),
                        onChanged: (v){},
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AttendanceScreen())),
                          child: Text('دخول', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),
                    ],
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

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String selectedArea = 'Mini Dough Area';
  String selectedShift = 'صباحية';
  
  final List<String> productionAreas = [
    'Mini Dough Area',
    'Mini packaging Area',
    'Bake stix Dough Area',
    'Bake stix packaging Area',
    'Bake Rolz Dough Area',
    'Bake Rolz packaging Area',
  ];

  List<Map<String, dynamic>> employees = [
    {"name": "أحمد محمد", "id": "E001", "status": null},
    {"name": "محمود سيد", "id": "E002", "status": null},
    {"name": "خالد علي", "id": "E003", "status": null},
    {"name": "ياسر إبراهيم", "id": "E004", "status": null},
    {"name": "محمد حسن", "id": "E005", "status": null},
  ];

  void setStatus(int index, String status) {
    setState(() => employees[index]['status'] = status);
  }

  @override
  Widget build(BuildContext context) {
    int present = employees.where((e) => e['status'] == 'present').length;
    int absent = employees.where((e) => e['status'] == 'absent').length;
    int leave = employees.where((e) => e['status'] == 'leave').length;
    int remaining = employees.where((e) => e['status'] == null).length;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(selectedArea, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            Text('$selectedShift - ${DateTime.now().day}/${DateTime.now().month}', style: TextStyle(fontSize: 11)),
          ],
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Area Selector
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: productionAreas.map((area) {
                      bool isSelected = selectedArea == area;
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(area, style: TextStyle(fontSize: 11)),
                          selected: isSelected,
                          onSelected: (v) => setState(() => selectedArea = area),
                          selectedColor: Colors.blue.shade100,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    for (var s in ['صباحية', 'مسائية', 'ليلية'])
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: ChoiceChip(
                            label: Center(child: Text(s)),
                            selected: selectedShift == s,
                            onSelected: (v) => setState(() => selectedShift = s),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          // Stats
          Container(
            padding: EdgeInsets.all(12),
            color: Color(0xFFF5F7FA),
            child: Row(
              children: [
                _statCard('حاضر', present, Colors.green),
                SizedBox(width: 8),
                _statCard('غياب', absent, Colors.red),
                SizedBox(width: 8),
                _statCard('إجازة', leave, Colors.grey),
                SizedBox(width: 8),
                _statCard('متبقي', remaining, Colors.orange),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (ctx, i) {
                final emp = employees[i];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(child: Text(emp['name'][0]), backgroundColor: Colors.blue.shade100),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(emp['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(emp['id'], style: TextStyle(fontSize: 11, color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            _actionBtn(i, 'حاضر', 'present', Colors.green, emp['status']),
                            SizedBox(width: 6),
                            _actionBtn(i, 'غياب', 'absent', Colors.red, emp['status']),
                            SizedBox(width: 6),
                            _actionBtn(i, 'إجازة', 'leave', Colors.grey, emp['status']),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: SizedBox(
          height: 55,
          child: ElevatedButton.icon(
            icon: Icon(Icons.cloud_upload, color: Colors.white),
            label: Text('حفظ وإرسال للإدارة (${employees.where((e) => e['status'] != null).length}/${employees.length})', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم إرسال حضور $selectedArea - وردية $selectedShift بنجاح'), backgroundColor: Colors.green),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, int val, Color c) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: c.withOpacity(0.3))),
        child: Column(children: [Text('$val', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: c)), Text(label, style: TextStyle(fontSize: 11))]),
      ),
    );
  }

  Widget _actionBtn(int idx, String label, String val, Color c, String? selected) {
    bool isSelected = selected == val;
    return Expanded(
      child: ElevatedButton(
        onPressed: () => setStatus(idx, val),
        child: Text(label, style: TextStyle(fontSize: 12)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? c : Colors.white,
          foregroundColor: isSelected ? Colors.white : c,
          side: BorderSide(color: c),
          padding: EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
