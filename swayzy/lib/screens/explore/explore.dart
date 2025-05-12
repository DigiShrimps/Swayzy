import 'package:flutter/material.dart';
import 'package:swayzy/screens/explore/mocks/category.mocks.dart';

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
          Expanded(
            child: ListView(
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.9,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final category = orderCategories[index];
                    return InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(20),
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
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(

                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
