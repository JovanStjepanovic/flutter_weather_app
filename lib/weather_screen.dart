import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weatherapp/additional_info.dart';
import 'package:weatherapp/hourly_forecast.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget  {
  const WeatherScreen({super.key});


  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

double temp=0;


late Future<Map<String,dynamic>> weather ;

Future<Map<String,dynamic>> getWeather() async{
try{

final result=  await   http.get(Uri.parse('https://komentar.rs/wp-json/api/weather'));
final data = jsonDecode(result.body);

if(data['message']!='Success'){

throw 'Unexpected error';
}




return data;

}catch(e){
 throw (e.toString());
}



}

@override
  void initState() {
    super.initState();
    weather= getWeather();
  }






  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const Text("Weather App", 
        style: TextStyle(
         fontWeight: FontWeight.bold
        ),
        ),
        centerTitle: true,
         actions:  [
          IconButton(
            onPressed: (){
            setState(() {
              weather=getWeather();
            });
            }, 
            icon: const Icon(Icons.refresh),
          ),
            
         ],    
      ) ,
   
        body:  FutureBuilder(
          
          future: weather,
          builder: (context,snapshot) {
          
            if(snapshot.connectionState == ConnectionState.waiting){
           
             return  const Center(child:  CircularProgressIndicator.adaptive());
            }
          
            if(snapshot.hasError){
              return Text(snapshot.hasError.toString());
            }

              final data = snapshot.data!;

               final currentTemp= data ['data'] ['temp'];
               final weatherDesc= data['data'] ['description'];
               final humidity= data['data'] ['humidity'];
               final windSpeed = data ['data']['wind'];
             final pressure= data ['data']['pressure'];  
            final dayOne= data ['data']['day_0']['temp_max'];
           final dayTwo= data ['data']['day_1']['temp_max'];  
           final dayThree= data ['data']['day_2']['temp_max'];         
           final dayFour= data ['data']['day_3']['temp_max'];
           final dayFive= data ['data']['day_4']['temp_max'];
           
            return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                  //Main card
          
                   SizedBox(
                     width: double.infinity,
                     child: Card(
                     elevation: 10,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),                            
                     child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                       child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10),
                         child:  Padding(
                           padding: const EdgeInsets.all(16.0),
                           child: Column(
                            children: [
                              
                              Text("$currentTemp °C",
                              style: const TextStyle(
                                fontSize: 32
                              ),
                              ),
                                          
                          const    SizedBox(height: 10,),
                          const    Icon(
                              Icons.cloud,
                              size: 64,
                              ),
                            const       SizedBox(height: 16,), 
                                Text("$weatherDesc", style: const TextStyle(fontSize: 16),
                                 
                                 ),
                         
                            ],
                                          
                           ),
                         ),
                       ),
                     ),
                   
                     ),
                   ),
          
          
                   //Weather forecast 
          
                  const  SizedBox( height:20),
                   const Text("Weather forecast",
                   style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                                 
                   ),     
                         
                          const  SizedBox( height:12),
                     
                     // Weather forecast cards 
          
                       SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(                      
                             children: [
                               DayForecast(
                                icon: Icons.cloud,
                                time: 'Mon',
                                temperature: '$dayOne °C',
                               ),
                                DayForecast(
                                icon: Icons.cloud,
                                time: 'Tues',
                                temperature: '$dayTwo °C',
                                ),
                              DayForecast(
                                    icon: Icons.cloud,
                                time: 'Wed',
                                temperature: '$dayThree °C',
                              ),
                              DayForecast(
                                icon: Icons.cloud,
                                time: 'Frid',
                                temperature: '$dayFour °C',
                              ),
                              DayForecast(
                               icon: Icons.cloud,
                                time: 'Satur',
                                temperature: '$dayFive °C',
                              ),
                             ],
                        
                          ),
                        ),
          
                  
                  
                     //additional info
          
                  const  SizedBox( height:20),
                   
            const Text("Additional information",
                   style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                                 
                   ), 
          
          
                     Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                  
                         AdditionalInfo(
                          icon: Icons.water_drop,
                          label: 'Humidity',
                          value: '$humidity',
                         ),
                         AdditionalInfo(
                          icon: Icons.air,
                          label: 'Wind speed',
                          value: '$windSpeed',
                         ),   
                         AdditionalInfo(
                          icon: Icons.beach_access,
                          label: 'Pressure',
                          value: '$pressure',
                         ),
                      
                  
                  
                  
                  
                       
                        ],
                  
                     )
                  
                  
          
              ],
            ),
          );
          },
        ),



    );
  }
}



