import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swayzy/constants/app_font_sizes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../global_widgets/custom_app_bar.dart';
import '../../l10n/app_localizations.dart';
import 'dialogs/change_social_info_dialog.dart';

const String githubDiscussionsURL =
    "https://github.com/DigiShrimps/Swayzy/discussions";
const String githubCodeURL =
    "https://github.com/DigiShrimps/Swayzy";
bool areNotificationsEnabled = true;

const Map<String, String> languages = {'en': 'English', 'uk': 'Українська'};
final languagesItems = languages.entries
    .map((lan) => DropdownMenuItem<String>(
  value: lan.key,
  child: Text(lan.value),
))
    .toList();

class Settings extends StatefulWidget {
  final Function(String) onLocaleToggle;
  const Settings({super.key, required this.onLocaleToggle});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? selectedLanguage;

  void _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('language') ?? 'en';
    setState(() {
      selectedLanguage = savedLang;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final String titleText = localizations.settingsTitle;
    final subject = localizations.supportSubject;
    final message = localizations.supportMessage;

    return Scaffold(
      appBar: CustomAppBar(title: titleText,),
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
            title: Text(localizations.settingsSectionCommon, style: AppTextStyles.buttonSecondary),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: Text(localizations.languageTitle, style: AppTextStyles.setting, softWrap: false,
                  overflow: TextOverflow.visible,),
                trailing: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true, // щоб меню не виходило за рамки кнопки
                    child: DropdownButton<String>(
                        value: selectedLanguage,
                        style: AppTextStyles.form,
                        icon: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.secondaryText,
                        ),
                        dropdownColor: AppColors.highlight,
                        alignment: Alignment.center,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(20)),
                        onChanged: (String? value) {
                          if (value != null && value != selectedLanguage) {
                            widget.onLocaleToggle(value);
                            setState(() {
                              selectedLanguage = value;
                            });
                          }
                        },
                        items: languagesItems),
                  ),
                ),
              ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.notifications_rounded),
                title: Text(localizations.notifications, style: AppTextStyles.setting),
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
            title: Text(localizations.socialSectionCommon, style: AppTextStyles.buttonSecondary),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.instagram),
                title: Text('Instagram', style: AppTextStyles.setting),
                onPressed: (context) {
                  showChangeSocialInfoDialog(context, 'Instagram');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.telegram),
                title: Text('Telegram', style: AppTextStyles.setting),
                onPressed: (context) {
                  showChangeSocialInfoDialog(context, 'Telegram');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.tiktok),
                title: Text('TikTok', style: AppTextStyles.setting),
                onPressed: (context) {
                  showChangeSocialInfoDialog(context, 'TikTok');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.facebook),
                title: Text('Facebook', style: AppTextStyles.setting),
                onPressed: (context) {
                  showChangeSocialInfoDialog(context, 'Facebook');
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(FontAwesomeIcons.reddit),
                title: Text('Reddit', style: AppTextStyles.setting),
                onPressed: (context) {
                  showChangeSocialInfoDialog(context, 'Reddit');
                },
                // (context) {
                //   Navigator.of(
                //     context,
                //   ).pushNamed('/socialDialog', arguments: 'Reddit');
                // },
              ),
            ],
          ),
          SettingsSection(
            title: Text(localizations.settingsSectionAbout, style: AppTextStyles.buttonSecondary),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: const Icon(Icons.folder_zip_rounded),
                title: Text('GitHub', style: AppTextStyles.setting),
                description: Text(
                  localizations.githubText,
                  style: AppTextStyles.smallDescription,
                ),
                onPressed:
                    (context) async =>
                        _launchURL(githubCodeURL),
              ),
              SettingsTile(
                leading: const Icon(Icons.support_rounded),
                title: Text(localizations.supportTitle, style: AppTextStyles.setting),
                description: Text(
                  localizations.supportText,
                  style: AppTextStyles.smallDescription,
                ),
                onPressed: (context) async => _sendingMails(subject, message),
              ),
              SettingsTile(
                leading: const Icon(Icons.feedback_rounded),
                title: Text(localizations.feedbackTitle, style: AppTextStyles.setting),
                description: Text(
                  localizations.feedbackText,
                  style: AppTextStyles.smallDescription,
                ),
                onPressed:
                    (context) async => _launchURL(githubDiscussionsURL),
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
          TextSpan(
            children: [
              const WidgetSpan(
                child: Icon(
                  Icons.copyright_rounded,
                  color: AppColors.highlight,
                ),
              ),
              TextSpan(text: localizations.copyright),
            ],
          ),
        ),
      ),
    );
  }

  dynamic showChangeSocialInfoDialog(BuildContext context, String socialName) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ChangeSocialInfoDialog(socialName: socialName,);
      },
    );
  }

  _launchURL(String pageURL) async {
    final Uri url = Uri.parse(pageURL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _sendingMails(String subject, String message) async {
    var mailId = "digishrimps@gmail.com";
    await launchUrl(Uri.parse("mailto:$mailId?subject=$subject&body=$message"));
  }
}
