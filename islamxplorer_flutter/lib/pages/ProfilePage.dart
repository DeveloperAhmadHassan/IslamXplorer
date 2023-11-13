import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfilePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 160,
                height: 160,
                child: ClipRRect(borderRadius: BorderRadius.circular(100),child: const Image(image: AssetImage('assets/image.png'))),
              ),
              const SizedBox(height: 10,),
              Text("John Doe"),
              Text("john123@gmail.com"),
            ],
          ),
        ),
      )
    );
  }

}