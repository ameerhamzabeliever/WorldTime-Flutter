import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool? isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime()  async {
    final urlString = 'http://worldtimeapi.org/api/timezone/$url';
    final uri = Uri.parse(urlString);
    Response response = await get(uri);
    try {
      Response response = await get(uri);
      // print(response.body);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final data = json.decode(response.body) as Map<String, dynamic>;
        // print(data);

        // get properties from data
        String dateTime = data['datetime'];
        String offset = data['utc_offset'].substring(1, 3);
        // print(dateTime);
        // print(offset);

        // create DateTime object
        DateTime now = DateTime.parse(dateTime);
        now = now.add(Duration(hours: int.parse(offset)));

        //setting time
        isDayTime = now.hour > 6 && now.hour < 19 ? true: false;
        time = DateFormat.jm().format(now);

      } else {
        print('Error: ${response.statusCode}'); // Handle error cases
      }
    } catch (error) {
      print('Error: $error'); // Handle exceptions
    }
  }
}