import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/screens/explore/widgets/in_process_grid.dart';
import 'package:swayzy/screens/explore/widgets/in_search_grid.dart';

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
              child: currentMode == ViewMode.inSearch
                  ? InSearchGrid(ordersFuture: getOrderData())
                  : InProcessGrid(ordersFuture: getOrderData()),
            ),
          ),
        ],
      ),
    );
  }
}
