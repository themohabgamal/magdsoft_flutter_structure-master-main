// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magdsoft_flutter_structure/business_logic/home/bloc/home_bloc.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/remote/http_helper.dart';
import 'package:magdsoft_flutter_structure/data/network/responses/product_response.dart';
import 'package:magdsoft_flutter_structure/presentation/widget/custom_grid_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                child: Image.asset(
                  "assets/images/overlay.png",
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Search',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipOval(
                                child: Material(
                                  color: Colors.grey.shade300, // button color
                                  child: InkWell(
                                    splashColor: Colors.grey, // inkwell color
                                    child: const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.filter_list,
                                        size: 30.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/header.png',
                            fit: BoxFit.fill,
                            height: 160,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                        height: 60.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: myItemList.length,
                          padding: const EdgeInsets.only(left: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.7),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      myItemList[index]['imageUrl'],
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text('${myItemList[index]['name']}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Recommended for you',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SizedBox(
                          height: 300.0,
                          child: FutureBuilder<ProductsResponseModel>(
                            future: HttpHelper.getProducts(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                    child: Text(
                                        "Error fetching data from server ${snapshot.error.toString()}"));
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 6 / 10,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 8),
                                  itemBuilder: (context, index) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                  itemCount: 6,
                                );
                              } else if (snapshot.hasData) {
                                return GridView.builder(
                                  padding: const EdgeInsets.all(10),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 6 / 9,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: 0),
                                  itemBuilder: (context, index) {
                                    return CustomGridItem(
                                        product:
                                            snapshot.data!.products![index]);
                                  },
                                  itemCount: snapshot.data!.products!.length,
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> myItemList = [
    {
      'name': 'All',
      'imageUrl': 'assets/images/all.png',
    },
    {
      'name': 'Acer',
      'imageUrl': 'assets/images/logo3.png',
    },
    {
      'name': 'Razor',
      'imageUrl': 'assets/images/razer.png',
    },
    {
      'name': 'Apple',
      'imageUrl': 'assets/images/apple.png',
    },
  ];
}
