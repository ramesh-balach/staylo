
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../utils/components/display_place.dart';
import '../../utils/components/display_total_price.dart';
import '../../utils/components/map_with_custom_windows.dart';
import '../../utils/components/search_bar_and_filter.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  // collection for category
  final CollectionReference categoryCollection =
  FirebaseFirestore.instance.collection("AppCategory");

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.01,),
            // for search bar and filter button
            const SearchBarAndFilter(),
            // let's fetch list of category items from firebase.
            listOfCategoryItems(size),
            const Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // for switch button
                    DisplayTotalPrice(),
                    SizedBox(height: 15),
                    // displat the place items
                    DisplayPlace(),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // for google map
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MapWithCustomInfoWindows(),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> listOfCategoryItems(Size size) {
    return StreamBuilder(
      stream: categoryCollection.snapshots(),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.hasData) {
          return Stack(
            children: [
              const Positioned(
                left: 0,
                right: 0,
                top: 80,
                child: Divider(
                  color: Colors.black12,
                ),
              ),
              SizedBox(
                height: size.height * 0.12,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: streamSnapshot.data!.docs.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 20,
                          left: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 32,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                streamSnapshot.data!.docs[index]['image'],
                                color: selectedIndex == index
                                    ? Colors.black
                                    : Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              streamSnapshot.data!.docs[index]['title'],
                              style: TextStyle(
                                fontSize: 13,
                                color: selectedIndex == index
                                    ? Colors.black
                                    : Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 3,
                              width: 50,
                              color: selectedIndex == index
                                  ? Colors.black
                                  : Colors.transparent,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
