import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hoverColor: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.hovered))
                  return Colors.blue;
                return Colors.white;
              },),
            textStyle: MaterialStatePropertyAll(TextStyle(
              fontSize: 18
            ))// This is a custom color variable
          ),
        ),
        hintColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          iconColor: Colors.white,
          prefixIconColor: Colors.white,
          border: OutlineInputBorder(),
          outlineBorder: BorderSide(color: Colors.white,style: BorderStyle.solid,width: 2)
        ),
        textTheme: TextTheme(
          subtitle1: TextStyle(
            color: Colors.white
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network("http://localhost:3000/static/media/pexels-vimeo-857148-1920x746-30fps.8b5daf109b0fdec56951.mp4");
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenwid = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
           SliverAppBar(
            title: Text("Flowbite"),
            leading: Padding(
              padding: EdgeInsets.all(8.0),
              child: SvgPicture.network("https://flowbite.com/docs/images/logo.svg"),
            ),
            actions: [
              TextButton(onPressed: () {
                
              }, child: Text("Home",)),
              TextButton(onPressed: () {

              }, child: Text("About")),
              TextButton(onPressed: () {

              }, child: Text("Services")),
              TextButton(onPressed: () {

              }, child: Text("Pricing")),
              TextButton(onPressed: () {

              }, child: Text("Contact")),
            ],
            backgroundColor: Color.fromRGBO(17,24,39,1),
            floating: true,
            pinned: true,//sticky
            flexibleSpace: Stack(
              fit: StackFit.passthrough,
              children: [
                //background video start
                Padding(
                  padding: EdgeInsets.only(top: 30,bottom: 30),
                  child: Expanded(flex: 10, child: Platform.isWindows? Image.network("https://images.pexels.com/photos/2844474/pexels-photo-2844474.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",fit: BoxFit.fitWidth,):VideoPlayer(_controller)),
                ),
                //background video end
                //searching hotel start
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex:screenwid<=640?1:2, child: Container()),
                   Expanded(
                     flex:screenwid<=640?8:6,
                       child: Padding(
                     padding: EdgeInsets.all(50.0),
                     child: AspectRatio(aspectRatio:16/2,
                       child:  Container(
                         decoration: BoxDecoration(
                           color: Color.fromRGBO(0,0,0,0.7),
                           borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
                         ),
                         padding: EdgeInsets.all(10.0),
                         child: Form(child:screenwid<=640?
                         Column(children: searchhotel(screenwid),):Row(
                           children: searchhotel(screenwid),
                         )),

                       ),),
                   )),
                    Expanded(flex: screenwid<=640?1:2, child: Container(),)
                  ],
                ),
              //  searching hotel end
              ],
            ),
            expandedHeight:screenwid>=768?600:400,
             snap: true,

          ),
          // Next, create a SliverList
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
              // The builder function returns a ListTile with a title that
              // displays the index of the current item.
                  (context, index) => ListTile(title: Text('Item #$index',style: TextStyle(
                    color: Colors.white,
                  ),

                  )),
              // Builds 1000 ListTiles
              childCount: 100,

            ),
          ),
        ],
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> searchhotel(screenwid) {
    return [
                           Expanded(
                             flex: screenwid<=640?2:4,
                             child: Padding(
                               padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                               child: TextFormField(
                                 decoration: InputDecoration(
                                   prefixIcon: Icon(Icons.search),
                                   label: Text("Search"),
                                 ),
                                 style: TextStyle(
                                   color: Colors.white
                                 ),

                               ),
                             ),
                           ),
                           Expanded(
                             flex: 3,
                             child: Padding(
                               padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                               child: InputDatePickerFormField(
                                 firstDate: DateTime.now(),
                                 keyboardType: TextInputType.datetime,
                                 fieldLabelText: "check in",
                                 lastDate: DateTime.now(),),
                             ),
                           ),
                           Expanded(
                             flex: 3,
                             child: Padding(
                               padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                               child: InputDatePickerFormField(
                                   firstDate: DateTime.now(),keyboardType: TextInputType.datetime,
                                   fieldLabelText: "check out",
                                   lastDate: DateTime.now()),
                             ),
                           ),
                           Expanded(
                             flex: screenwid<=640?3:2,
                             child: Padding(
                               padding: const EdgeInsets.symmetric(vertical: 16.0),
                               child: ElevatedButton(
                                 onPressed: () {
                                   // Validate will return true if the form is valid, or false if
                                   // the form is invalid.

                                 },
                                 child: const Text('Submit'),
                               ),
                             ),
                           ),
                         ];
  }
}
