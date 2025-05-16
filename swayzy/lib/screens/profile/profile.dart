import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solana/solana.dart';
import 'package:swayzy/constants/app_colors.dart';
import 'package:swayzy/constants/app_text_styles.dart';
import 'package:swayzy/screens/profile/mocks/badge.mocks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String? _instagramFollowers;
  String? _instagramURL;
  String? _telegramFollowers;
  String? _telegramURL;
  String? _tiktokFollowers;
  String? _tiktokURL;
  String? _facebookFollowers;
  String? _facebookURL;
  String? _redditFollowers;
  String? _redditURL;

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _readPk();
    _readSocial();
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

  void _readSocial() async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      _instagramFollowers = docSnapshot.data()?['InstagramFollowers'] ?? "N/A";
      _instagramURL = docSnapshot.data()?['InstagramURL'];
      _telegramFollowers = docSnapshot.data()?['TelegramFollowers'] ?? "N/A";
      _telegramURL = docSnapshot.data()?['TelegramURL'];
      _tiktokFollowers = docSnapshot.data()?['TiktokFollowers'] ?? "N/A";
      _tiktokURL = docSnapshot.data()?['TiktokURL'];
      _facebookFollowers = docSnapshot.data()?['FacebookFollowers'] ?? "N/A";
      _facebookURL = docSnapshot.data()?['FacebookURL'];
      _redditFollowers = docSnapshot.data()?['RedditFollowers'] ?? "N/A";
      _redditURL = docSnapshot.data()?['RedditURL'];
    });
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

  _launchURL(String pageURL) async {
    final Uri _url = Uri.parse(pageURL);
    if (!await launchUrl(_url)) {
      throw Exception(
        'Could not launch $_url',
      );
    }
  }

  void showErrorSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        duration: Duration(seconds: 2),
        content: Text("Social isn't connected", style: AppTextStyles.form),
      ),
    );
  }

  Future<void> deleteUser(User user, BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await user.reauthenticateWithCredential(credential);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .delete();
    await user.delete();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/auth');
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
                      SizedBox(width: AppSpacing.small,),
                      CircleAvatar(
                        radius: 105,
                        backgroundColor: AppColors.accent,
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
                          child: photoURL == null ? const Icon(Icons.account_circle_rounded) : null,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.sizeOf(context).width,
                        child: const EditableUserDisplayName(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.sizeOf(context).width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.highlight, width: 2),
                          color: AppColors.secondaryBackground,
                        ),
                        child: Wrap(
                          spacing: AppSpacing.small,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          runSpacing: AppSpacing.small,
                          children: [
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.instagram),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    if(_instagramURL != null && _instagramURL!.isNotEmpty) {
                                      _launchURL(_instagramURL!);
                                    } else {
                                    showErrorSnackbar(context);
                                    }
                                  },
                                ),
                                Text(
                                  "$_instagramFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.telegram),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    if(_telegramURL != null && _telegramURL!.isNotEmpty) {
                                      _launchURL(_telegramURL!);
                                    } else {
                                      showErrorSnackbar(context);
                                    }
                                  },
                                ),
                                Text(
                                  "$_telegramFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.tiktok),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    if(_tiktokURL != null && _tiktokURL!.isNotEmpty) {
                                      _launchURL(_tiktokURL!);
                                    } else {
                                      showErrorSnackbar(context);
                                    }
                                  },
                                ),
                                Text(
                                  "$_tiktokFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.facebook),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    if(_facebookURL != null && _facebookURL!.isNotEmpty) {
                                      _launchURL(_facebookURL!);
                                    } else {
                                      showErrorSnackbar(context);
                                    }
                                  },
                                ),
                                Text(
                                  "$_facebookFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.reddit),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    print(_redditURL);
                                    if(_redditURL != null && _redditURL!.isNotEmpty) {
                                      _launchURL(_redditURL!);
                                    } else {
                                      showErrorSnackbar(context);
                                    }
                                  },
                                ),
                                Text(
                                  "$_redditFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ],
                        )
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
                                  "Balance:\n$_balance SOL",
                                  style: AppTextStyles.title,
                                  textAlign: TextAlign.center,
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
                              child: Text("Copy address"),
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
                          await deleteUser(user, context);
                        },
                        label: const Text('Delete account'),
                        icon: const Icon(Icons.delete_rounded),
                      ),
                      SizedBox(width: AppSpacing.medium,),
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