import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:solana/solana.dart';
import 'package:swayzy/constants/app_colors.dart';
import 'package:swayzy/constants/app_text_styles.dart';
import 'package:swayzy/screens/profile/mocks/badge.mocks.dart';

import '../../constants/app_button_styles.dart';
import '../../constants/app_spaces.dart';

class Profile extends StatefulWidget{
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? _publicKey;
  String? _balance;
  SolanaClient? client;

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  // Future<List<Map<String, dynamic>>> getOrderData() async {
  //   QuerySnapshot querySnapshot = await firestoreInstance.collection('users').get();
  //   return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  // }

  @override
  void initState() {
    super.initState();
    _readPk();
  }

  void _readPk() async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final mnemonic = docSnapshot.data()?['mnemonic'];
    final keypair = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
    setState(() {
      _publicKey = keypair.address;
    });
    _initializeClient();
  }

  void _initializeClient() async {
    await dotenv.load(fileName: "dotenv");

    client = SolanaClient(
      rpcUrl: Uri.parse(dotenv.env['QUICKNODE_RPC_URL'].toString()),
      websocketUrl: Uri.parse(dotenv.env['QUICKNODE_RPC_WSS'].toString()),
    );
    _getBalance();
  }

  void _getBalance() async {
    setState(() {
      _balance = '...';
    });
    final getBalance = await client?.rpcClient
        .getBalance(_publicKey!, commitment: Commitment.confirmed);
    final balance = (getBalance!.value) / lamportsPerSol;
    setState(() {
      _balance = balance.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photoURL = user?.photoURL;

    return SafeArea(
      child: Scaffold(
        body: user == null
          ? const Center(child: Text('Not logged in'))
          : SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.settings_rounded),
                    color: AppColors.highlight,
                    iconSize: 40,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/settings');
                    }
                  ),
                ),
                Positioned(
                  top: -10,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.notifications_rounded),
                    color: AppColors.highlight,
                    iconSize: 40,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/notifications');
                    }
                  ),
                ),
                Center(
                  child: Column(
                    spacing: AppSpacing.small,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
                        child: photoURL == null ? const Icon(Icons.account_circle_rounded) : null,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.sizeOf(context).width,
                        child: const EditableUserDisplayName(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.highlight, width: 2),
                          color: AppColors.secondaryBackground,
                        ),
                        child: Column(
                          spacing: AppSpacing.small,
                          children: [
                            SizedBox(width: AppSpacing.small,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Balance: $_balance SOL",
                                  style: AppTextStyles.title,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.refresh),
                                  onPressed: () {
                                    _getBalance();
                                  },
                                )
                              ],
                            ),
                            SizedBox(width: AppSpacing.small,),
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.sizeOf(context).width - 100,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: SelectableText(
                                "$_publicKey",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: "$_publicKey"));
                              },
                              child: Text("Скопіювати адресу"),
                            ),
                            SizedBox(width: AppSpacing.small,)
                          ],
                        ),
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 8.0,
                          mainAxisExtent: 180,
                          childAspectRatio: 0.7
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appBadges.length,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index){
                          final badge = appBadges[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            color: AppColors.secondaryBackground,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  badge.pathToImage,
                                  fit: BoxFit.fitHeight,
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  badge.title,
                                  style: AppTextStyles.form,
                                ),
                              ],
                            ),
                          );
                        }
                      ),
                      ElevatedButton.icon(
                        style: AppButtonStyles.primary,
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacementNamed('/auth');
                        },
                        label: const Text('Logout'),
                        icon: const Icon(Icons.logout_rounded),
                      ),
                      ElevatedButton.icon(
                        style: AppButtonStyles.delete,
                        onPressed: () async {
                          await user.delete();
                          await FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacementNamed('/auth');
                        },
                        label: const Text('Delete account'),
                        icon: const Icon(Icons.delete_rounded),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
      ),
    );
  }
}