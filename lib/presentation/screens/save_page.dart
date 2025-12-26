import 'package:flutter/material.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> with SingleTickerProviderStateMixin {

  double offsetX = 0;
   final double maxOffset = 75; 

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }
  void animateTo(double target) {
    _animation = Tween<double>(begin: offsetX, end: target)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward(from: 0);
    _animation.addListener(() {
      setState(() {
        offsetX = _animation.value;
      });
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context,constraints){
  final double maxWidth = constraints.maxWidth;

  double itemsWidth = maxWidth * 0.2;
          double itemsHeight = maxWidth * 0.2;

 if (itemsWidth < 100) itemsWidth = 100;
          if (itemsWidth > 150) itemsWidth  = 150;

          if (itemsHeight < 100) itemsHeight = 100;
          if (itemsHeight > 150) itemsHeight = 150;


return Column(
      
        children: [
  //appbar
 Container(
              height: 50,
            
              decoration: const BoxDecoration(),
              child:  Row(
                    children: [
                    
                      const SizedBox(width: 4),
                      Container(
  margin: const EdgeInsets.only(top: 5), 
  child: const Text(
    'Save',
    style: TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  ),
)

                    ],
                  ),
            ),

        //body
       Expanded(child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(),
          child: Column(

            children: [
         GestureDetector(
    
          child:  Container(
     height: itemsHeight,
  decoration: BoxDecoration(),
  child: Stack(
   children: [
Row(
mainAxisAlignment: MainAxisAlignment.end,
  children: [

                      Container(
                      height: itemsHeight,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.red
                      ),
                      child: GestureDetector(

                        child: Center(
                          child: Text("Delete"),
                        ),
                      ),
                      ),

  ],
),

Transform.translate(
  offset: Offset(-offsetX, 0), 
  child: GestureDetector(
  //                 onTap: () {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => InfoMenu(),
  //     ),
  //   );
  // },
    onHorizontalDragUpdate: (details) {
      setState(() {
        if (details.delta.dx < 0) {
          offsetX += (-details.delta.dx);
          if (offsetX > maxOffset) offsetX = maxOffset;
        } else {
          offsetX -= details.delta.dx;
          if (offsetX < 0) offsetX = 0;
        }
      });
    },
    onHorizontalDragEnd: (details) {
      if (offsetX < maxOffset / 2) {
        animateTo(0);
      } else {
        animateTo(maxOffset);
      }
    },
    child: Container(
      height:    itemsHeight,
          
      width: maxWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:    itemsHeight -10,
            width: itemsWidth -10,
           decoration: BoxDecoration(
            image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://picsum.photos/id/1025/600/400'),
                                      fit: BoxFit.cover,
                                    ),),
          ),
        
        
                 Expanded(child:Container(
                 height: itemsHeight,
                 
                decoration: BoxDecoration(
                 border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      child: Text('Tên nhà hàng')
                    )
                  ],
                ),
                 )
                 ),
                       
   
         
 
        ],
      ),
    ),
  ),
),




   ],
  ),

)
         )



            ],
          ),
        ),
       ))


        ],
      );

      })
    );
  }
}