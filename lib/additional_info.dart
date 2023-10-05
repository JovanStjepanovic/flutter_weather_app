


import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
 
  final IconData icon; 
  final String label; 
  final String value;
 
  const AdditionalInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
                        
     
     children: [
           
         const    SizedBox( height:10),
        
          Icon(icon, size: 35,),
             
         const    SizedBox( height:10),
            Text(label),
     
           const      SizedBox( height:10),
            Text(value)
     
     
     
     
     ],
      
    );
  }
}