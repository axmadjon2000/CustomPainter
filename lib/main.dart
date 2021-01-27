import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as M;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body:Center(
       child:Transform.rotate(
         angle:-M.pi/2,
         child: CustomPaint(
           size: Size(300,300),
           painter: MyPaint(),
         ),
       )
      )
    );
  }
}
class MyPaint extends CustomPainter{
  var dateTime=DateTime.now();
  //1s - 6degree

  @override
  void paint(Canvas canvas, Size size) {
    var centerX=size.width/2;
    var centerY=size.height/2;

    var center=Offset(centerX,centerY);
    var radius=M.min(centerX,centerY);
    var mypaint=new Paint();
    mypaint.color=Color(0xFF444974);
    mypaint.style=PaintingStyle.fill;

    var mypaintoutline=new Paint();
    mypaintoutline.color=Colors.white;
    mypaintoutline.strokeWidth=16;
    mypaintoutline.style=PaintingStyle.stroke;

    var mypaintcenter=new Paint();
    mypaintcenter.style=PaintingStyle.fill;
    mypaintcenter.color=Colors.white;

    var mypaintsec=new Paint();
    mypaintsec.style=PaintingStyle.stroke;
    mypaintsec.color=Colors.orange[600];
    mypaintsec.strokeCap=StrokeCap.round;
    mypaintsec.strokeWidth=10;

    var mypaintmin=new Paint();
    mypaintmin.style=PaintingStyle.stroke;
    mypaintmin.shader=RadialGradient(colors: [Colors.blue,Colors.pink]).createShader(Rect.fromCircle(center: center,radius: radius));
    mypaintmin.color=Colors.blue;
    mypaintmin.strokeCap=StrokeCap.round;
    mypaintmin.strokeWidth=13;

    var mypainthour=new Paint();
    mypainthour.style=PaintingStyle.stroke;
    mypainthour.shader=RadialGradient(colors: [Colors.red,Colors.grey]).createShader(Rect.fromCircle(center: center,radius: radius));
    mypainthour.color=Colors.pink;
    mypainthour.strokeCap=StrokeCap.round;
    mypainthour.strokeWidth=17;

    canvas.drawCircle(center,radius-40, mypaint);
    canvas.drawCircle(center,radius-40, mypaintoutline);

    var minHandX=centerX+80*M.cos(dateTime.minute*6*M.pi/180);
    var minHandY=centerX+80*M.sin(dateTime.minute*6*M.pi/180);
    canvas.drawLine(center,Offset(minHandX,minHandY),mypaintmin);

    var hourHandX=centerX+60*M.cos((dateTime.hour*30+dateTime.minute*0.5)*M.pi/180);
    var hourHandY=centerX+60*M.sin((dateTime.hour*30+dateTime.minute*0.5)*M.pi/180);
    canvas.drawLine(center,Offset(hourHandX,hourHandY),mypainthour);

    var secHandX=centerX+80*M.cos(dateTime.second*6*M.pi/180);
    var secHandY=centerX+80*M.sin(dateTime.second*6*M.pi/180);
    canvas.drawLine(center,Offset(secHandX,secHandY),mypaintsec);
    canvas.drawCircle(center,16, mypaintcenter);

    var mypaintdash=new Paint();
    mypaintdash.color=Colors.white;
    var outerradius=radius;
    var innerradius=radius-14;
    for(double i=0;i<360;i+=12){
      var x1=centerX+outerradius*M.cos(i*M.pi/180);
      var y1=centerX+outerradius*M.sin(i*M.pi/180);

      var x2=centerX+innerradius*M.cos(i*M.pi/180);
      var y2=centerX+innerradius*M.sin(i*M.pi/180);
      canvas.drawLine(Offset(x1,y1),Offset(x2,y2),mypaintdash);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>true;



}