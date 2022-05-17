import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taska/core/components/app_bar.dart';
import 'package:taska/core/components/text_field.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/providers/add_provider.dart';
import 'package:taska/services/firebase/home_service.dart';
import 'package:taska/widgets/task_info_widget.dart';

class SecondHomePage extends StatefulWidget {
  SecondHomePage({Key? key}) : super(key: key);

  @override
  State<SecondHomePage> createState() => _SecondHomePageState();
}

class _SecondHomePageState extends State<SecondHomePage> {
  TextEditingController _searchController = TextEditingController();
  bool onTap = false;
  bool tapToSearch = false;
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
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snap.hasError) {
            return const Center(
              child: Text(
                "No Internet",
              ),
            );
          } else {
            var data = snap.data;
            List sett = context.watch<AddProvider>().setList.toList();
            return Container(
              color: ColorConst.kBackgroundColor,
              child: Column(
                children: [
                  MyAppBar.myAppBar(
                    iconButton: IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons.bell),
                      color: ColorConst.kPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: MyTextField.textField(
                        text: 'search...',
                        controller: _searchController,
                        onChanged: (text) {
                          context.read<AddProvider>().searchIt(text);
                        },
                        onTap: () {
                          _searchController.clear();
                          tapToSearch = !tapToSearch;
                          setState(() {});
                        },
                        iconButton: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _searchController.text.isEmpty ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: snap.data!['todos'].length != 0
                              ? Swiper(
                                  autoplay: true,
                                  containerHeight:
                                      MediaQuery.of(context).size.height * 0.1,
                                  itemCount: snap.data!['todos'].length,
                                  itemBuilder: (context, index) {
                                    return PicTaskInfoWidget(
                                      image: snap.data!['todos'][index]
                                          ['image_todos'],
                                      index: index,
                                      title: snap.data!['todos'][index]['title']
                                          .toString(),
                                      date: snap.data!['todos'][index]['date']
                                          .toString(),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text(
                                    'no tasks yet',
                                  ),
                                ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              itemBuilder: (context, i) {
                                return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 15.0, left: 15.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.11,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                                255, 183, 202, 212),
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
                                            Text(data['todos'][i]['date']
                                                        .toString() ==
                                                    DateTime.now()
                                                ? "Today"
                                                : data['todos'][i]['date']
                                                    .toString()),
                                            Text(" - "),
                                            Text(data['todos'][i]['time']
                                                .toString()),
                                          ],
                                        ),
                                        trailing: Transform.scale(
                                          scale: 1.2,
                                          child: SizedBox(
                                            child: Checkbox(
                                              side: BorderSide(
                                                  width: 1,
                                                  color:
                                                      ColorConst.kPrimaryColor),
                                              activeColor:
                                                  ColorConst.kPrimaryColor,
                                              value: data['todos'][i]['check'],
                                              onChanged: (v) async {
                                                data['todos'][i]['check'] =
                                                    !data['todos'][i]['check'];

                                                await context
                                                    .read<AddProvider>()
                                                    .changeValue(
                                                        i,
                                                        data['todos'][i]
                                                            ['check']);
                                                await context
                                                    .read<AddProvider>()
                                                    .deleteTodos(i);
                                                setState(() {});
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
                        ),
                      ],
                    )   : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, left: 15.0, right: 15.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height *
                                        0.11,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(
                                          255, 183, 202, 212),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: ListTile(
                                  title: Text(
                                    sett[i]['title'].toString(),
                                  ),
                                  subtitle: Row(
                                    children:  [
                                      Text(sett[i]['date']
                                                  .toString() ==
                                              DateTime.now()
                                          ? "Today"
                                          : sett[i]['date']
                                              .toString()),
                                      Text(" - "),
                                      Text(sett[i]['time']
                                          .toString()),
                                    ],
                                  ),
                                  trailing: Transform.scale(
                                    scale: 1.2,
                                    child: SizedBox(
                                      child: Checkbox(
                                        side: const BorderSide(
                                            width: 1,
                                            color:
                                                ColorConst.kPrimaryColor),
                                        activeColor:
                                            ColorConst.kPrimaryColor,
                                        value: sett[i]['check'],
                                        onChanged: (v) async {
                                          sett[i]['check'] =
                                              !sett[i]['check'];

                                          await context
                                              .read<AddProvider>()
                                              .changeValue(
                                                  i,
                                                  sett[i]
                                                      ['check']);
                                          await context.read<AddProvider>().addToList();
                                          await context
                                              .read<AddProvider>()
                                              .deleteTodos(i);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ));
                        },
                        itemCount: sett.length,
                      ),
                    ),
                    )
                  
                ],
              ),
            );
          }
        },
      ),
    );
  }
}