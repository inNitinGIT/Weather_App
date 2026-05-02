import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'secrets.dart';

import 'Hourly_forecast_item.dart';
import 'additional_info_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {


Future getCurrentWeather() async{
 try {

  String cityName ='london';
   final res = await  http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );
   final data =   jsonDecode(res.body);

   if(data['cod']!='200'){
    throw 'UNEXPECTED ERROR Occurred';
   }
  
 //data['list'][0]['main']['temp'];

return data;

 }catch(e){
  throw e.toString();
 //print(e);
 }


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),

     body: FutureBuilder(
       future: getCurrentWeather(),
       builder: (context, AsyncSnapshot<dynamic> snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {  // this means when its loading , we do wait here .
           return const Center(child: CircularProgressIndicator());  // do the circular progress indicator in middle
         }
         if (snapshot.hasError) {
           return Center(
            child: 
           Text('Error: ${snapshot.error.toString()}'));
         }

         return Padding(
           padding: const EdgeInsets.all(15.0),
           child: Column(
             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
             //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               // main card
               SizedBox(
                 width: double.infinity,
                 child: Card(
                   elevation: 10,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(15),
                   ),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(16),
                     child: BackdropFilter(
                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                       child: Padding(
                         padding: const EdgeInsets.all(16.0),
                         child: Column(
                           children: [
                             SizedBox(height: 10),
                             Text(
                               '200 k',
                               style: const TextStyle(
                                 fontSize: 32,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             const SizedBox(height: 10),
                             const Icon(Icons.cloud, size: 65),
                             Text('Rain', style: TextStyle(fontSize: 20)),
                             SizedBox(height: 10),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
               const SizedBox(height: 20),

               const Text(
                 "Weather forecast",
                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 14),
               // weather forecast features alinged in row
               SingleChildScrollView(
                 scrollDirection: Axis.horizontal,
                 child: Row(
                   children: [
                     HourlyForecastItem(
                       icon: Icons.cloud,
                       temperature: '300',
                       time: '10:00',
                     ),
                     HourlyForecastItem(
                       icon: Icons.sunny,
                       temperature: '320',
                       time: '12:00',
                     ),
                     HourlyForecastItem(
                       icon: Icons.foggy,
                       temperature: '278.34',
                       time: '01:00',
                     ),
                     HourlyForecastItem(
                       icon: Icons.heat_pump,
                       temperature: '300',
                       time: '04:00',
                     ),
                   ],
                 ),
               ),

               const SizedBox(height: 10),
               const Text(
                 'Additional Information',
                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
               ),
               const SizedBox(height: 8),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   AdditionalInfoItem(
                     icon: Icons.water_drop,
                     label: 'Humidity',
                     value: '100',
                   ),
                   AdditionalInfoItem(
                     icon: Icons.air,
                     label: 'Air Quality',
                     value: '90',
                   ),
                   AdditionalInfoItem(
                     icon: Icons.beach_access,
                     label: 'Pressure',
                     value: '130',
                   ),
                 ],
               ),
               // const Placeholder(fallbackHeight: 150),
             ],
           ),
         );
       },
     ),
    );
  }
}
