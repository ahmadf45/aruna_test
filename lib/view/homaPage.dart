import 'dart:developer';

import 'package:aruna_test/controller/cHomePage.dart';
import 'package:aruna_test/view/detailPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textController = new TextEditingController();
  List<dynamic> listData = [];
  List<dynamic> filteredData = [];
  bool _successGettingData = false;

  _getData(BuildContext context) async {
    var res = await ControllerHome().getData(context);
    if (res != false) {
      setState(() {
        listData = res;
        filteredData = res;
        _successGettingData = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                width: screenSize.width,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: _textController,
                        onChanged: (value) {
                          if (value.length > 2) {
                            //print(value);
                            var rr = listData
                                .where((dat) =>
                                    dat["title"].toLowerCase().contains(value))
                                .toList();
                            setState(() {
                              filteredData = rr;
                            });
                            //print("total : " + rr.length.toString());
                          } else {
                            setState(() {
                              filteredData = listData;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                          hintText: 'Input keyword',
                          hintStyle: TextStyle(color: Colors.blueGrey),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              _successGettingData
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: filteredData.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          data: filteredData[index],
                                        )),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                //border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black54.withOpacity(0.2),
                                      spreadRadius: 0.1,
                                      blurRadius: 2,
                                      offset: Offset(0, 1))
                                ],
                              ),
                              child: Text(
                                filteredData[index]['title'].toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
