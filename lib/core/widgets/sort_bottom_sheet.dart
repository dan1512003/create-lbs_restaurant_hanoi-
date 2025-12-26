import 'package:flutter/material.dart';

class SortBottomSheet extends StatefulWidget {
  final String selected;

  const SortBottomSheet({super.key, required this.selected});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  double _sheetOffset = 0;

  @override
  Widget build(BuildContext context) {
    final options = [
      'Most recent',
      'Highest rating',
      'Lowest rating',
    ];
 
    final maxHeight = MediaQuery.of(context).size.height * 0.5;

    return GestureDetector(
        onVerticalDragUpdate: (details) {
                  setState(() {
                    _sheetOffset += details.delta.dy;
                    if (_sheetOffset < 0) _sheetOffset = 0; 
                    if (_sheetOffset > maxHeight) _sheetOffset = maxHeight; 
                  });
                },
                onVerticalDragEnd: (details) {
                  if (_sheetOffset > maxHeight / 2) {
                    
                    Navigator.of(context).pop(); 
                  } else {
                    setState(() {
                      _sheetOffset = 0; 
                    

                    });
                  }
                },
      child: Scaffold(
       backgroundColor: Colors.transparent, 
        body: Stack(
          children: [
           
            
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              bottom: -_sheetOffset, 
              left: 0,
              right: 0,
              child: GestureDetector(
               
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    maxHeight: maxHeight,
                  ),
                  decoration: const BoxDecoration(
                  
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    
                      Container(
                        height: 4,
                        width: 40,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                
                 Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),

                  ),
                  child:  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                   Container(
                    margin: EdgeInsets.only(top: 15,bottom: 15),
                    decoration: BoxDecoration(),
                    child:  Text("Sort reviews by"),
                   ),
                      ...List.generate(options.length, (index) {
      final e = options[index];
      return GestureDetector(
      onTap: () {
 
  Navigator.of(context).pop(e);
},
       
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: index != options.length - 1  
                ? Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.3,
                    ),
                  )
                : null,
          ),
          child: Text(e),
        ),
      );
    }),
              Center(
                child:   GestureDetector(
                      onTap: () {

  Navigator.of(context).pop(widget.selected);
},
                  child:  Container(
                    margin: EdgeInsets.only(top: 15,bottom: 15),
                    alignment: Alignment.center,
                    width:  MediaQuery.of(context).size.width*0.9,
                    height: 50,
                    decoration: BoxDecoration(
                  
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      border: Border.all(
                        width: 0.5,
                        color: Colors.grey
                      )
                    ),
                    child:  Text("Cancel"),
                   ),
                   ) )
                    ],
                    ),
                 ),
                    
                      
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
