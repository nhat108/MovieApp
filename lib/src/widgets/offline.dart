import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class OffLineWidget extends StatefulWidget {
  @override
  _OffLineWidgetState createState() => _OffLineWidgetState();
}

class _OffLineWidgetState extends State<OffLineWidget> {
  
  
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Container(
          child: Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/the_pianist.jpg',
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
              Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Whoop!',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10,),
                  Text(
                      'No Internet connection Found,\n Please check your Internet Settings.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Aller'
                      ),
                      ),
                  SizedBox(height: 20,),
                  OutlineButton(
                    highlightedBorderColor: Colors.white,
                    textTheme: ButtonTextTheme.accent,
                    color: Colors.white,
                    onPressed: (){
                        AppSettings.openWIFISettings();
                    },
                    child: Text('Retry'),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
