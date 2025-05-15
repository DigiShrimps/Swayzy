import 'package:flutter/material.dart';
import 'order_card_in_process.dart';

class InProcessGrid extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> ordersFuture;

  const InProcessGrid({super.key, required this.ordersFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ordersFuture,
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
            itemCount: data.length,
            itemBuilder: (context, index) {
              return OrderCardInProcess(
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
                social: data[index]["social"],
                subscribers: data[index]["amountOfSubscribers"],
                ownerId: data[index]["ownerId"],
                orderStatus: data[index]["status"],
                processId: data[index]["inProcessId"],
              );
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
