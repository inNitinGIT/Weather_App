import 'package:flutter/material.dart';
import 'weather_screen.dart';

void main(){
  runApp(const Myapp());
}


class Myapp extends StatelessWidget{
  const Myapp({super.key});


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home:const WeatherScreen(),
    );
  }
}