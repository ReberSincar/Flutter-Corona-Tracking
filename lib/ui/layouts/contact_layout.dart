import 'package:corona/utils/size_config.dart';
import 'package:corona/utils/styles.dart';
import 'package:corona/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactLayout extends StatefulWidget {
  @override
  _ContactLayoutState createState() => _ContactLayoutState();
}

class _ContactLayoutState extends State<ContactLayout> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils.getInstance();
    return Container(
      width: SizeConfig.getWidth() * 0.9,
      height: SizeConfig.getFlexibleValue(535),
      child: Card(
        elevation: SizeConfig.getFlexibleValue(10),
        color: Colors.grey.shade800,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                color: Colors.redAccent,
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getFlexibleValue(10)),
                child: Text(
                  utils.getTranslatedText(context, "ContactCaption"),
                  style: adviceTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              CircleAvatar(
                maxRadius: SizeConfig.getFlexibleValue(80),
                backgroundImage:
                    AssetImage("assets/images/contact_picture.jpg"),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getFlexibleValue(50)),
                child: RaisedButton(
                  color: Colors.redAccent,
                  elevation: SizeConfig.getFlexibleValue(10),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.verified_user),
                      SizedBox(
                        width: SizeConfig.getFlexibleValue(10),
                      ),
                      Text(
                        "Reber SİNCAR",
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getFlexibleValue(50)),
                child: RaisedButton(
                  color: Colors.redAccent,
                  elevation: SizeConfig.getFlexibleValue(10),
                  onPressed: _sendEmail,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.email),
                      SizedBox(
                        width: SizeConfig.getFlexibleValue(10),
                      ),
                      Text(
                        "rebersincar07@gmail.com",
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getFlexibleValue(50)),
                child: RaisedButton(
                  color: Colors.redAccent,
                  elevation: SizeConfig.getFlexibleValue(10),
                  onPressed: () {
                    _launchUrl('https://www.github.com/ReberSincar');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.github),
                      SizedBox(
                        width: SizeConfig.getFlexibleValue(10),
                      ),
                      Text(
                        "Github.com/ReberSincar",
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.getFlexibleValue(50)),
                child: RaisedButton(
                  elevation: SizeConfig.getFlexibleValue(10),
                  color: Colors.redAccent,
                  onPressed: () {
                    _launchUrl(
                        'https://www.linkedin.com/in/reber-sincar-a7b29117a/');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.linkedin),
                      SizedBox(
                        width: SizeConfig.getFlexibleValue(10),
                      ),
                      Text(
                        "Linkedin.com/ReberSincar",
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchUrl(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendEmail() async {
    final Email email = Email(
      subject: 'Contact For Corona Tracking Application',
      recipients: ['rebersincar07@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}
