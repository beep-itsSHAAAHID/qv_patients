import 'package:flutter/material.dart';
import 'package:qv_patient/constants/colors.dart';
import 'package:qv_patient/helper/doc_helper_function.dart';

class SearchBarModel extends StatefulWidget {
  const SearchBarModel({super.key});

  @override
  State<SearchBarModel> createState() => _SearchBarModelState();
}

class _SearchBarModelState extends State<SearchBarModel> {
  bool _folded = true;

  @override
  Widget build(BuildContext context) {
    final dark = DocHelperFunctions.isDarkMode(context);
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: _folded ? 56 : 200,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: dark ? TColors.dark : TColors.light,
                    boxShadow: kElevationToShadow[6],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 16),
                          child: !_folded
                              ? const TextField(
                                  decoration: InputDecoration.collapsed(
                                    border: InputBorder.none,
                                    hintText: "Search..",
                                    hintStyle: TextStyle(
                                      color: TColors.light,
                                    ),
                                  ),
                                )
                              : TextField(
                                  decoration: InputDecoration.collapsed(
                                    border: InputBorder.none,
                                    hintText: "",
                                    hintStyle: TextStyle(
                                      color: (Colors.blue[300]),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(_folded ? 32 : 0),
                              topRight: const Radius.circular(32),
                              bottomLeft: Radius.circular(_folded ? 32 : 0),
                              bottomRight: const Radius.circular(32),
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
