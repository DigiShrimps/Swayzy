import 'package:flutter/material.dart';
import '../../../constants/app_text_styles.dart';
import '../mocks/category.mocks.dart';
import 'order_card.dart';

class InSearchGrid extends StatefulWidget {
  final Future<List<Map<String, dynamic>>> ordersFuture;
  const InSearchGrid({super.key, required this.ordersFuture});

  @override
  State<InSearchGrid> createState() => _InSearchGridState();
}

class _InSearchGridState extends State<InSearchGrid> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
          ),
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            final category = orderCategories[index];
            return InkWell(
              onTap: () {
                setState(() {
                  selectedCategory = category.id;
                });
              },
              borderRadius: BorderRadius.circular(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(category.pathToImage, width: 36, height: 36, fit: BoxFit.fitHeight),
                  Text(category.title, style: AppTextStyles.orderCategory),
                ],
              ),
            );
          },
        ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: widget.ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data as List<Map<String, dynamic>>;
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
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
    );
  }
}
