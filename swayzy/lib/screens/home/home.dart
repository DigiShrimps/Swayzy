import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/screens/home/widgets/in_process_grid.dart';
import 'package:swayzy/screens/home/widgets/in_search_grid.dart';

import '../../global_widgets/animated_button.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser!;
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  late Future<List<Map<String, dynamic>>> _ordersFuture;
  late Future<List<Map<String, dynamic>>> _adsFuture;
  String _userId = '';

  @override
  void initState() {
    super.initState();
    _userId = user.uid;
    _ordersFuture = getOrderData();
    _adsFuture = getAdsForUser(_userId);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.homeTitle;

    return Scaffold(
      appBar: CustomAppBar(title: titleText),
      body: Column(
        children: [
          AnimatedButtons<int>(
            firstLabel: localizations.searchButton,
            secondLabel: localizations.processButton,
            currentMode: _currentPageIndex,
            leftMode: 0,
            rightMode: 1,
            onChanged: (index) {
              setState(() => _currentPageIndex = index);
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    setState(() {_ordersFuture = getOrderData();});
                  },
                  child: InSearchGrid(ordersFuture: _ordersFuture),
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    setState(() {_adsFuture = getAdsForUser(_userId);});
                  },
                  child: InProcessGrid(ordersFuture: _adsFuture),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getAdsForUser(String userId) async {
    CollectionReference inProcessRef = FirebaseFirestore.instance.collection('inProcess');
    CollectionReference adsRef = FirebaseFirestore.instance.collection('ads');
    QuerySnapshot inProcessSnapshot = await inProcessRef.where('userId', isEqualTo: userId).get();
    List<Map<String, dynamic>> adsData = [];
    for (var doc in inProcessSnapshot.docs) {
      String inProcessId = doc.id;
      String adId = doc['adId'];
      String status = doc['status'];
      DocumentSnapshot adDoc = await adsRef.doc(adId).get();
      if (adDoc.exists) {
        Map<String, dynamic> adData = adDoc.data() as Map<String, dynamic>;
        adData['status'] = status;
        adData['inProcessId'] = inProcessId;
        adsData.add(adData);
      }
    }

    return adsData;
  }

  Future<List<Map<String, dynamic>>> getOrderData() async {
    QuerySnapshot querySnapshot =
    await firestoreInstance.collection('ads').orderBy('createdAt', descending: true).get();
    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }).toList();
  }
}
