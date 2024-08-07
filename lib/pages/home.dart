import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    //set Background
    String bgImage = data['isDayTime'] ? 'day.jpeg' : 'night.jpeg';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                   dynamic result = await Navigator.pushNamed(context, '/location');
                   print(result);
                   setState(() {
                     data = {
                       'time': result['time'],
                       'location': result['location'],
                       'isDayTime': result['isDayTime'],
                       'flag': result['flag'],
                     };
                   });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[600],
                  ), // Using built-in Icons for clarity
                  label: Text(
                    'Edit location',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${data['location']}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  '${data['time']}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 65.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
