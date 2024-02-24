import 'package:flutter/material.dart';

class SearchBarModel extends StatefulWidget {
  const SearchBarModel({Key? key}) : super(key: key);

  @override
  State<SearchBarModel> createState() => _SearchBarModelState();
}

class _SearchBarModelState extends State<SearchBarModel> {
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  width: _folded ? 56 : 300,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                    boxShadow: kElevationToShadow[6],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 16),
                          child: !_folded
                              ? TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: "Search..",
                              hintStyle: TextStyle(
                                color: Colors.grey[300],
                              ),
                            ),
                          )
                              : TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: "",
                              hintStyle: TextStyle(
                                color: (Colors.blue[300]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(_folded ? 32 : 0),
                              topRight: Radius.circular(32),
                              bottomLeft: Radius.circular(_folded ? 32 : 0),
                              bottomRight: Radius.circular(32),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(
                                _folded ? Icons.search : Icons.close,
                                color: Colors.blue[900],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                _folded = !_folded;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
