import 'package:flutter/material.dart';

class InfoOder extends StatefulWidget {
  const InfoOder({super.key});

  @override
  State<InfoOder> createState() => _InfoOderState();
}

class _InfoOderState extends State<InfoOder> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
  heightFactor: 0.95,
  widthFactor: 1,
      child:Material(
        child:  Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child:Column(
          children: [ 
           Expanded(
          child:
           SingleChildScrollView(
            child: Column(
children: [

Container(
alignment: Alignment.centerLeft,
 height: MediaQuery.of(context).size.height*0.1,

child:GestureDetector(
   onTap: (){
     Navigator.pop(context);
                    },
  child:  Text('Cancel',
 style: TextStyle(
            fontSize: 16,
  decoration: TextDecoration.none, 
 color: Colors.red
              ),
),
)
),
Container(
 width: double.infinity,
  decoration: BoxDecoration(),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
  
children: [
Text("Tên nhà hàng",
 style: TextStyle(
 
            fontSize: 20,
 fontWeight: FontWeight.w600,
  decoration: TextDecoration.none, 
 color: Colors.black
              ),

),

Text("Thông tin đặt hàng",
 style: TextStyle(
            fontSize: 16,

  decoration: TextDecoration.none, 
 color: Colors.black
              ),

),
],

  ),
  ),

Container(
  width: double.infinity,
  decoration: BoxDecoration(),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    

     Row(
        children: [
     Container(
      decoration: BoxDecoration(
       border: Border(
        right:BorderSide(
          width: 1,
          color: Colors.grey,
        )
       )
      ),
      child:    Text('Number',
        style: TextStyle(
          
        ),
        ),
     ),
         
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),

        Row(
        children: [
        Container(
      decoration: BoxDecoration(
       border: Border(
        right:BorderSide(
          width: 1,
          color: Colors.grey,
        )
       )
      ),
      child:    Text('Number',
        style: TextStyle(
          
        ),
        ),
     ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
  ],
),
)

],
            ),
           ),
           ),

          Container(
            height: MediaQuery.of(context).size.height*0.1,
            width:MediaQuery.of(context).size.width ,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 1,

                )
              )
            ),
            child: Center(
              child: Container(
                alignment: Alignment.center,
            height: MediaQuery.of(context).size.height*0.5,
            width:MediaQuery.of(context).size.width*0.8 ,
            decoration: BoxDecoration(
              color: Colors.red
            ),
              child:Text('Reserve',
              style: TextStyle(
            fontSize: 16,
  fontWeight: FontWeight.w600, 
  decoration: TextDecoration.none, 
 color: Colors.white
              ),
              ) ,
              ),
              
              ),
          )

          ],
        )
      )
      )
    ),
    );
  }
}