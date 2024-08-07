import 'package:flutter/material.dart';
import 'package:world_time/Services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: 'London', flag: 'uk.png', url: '/Europe/London'),
    WorldTime(location: 'Athens', flag: 'greece.png', url: '/Europe/Berlin'),
    WorldTime(location: 'Cairo', flag: 'egypt.png', url: '/Africa/Cairo'),
    WorldTime(location: 'Nairobi', flag: 'kenya.png', url: '/Africa/kenya'),
    WorldTime(location: 'Chicago', flag: 'usa.png', url: '/America/Chicago'),
    WorldTime(location: 'New York', flag: 'usa.png', url: '/America/New_York'),
    WorldTime(location: 'Seoul', flag: 'south_korea.png', url: '/Asia/Seoul'),
    WorldTime(location: 'Jakarta', flag: 'indonesia.png', url: '/Asia/jakarta'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          'Choose a location',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index){
            return Padding(padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
                child: ListTile(
                onTap: (){
                  updateTime(index);
            },
            title: Text(locations[index].location ?? 'Unknown'),
            leading: CircleAvatar(
            backgroundImage: AssetImage('assets/${locations[index].flag}'),
            ),
            ),
            ),
            );
          }),
    );
  }
}
