import 'package:flutter/material.dart';
class Others extends StatefulWidget {
  const Others({ Key? key }) : super(key: key);

  @override
  _OthersState createState() => _OthersState();
}

class _OthersState extends State<Others> {
  int accomplished=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(onPressed: (){
                  setState(() {
                    if (accomplished==0)
                      null;
                    else
                      accomplished--;
                  });
                },
                backgroundColor: Colors.red.withOpacity(0.6),
                child: Icon(Icons.remove),
                ),
                Text("${accomplished}",
                style: TextStyle(
                  fontSize: 40,
                ),
                ),
                FloatingActionButton(onPressed: (){
                  setState(() {
                    accomplished++;
                  });
                },
                backgroundColor: Colors.red.withOpacity(0.6),
                child: Icon(Icons.add),
                )
              ],
            ),
            Text('doughs made')
          ],
        ),
        ),
      
    );
  }
}