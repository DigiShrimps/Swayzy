import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:swayzy/constants/app_font_sizes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';

const String _titleText = "Settings";

bool areNotificationsEnabled = true;

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _titleText,),
      body: SettingsList(
        lightTheme: const SettingsThemeData(
          settingsListBackground: AppColors.primaryBackground,
          leadingIconsColor: AppColors.accent,
          titleTextColor: AppColors.text,
          settingsTileTextColor: AppColors.text,
          settingsSectionBackground: AppColors.secondaryBackground,
        ),
        darkTheme: const SettingsThemeData(
          settingsListBackground: AppColors.primaryBackground,
          leadingIconsColor: AppColors.accent,
          titleTextColor: AppColors.text,
          settingsTileTextColor: AppColors.text,
          settingsSectionBackground: AppColors.secondaryBackground,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        sections: [
          SettingsSection(
            title: Text('Common', style: AppTextStyles.buttonSecondary),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: Text('Language', style: AppTextStyles.setting),
                trailing: Text('English', style: AppTextStyles.setting),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.contrast_rounded),
                title: Text('Theme', style: AppTextStyles.setting),
                trailing: Text('Dark', style: AppTextStyles.setting),
              ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.notifications_rounded),
                title: Text('Notifications', style: AppTextStyles.setting),
                activeSwitchColor: AppColors.highlight,
                initialValue: areNotificationsEnabled,
                onToggle: (bool isEnabled) {
                  setState(() {
                    areNotificationsEnabled = isEnabled;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('Social', style: AppTextStyles.buttonSecondary),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.instagram),
                title: Text('Instagram', style: AppTextStyles.setting),
                onPressed: (context) {
                  Navigator.of(
                    context,
                  ).pushNamed('/socialDialog', arguments: 'Instagram');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.telegram),
                title: Text('Telegram', style: AppTextStyles.setting),
                onPressed: (context) {
                  Navigator.of(
                    context,
                  ).pushNamed('/socialDialog', arguments: 'Telegram');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.tiktok),
                title: Text('TikTok', style: AppTextStyles.setting),
                onPressed: (context) {
                  Navigator.of(
                    context,
                  ).pushNamed('/socialDialog', arguments: 'TikTok');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.facebook),
                title: Text('Facebook', style: AppTextStyles.setting),
                onPressed: (context) {
                  Navigator.of(
                    context,
                  ).pushNamed('/socialDialog', arguments: 'Facebook');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.reddit),
                title: Text('Reddit', style: AppTextStyles.setting),
                onPressed: (context) {
                  Navigator.of(
                    context,
                  ).pushNamed('/socialDialog', arguments: 'Reddit');
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text('About', style: AppTextStyles.buttonSecondary),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: const Icon(Icons.folder_zip_rounded),
                title: Text('GitHub', style: AppTextStyles.setting),
                description: Text(
                  "GitHub repository for a project",
                  style: AppTextStyles.smallDescription,
                ),
                onPressed:
                    (context) async =>
                        _launchURL("https://github.com/DigiShrimps/Swayzy"),
              ),
              SettingsTile(
                leading: const Icon(Icons.support_rounded),
                title: Text('Support', style: AppTextStyles.setting),
                description: Text(
                  "Write us if you have any questions",
                  style: AppTextStyles.smallDescription,
                ),
                onPressed: (context) async => _sendingMails(),
              ),
              SettingsTile(
                leading: const Icon(Icons.feedback_rounded),
                title: Text('Feedback', style: AppTextStyles.setting),
                description: Text(
                  "Write if you have any suggestions or complaints",
                  style: AppTextStyles.smallDescription,
                ),
                onPressed:
                    (context) async => _launchURL(
                      "https://github.com/DigiShrimps/Swayzy/discussions",
                    ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.primaryBackground,
        height: AppFontSizes.title * 2,
        child: Text.rich(
          style: AppTextStyles.body,
          textAlign: TextAlign.center,
          const TextSpan(
            children: [
              WidgetSpan(
                child: Icon(
                  Icons.copyright_rounded,
                  color: AppColors.highlight,
                ),
              ),
              TextSpan(text: " Developed by DigiShrimps"),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String pageURL) async {
    final Uri url = Uri.parse(pageURL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  _sendingMails() async {
    var mailId = "digishrimps@gmail.com";
    var subject = "[Swayzy Support] *Topic of question*";
    var message = "Hello! I have question about the app: ";
    await launchUrl(Uri.parse("mailto:$mailId?subject=$subject&body=$message"));
  }
}
