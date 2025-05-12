import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/screens/explore/mocks/category.mocks.dart';
import 'package:swayzy/screens/explore/widgets/order_card.dart';

import '../../constants/app_button_styles.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

const String _titleText = "Home";

enum ViewMode { inSearch, inProcess }

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  ViewMode currentMode = ViewMode.inSearch;
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getOrderData() async {
    QuerySnapshot querySnapshot = await firestoreInstance.collection('ads').get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    final orders = currentMode == ViewMode.inSearch ? "data" : "data";

    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleText),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentMode = ViewMode.inSearch;
                    });
                  },
                  style: AppButtonStyles.chat,
                  child: Text("In Search", style: AppTextStyles.buttonPrimary),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentMode = ViewMode.inProcess;
                    });
                  },
                  style: AppButtonStyles.chat,
                  child: Text("In Process", style: AppTextStyles.buttonPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: ListView(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.2,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final category = orderCategories[index];
                      return InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(category.pathToImage, width: 36, height: 36, fit: BoxFit.fitHeight),
                            Text(category.title, style: AppTextStyles.orderCategory),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: getOrderData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List data = snapshot.data as List<Map<String, dynamic>>;
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: MediaQuery.of(context).size.width < 370 ? 0.7 : 1.0,
                          ),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return OrderCard(
                              ownerName: data[index]["ownerName"],
                              imageUrl: data[index]["imageUrl"],
                              price: data[index]["price"],
                              title: data[index]["title"],
                              createdAt: data[index]["createdAt"],
                              category: data[index]["category"],
                              duration: data[index]["duration"],
                              ownerEmail: data[index]["ownerEmail"],
                              description: data[index]["description"],
                              reviewType: data[index]["reviewType"],
                              ownerId: data[index]["ownerId"],
                            );
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
