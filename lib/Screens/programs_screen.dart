import "package:flutter/material.dart";
import "package:spires_app/Screens/Main_Screens/main_screen.dart";

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Programs"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: Column(
                children: [
                  Image.network(
                      'https://skillupmississippi.com/wp-content/uploads/2019/07/SkillUp-full-color-web.png',
                    height: 100,
                  ),
                  Text("SkillUP 1.0",style: TextStyle(color: Colors.black,),),

                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  Image.network('https://skillupmississippi.com/wp-content/uploads/2019/07/SkillUp-full-color-web.png'),
                  Text("SkillUP 1.0"),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


