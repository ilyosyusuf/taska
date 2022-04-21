import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/services/firebase/home_service.dart';

class SecondHomePage extends StatelessWidget {
  const SecondHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: FireHome.getData(),
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snap) {
            if (!snap.hasData) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (snap.hasError) {
              return Center(
                child: Text("No Internet",),
              );
            } else {
              var data = snap.data;
              return Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/images/taska.png', width: 50,),
                            Text("Taska", style: TextStyle(fontSize: 25.0, fontFamily: 'mainFont', fontWeight: FontWeight.bold),),
                          ],
                        ),
                        IconButton(onPressed: (){}, icon: Icon(Icons.notifications), color: ColorConst.kPrimaryColor,),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, i) {
                        return ListTile(
                            title: Text(data!['todos'][i]['title'].toString()));
                      },
                      itemCount: data!['todos'].length,
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
