import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/src/material/bottom_navigation_bar.dart';
import 'info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

const Map appbar_option = {0: 'Jobs', 1: 'Resume', 2: 'Settings'};
late int myIndex = 0;
BottomNavigationBar bottom = BottomNavigationBar(
    selectedItemColor: Colors.purpleAccent,
    currentIndex: myIndex,
    onTap: (index) {
      setState() {
        print("clicked $index");
        myIndex = index;
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.cases_outlined), label: 'Jobs'),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_2_outlined), label: 'Resume'),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings_outlined), label: 'Settings'),
    ]);

class _HomeScreenState extends State<HomeScreen> {
  late List<job> listings = [];
  @override
  void initState() {
    super.initState();  

    // Run your function here
    getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        backgroundColor: Colors.white,
        title: Text(appbar_option[myIndex]),
        actions: [notificationIcon()],
      ),
      //floatingActionButton: FloatingActionButton(onPressed: getJobs),
      body: ListView.builder(
          itemCount: listings.length, 
          itemBuilder: (context, index) {
            final job = listings[index];

            return Column(
              children:[  ListTile(
                leading: ClipRRect(
                      child: Image.network(job.company['logo']),
                  borderRadius: BorderRadius.circular(5)),
                minTileHeight: 100,
                title: Column(
                  children: [
                    //toptext
                  Container(alignment: Alignment.topLeft,
                  child: Text(job.job_role[0]['title_en'] + " " + job.type_of_sale[0]['title_en'], textScaleFactor: 0.9,)
                  ),
                  //company name
                  Container(alignment: Alignment.topLeft,
                  child: Text(job.company['name'],textScaleFactor: 0.7,)
                  ),
                  //details
                  Container(alignment: Alignment.topLeft,
                  child: Text(job.location['name_en']+", "+job.workplace_type['name_en']+", "+job.type['name_en'],
                  textScaleFactor: 0.7)
                  ),
                  //duration
                  Container(alignment: Alignment.bottomRight,
                    child: Text(getTimePass(job.created_date), textScaleFactor: 0.6,)
                  )
                    ],
                ),
              ), 
              const SizedBox(height: 10)]
            );
          }),
      bottomNavigationBar: bottom,
    );
  }

  void getJobs() async {
    final response = await http.get(Uri.parse('https://mpa0771a40ef48fcdfb7.free.beeceptor.com/jobs'));
    dynamic data;

    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(utf8.decode(response.body.codeUnits))['data'];
      });
    } else {
      throw Exception("Failed to load jobs. Bad Connection ");
    }

    for(dynamic x in data){
      listings.add(job.fromJson(x));
    }
  }

  String getTimePass(String c_date){
    var x = c_date.split('-');
    DateTime start = DateTime(int.parse(x[0]), int.parse(x[1]), int.parse(x[2]));
    DateTime end = DateTime.now();
    Duration diff = end.difference(start);
    int hours = diff.inHours;
    return '$hours hours ago';
  }
  
}
class notificationIcon extends StatelessWidget{
  @override
  Widget build(Object context) {
    return IconButton(
    onPressed: (){}, 
    icon: const Icon(Icons.notifications),
    );
  }
}
