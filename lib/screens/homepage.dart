import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/pages/add_page.dart';
import 'package:taska/pages/profile_page.dart';
import 'package:taska/pages/second_home_page.dart';
import 'package:taska/services/firebase/fire_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    debugPrint(FireService.auth.currentUser!.email.toString());
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        controller: _tabController,
        children: [
          SecondHomePage(),
          AddPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: ColorConst.kPrimaryColor,
        labelColor: ColorConst.kPrimaryColor,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(icon: Icon(FontAwesomeIcons.home)),
          Tab(icon: Icon(FontAwesomeIcons.plus)),
          Tab(icon: Icon(FontAwesomeIcons.user)),
        ]
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     showModalBottomSheet(
      //       context: context, 
      //       isScrollControlled: true,
      //       builder: (v){
            
      //       return SafeArea(
      //         child: SizedBox(
      //           height: MediaQuery.of(context).size.height * 0.95,
      //           // width: MediaQuery.of(context).size.width,
      //           child: AddPage()),
      //       );
      //     });
      //   }
      // ),
    );
  }
  
}