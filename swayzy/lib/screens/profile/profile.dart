import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:solana/solana.dart';
import 'package:swayzy/constants/app_colors.dart';
import 'package:swayzy/constants/app_text_styles.dart';
import 'package:swayzy/screens/profile/mocks/badge.mocks.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_button_styles.dart';
import '../../constants/app_spaces.dart';
import '../../l10n/app_localizations.dart';
import 'dialogs/confirm_deleting_account_dialog.dart';

class Profile extends StatefulWidget {
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
  User? user;

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  } // fix for Unhandled Exception: setState() called after dispose()

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _readSocial();
              _getBalance();
            });
          },
          child: SingleChildScrollView(
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
                    },
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
                    },
                  ),
                ),
                Center(
                  child: Column(
                    spacing: AppSpacing.small,
                    children: [
                      SizedBox(height: AppSpacing.small),
                      user != null
                          ? _buildUserAvatar(user!)
                          : CircularProgressIndicator(),
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
                          border: Border.all(
                            color: AppColors.highlight,
                            width: 2,
                          ),
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
                                    if (_instagramURL != null &&
                                        _instagramURL!.isNotEmpty) {
                                      _launchURL(_instagramURL!);
                                    } else {
                                      showErrorSnackbar(context, localizations);
                                    }
                                  },
                                ),
                                Text(
                                  "$_instagramFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.telegram),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    if (_telegramURL != null &&
                                        _telegramURL!.isNotEmpty) {
                                      _launchURL(_telegramURL!);
                                    } else {
                                      showErrorSnackbar(context, localizations);
                                    }
                                  },
                                ),
                                Text(
                                  "$_telegramFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.tiktok),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    if (_tiktokURL != null &&
                                        _tiktokURL!.isNotEmpty) {
                                      _launchURL(_tiktokURL!);
                                    } else {
                                      showErrorSnackbar(context, localizations);
                                    }
                                  },
                                ),
                                Text(
                                  "$_tiktokFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.facebook),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    if (_facebookURL != null &&
                                        _facebookURL!.isNotEmpty) {
                                      _launchURL(_facebookURL!);
                                    } else {
                                      showErrorSnackbar(context, localizations);
                                    }
                                  },
                                ),
                                Text(
                                  "$_facebookFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.reddit),
                                  iconSize: 50,
                                  color: AppColors.highlight,
                                  onPressed: () {
                                    if (_redditURL != null &&
                                        _redditURL!.isNotEmpty) {
                                      _launchURL(_redditURL!);
                                    } else {
                                      showErrorSnackbar(context, localizations);
                                    }
                                  },
                                ),
                                Text(
                                  "$_redditFollowers",
                                  style: AppTextStyles.body,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.highlight,
                            width: 2,
                          ),
                          color: AppColors.secondaryBackground,
                        ),
                        child: SizedBox(
                          // ця фігня буде перероблюватись
                          width: double.infinity,
                          child: Column(
                            spacing: AppSpacing.small,
                            children: [
                              SizedBox(width: AppSpacing.small),
                              Text(
                                "${localizations.balanceLabel}\n$_balance SOL",
                                style: AppTextStyles.title,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: AppSpacing.small),
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
                                  Clipboard.setData(
                                    ClipboardData(text: "$_publicKey"),
                                  );
                                },
                                child: Text("Copy address"),
                              ),
                              SizedBox(width: AppSpacing.small),
                            ],
                          ),
                        ),
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 8.0,
                          mainAxisExtent: 180,
                          childAspectRatio: 0.7,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appBadges.length,
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) {
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
                                  filterQuality: FilterQuality.high,
                                ),
                                SizedBox(height: 10),
                                Text(badge.title, style: AppTextStyles.form),
                              ],
                            ),
                          );
                        },
                      ),
                      ElevatedButton.icon(
                        style: AppButtonStyles.primary,
                        label: Text(localizations.exitButton),
                        icon: const Icon(Icons.logout_rounded),
                        onPressed: () async {
                          await signOutUser(context);
                        },
                      ),
                      ElevatedButton.icon(
                        style: AppButtonStyles.delete,
                        label: Text(localizations.deleteButton),
                        icon: const Icon(Icons.delete_rounded),
                        onPressed: () async {
                          showConfirmDeletingDialog(context);
                        },
                      ),
                      SizedBox(width: AppSpacing.medium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(User user) {
    final photoUrl = user.photoURL;
    if (photoUrl == null) {
      return const CircleAvatar(
        radius: 100,
        child: Icon(Icons.account_circle_rounded, size: 100),
      );
    }

    final highResUrl = _getHighResUserImage(photoUrl);

    return CircleAvatar(radius: 100, backgroundImage: NetworkImage(highResUrl));
  }

  String _getHighResUserImage(String photoUrl) {
    // завантаження аватару з кращим розширенням
    String lowResImageSuffix = "s96-c";
    String highResImageSuffix = "s400-c";

    return photoUrl.replaceFirst(lowResImageSuffix, highResImageSuffix);
  }

  Future<void> signOutUser(BuildContext context) async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    navigator.pushReplacementNamed('/auth');
  }

  void showConfirmDeletingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const ConfirmDeletingAccountDialog();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _readPk(user!);
    }
    _readSocial();
  }

  void showErrorSnackbar(BuildContext context, AppLocalizations localizations) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        duration: Duration(seconds: 2),
        content: Text(localizations.noConnectedSocialError, style: AppTextStyles.form),
      ),
    );
  }

  void _getBalance() async {
    setState(() {
      _balance = '...';
    });
    final getBalance = await client?.rpcClient.getBalance(
      _publicKey!,
      commitment: Commitment.confirmed,
    );
    final balance = (getBalance!.value) / lamportsPerSol;
    setState(() {
      _balance = balance.toString();
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

  _launchURL(String pageURL) async {
    final Uri url = Uri.parse(pageURL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _readPk(User user) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    final mnemonic = docSnapshot.data()?['mnemonic'];
    final keypair = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
    setState(() {
      _publicKey = keypair.address;
    });
    _initializeClient();
  }

  void _readSocial() async {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
      setState(() {
        _instagramFollowers =
            docSnapshot.data()?['InstagramFollowers'] ?? "N/A";
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
  }
}
