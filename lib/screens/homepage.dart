import 'package:flutter/material.dart';
import 'package:taska/core/constants/colorconst.dart';
import 'package:taska/pages/add_page.dart';
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
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(color: Colors.red,),
          AddPage(),
          Container(color: Colors.green,),
        ],
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: ColorConst.kPrimaryColor,
        labelColor: ColorConst.kPrimaryColor,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.add)),
          Tab(icon: Icon(Icons.verified_user)),
        ]
      ),
    );
  }
}