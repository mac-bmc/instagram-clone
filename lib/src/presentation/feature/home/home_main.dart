import 'package:app_clone/src/utils/story_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          //title: Text("AppName",style: Theme.of(context).textTheme.headlineLarge,),//with different font
          actions: [
            Row(
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border)),
              ],
            )
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
