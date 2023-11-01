import 'package:flutter/material.dart';




class profile extends StatelessWidget {
  late final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('Assets/images/2.png'),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('Abanob Kamal', style: TextStyle(color: Colors.grey[800], fontSize: 25, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child: Text('Doctor', style: TextStyle(color: Colors.blueGrey[400], fontSize: 14, fontWeight: FontWeight.w600),),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: IconButton(
                            onPressed: () { print("Edit"); },
                            icon:  Icon(Icons.edit, color: Colors.blueGrey[400],)
                          ),
                        ),
                        // Container(
                        //   width: 100,
                        //   height: 40,
                        //   padding: EdgeInsets.only(left: 20),
                        //   child: MaterialButton(
                        //     shape: RoundedRectangleBorder(side: BorderSide(
                        //         color: Colors.blue,
                        //         width: 1,
                        //         style: BorderStyle.solid
                        //     ), borderRadius: BorderRadius.circular(50)),
                        //     disabledColor: Colors.blue,
                        //     color: Colors.blue,
                        //     onPressed: () {  },
                        //     child: Text('Follow', style: TextStyle(color: Colors.white),),
                        //   ),
                        // ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Divider(
                  thickness: 1,
                  color: Colors.blueGrey[200],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('203', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),),
                        ),
                        Container(
                          child: Text('Patient', style: TextStyle(fontSize: 15, color: Colors.blueGrey),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('932', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),),
                        ),
                        Container(
                          child: Text('Following', style: TextStyle(fontSize: 15, color: Colors.blueGrey),),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('30', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),),
                        ),
                        Container(
                          child: Text('Organization', style: TextStyle(fontSize: 15, color: Colors.blueGrey),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Divider(
                  thickness: 1,
                  color: Colors.blueGrey[200],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text('Projects', style: TextStyle(fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.w900),),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network('https://www.techuz.com/blog/wp-content/uploads/2019/06/Technology-Stack_Banner-1280x720.jpg',)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Text('MERN Stack Project', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 20),),
                              ),
                              Container(
                                child: Icon(Icons.favorite, color: Colors.red,),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network('https://appsmaventech.com/images/blog/React-Native-Vs-Flutter-What-Is-Better-For-Your-Business.jpg',)
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Text('Flutter vs React', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 20),),
                              ),
                              Container(
                                child: Icon(Icons.favorite, color: Colors.red,),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
