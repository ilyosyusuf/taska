import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/providers/add_provider.dart';
import 'package:taska/providers/change_provider.dart';
import 'package:taska/services/firebase/home_service.dart';

class SecondHomePage extends StatefulWidget {
  SecondHomePage({Key? key}) : super(key: key);

  @override
  State<SecondHomePage> createState() => _SecondHomePageState();
}

class _SecondHomePageState extends State<SecondHomePage> {
  TextEditingController _searchController = TextEditingController();
  bool onTap = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AddProvider>().addToList();
  }
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
                child: Text(
                  "No Internet",
                ),
              );
            } else {
              var data = snap.data;
              return Container(
                color: ColorConst.kBackgroundColor,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/taska.png',
                                width: 50,
                              ),
                              Text(
                                "Taska",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'mainFont',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications),
                            color: ColorConst.kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: textField(
                          text: 'search...',
                          controller: _searchController,
                          iconButton: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, left: 15.0, right: 15.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.11,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text(
                                    data!['todos'][i]['title'].toString(),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Text(data['todos'][i]['date'].toString() ==
                                              DateTime.now()
                                          ? "Today"
                                          : data['todos'][i]['date'].toString()),
                                      Text(" - "),
                                      Text(data['todos'][i]['time'].toString()),
                                    ],
                                  ),
                                  trailing: Transform.scale(
                                    scale: 1.2,
                                    child: SizedBox(
                                      child: Checkbox(
                                        side: BorderSide(
                                            width: 1,
                                            color: ColorConst.kPrimaryColor),
                                        activeColor: ColorConst.kPrimaryColor,
                                        value: data['todos'][i]['check'],
                                        onChanged: (v) async {
                                          data['todos'][i]['check'] = !data['todos'][i]['check'];
                                          
                                          context.read<AddProvider>().changeValue(i, data['todos'][i]['check'] );
                                          // print(data['todos'][i]['check'] );
                                          // onTap = !onTap;
                                          // onTap = data['todos'][i]['check'];
                                          // await context.read<AddProvider>().checkTrue(i);
                                          // await context.read<AddProvider>().addToList();
                                          // data['todos'][i]['check'];
                                          // print(data['todos'][i]['check']);
                                          // context.read<ChangeProvider>().changed(i, data['todos'][i]['check'] );
                                          setState(() {
                                            
                                          });
                                          // context.read<DbProvider>().checkDb(i);
                                          // await context.read<DbProvider>().gener();
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        },
                        itemCount: data!['todos'].length,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  TextFormField textField(
      {required String text,
      IconButton? iconButton,
      required TextEditingController controller,
      IconButton? suffixIcon}) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: text,
          prefixIcon: iconButton,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none),
        )
        // validator: (v)=> v!.length < 5 ? "5 tadan kam bo'lmasin!" : null
        );
  }
}