import 'package:flutter/material.dart';
void main() { runApp(MaterialApp(home: LoginScreen(), debugShowCheckedModeBanner: false)); }

class LoginScreen extends StatelessWidget {
  final areas = ['Mini Dough Area','Mini packaging Area','Bake stix Dough Area','Bake stix packaging Area','Bake Rolz Dough Area','Bake Rolz packaging Area'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.factory, size: 80, color: Colors.blue),
            Text('Edita - حضور المصنع', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            TextField(decoration: InputDecoration(labelText: 'موبايل المشرف', border: OutlineInputBorder())),
            SizedBox(height: 20),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>AttendanceScreen())), child: Text('دخول'))),
          ]),
        ),
      ),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}
class _AttendanceScreenState extends State<AttendanceScreen> {
  String selectedArea = 'Mini Dough Area';
  List employees = [{"name":"أحمد محمد","status":null},{"name":"محمود سيد","status":null},{"name":"خالد علي","status":null},{"name":"ياسر إبراهيم","status":null}];
  void setStatus(int i, String s){setState(()=>employees[i]['status']=s);}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedArea), backgroundColor: Colors.blue, foregroundColor: Colors.white),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (c,i)=>Card(margin: EdgeInsets.all(8), child: ListTile(
          title: Text(employees[i]['name']),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            ElevatedButton(onPressed: ()=>setStatus(i,'present'), child: Text('حاضر'), style: ElevatedButton.styleFrom(backgroundColor: employees[i]['status']=='present'?Colors.green:Colors.white, foregroundColor: employees[i]['status']=='present'?Colors.white:Colors.green)),
            SizedBox(width:4),
            ElevatedButton(onPressed: ()=>setStatus(i,'absent'), child: Text('غياب'), style: ElevatedButton.styleFrom(backgroundColor: employees[i]['status']=='absent'?Colors.red:Colors.white, foregroundColor: employees[i]['status']=='absent'?Colors.white:Colors.red)),
            SizedBox(width:4),
            ElevatedButton(onPressed: ()=>setStatus(i,'leave'), child: Text('إجازة'), style: ElevatedButton.styleFrom(backgroundColor: employees[i]['status']=='leave'?Colors.grey:Colors.white, foregroundColor: employees[i]['status']=='leave'?Colors.white:Colors.grey)),
          ]),
        )),
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.all(16), child: ElevatedButton(onPressed: (){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم الإرسال')));}, child: Text('حفظ وإرسال للإدارة'), style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 55), backgroundColor: Colors.blue, foregroundColor: Colors.white))),
    );
  }
}
