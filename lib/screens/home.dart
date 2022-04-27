import 'package:flutter/material.dart';
import 'package:taska/services/notification_service.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({ Key? key }) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Container(

      ),
      floatingActionButton: FloatingActionButton(
        child: Text("Test"),
        onPressed: () async {
          await NotificationService().showNotification(id: 0, title: "Bildirishnoma", body: "Button bosildi");
          setState(() {
            
          });
        }

      ),
    );
  }
}