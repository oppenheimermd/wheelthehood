
import 'package:flutter/material.dart';
import 'package:wheelthehood/ui/helpers/clipper.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        fit: StackFit.passthrough,
        children: <Widget>[
          // clip screen in half and fill top half with black colour
          // or background image
          ClipPath(
            child: Container(
              color: Colors.black.withOpacity(0.8),
            ),
            clipper: GetClipper(),
          ),
          //  Because this is a stack, we can use a
          //  position widget to position the next item
          //  (image) where we want it.
          Positioned(
            width: 350.0,
            /* Note the use of "MediaQuery.of(context).size"
            * to get dimension of screen */
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage('assets/profile_pic.jpg'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.5, color: Colors.black)
                      ]),
                ),
                SizedBox(
                  height: 90.0,
                ),
                Text(
                  'Kawhi Leonard',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Archivo'),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Subscribe guys',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Archivo'),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: 30.0,
                      width: 95.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'Edit Name',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Archivo'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      width: 95.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.red,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Archivo'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      width: 95.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.grey,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Text('Edit Photo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Archivo')),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}