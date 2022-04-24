import 'package:flutter/material.dart';
import 'package:taska/core/constants/colorconst.dart';

class PicTaskInfoWidget extends StatefulWidget {
  final String title;
  final String date;
  final int index;
  final String image;
  const PicTaskInfoWidget(
      {required this.image,required this.date, required this.index, required this.title, Key? key})
      : super(key: key);

  @override
  State<PicTaskInfoWidget> createState() => _PicTaskInfoWidgetState();
}

class _PicTaskInfoWidgetState extends State<PicTaskInfoWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(15.0),
      // height: size.height * 0.3,
      // width: size.width * 0.8,
      decoration: BoxDecoration(
          boxShadow:  [
            BoxShadow(
                color: Color.fromARGB(255, 219, 230, 236),
                blurRadius: 10,
                spreadRadius: 3,
                offset: Offset(0, 10))
          ],
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white),
      child: Column(
        children: [
          Expanded(
            flex: 3,
              child: Container(
            decoration: BoxDecoration(
                color: ColorConst.kPrimaryColor,
                image: DecorationImage(image: NetworkImage(widget.image), fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
          )),
          Expanded(
            flex: 2,
              child: SizedBox(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      const Spacer(),
                      Icon(Icons.more_horiz)
                    ],
                  ),
                  Text(
                    widget.date,
                    style: const TextStyle(
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}