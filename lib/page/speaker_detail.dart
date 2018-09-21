import 'package:flutter/material.dart';
import 'package:mtc2018_app/graphql/speaker.dart';
import 'package:mtc2018_app/widget/social_user_button.dart';
import 'package:mtc2018_app/colors.dart';

class SpeakerDetailPage extends StatelessWidget {
  final Speaker speaker;

  const SpeakerDetailPage({Key key, this.speaker}) : super(key: key);

  Widget buildBody(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
            child: buildSpeakerInformation(context),
          )
        ]));
  }

  Widget buildSpeakerInformation(BuildContext context) {
    Locale currentLocale = Localizations.localeOf(context);
    var profile = currentLocale.languageCode == "ja"
        ? speaker.profileJa
        : speaker.profile;
    var name =
        currentLocale.languageCode == "ja" ? speaker.nameJa : speaker.name;
    var position = currentLocale.languageCode == "ja"
        ? speaker.positionJa
        : speaker.position;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                  child: ListTile(
                contentPadding: const EdgeInsets.all(0.0),
                leading: CircleAvatar(
                  backgroundImage: new NetworkImage(speaker.iconUrl),
                  radius: 25.0,
                ),
                title: Text(name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kMtcPrimaryGrey,
                        fontSize: 18.0)),
                subtitle: Text(position,
                    style: TextStyle(color: kMtcPrimaryGrey, fontSize: 12.0)),
                // trailing: IconButton(icon: const Icon(Icons.favorite_border), color: Colors.black, onPressed: () { AlertDialog(title: Text('Go to the session!'), content: Text('Hey!')); }),
              ))),
          Container(
              margin: const EdgeInsets.only(bottom: 24.0),
              child: Text(profile,
                  style: TextStyle(color: kMtcPrimaryGrey, fontSize: 14.0))),
          buildLinkButtons(speaker)
        ]);
  }

  Widget buildLinkButtons(Speaker speaker) {
    var twitterId = speaker.twitterId;
    var githubId = speaker.githubId;
    var twitterLinkButton = SocialUserButton(
        title: "@$twitterId",
        type: SocialType.twitter,
        url: "https://twitter.com/$twitterId");
    var githubLinkButton = SocialUserButton(
        title: "$githubId",
        type: SocialType.github,
        url: "https://github.com/$githubId");

    return Container(
        padding: const EdgeInsets.all(24.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kMtcAboutSectionBackgroundGrey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [githubLinkButton, twitterLinkButton]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(speaker.name),
          centerTitle: false,
        ),
        body: buildBody(context));
  }
}
