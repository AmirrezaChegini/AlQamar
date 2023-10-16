import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizeExt on String {
  String localize(BuildContext context) {
    String text = this;
    switch (text) {
      case 'liveBroadcast':
        return AppLocalizations.of(context)!.liveBroadcast;
      case 'latestNews':
        return AppLocalizations.of(context)!.latestNews;
      case 'news':
        return AppLocalizations.of(context)!.news;
      case 'instant':
        return AppLocalizations.of(context)!.instant;
      case 'readMore':
        return AppLocalizations.of(context)!.readMore;
      case 'newsList':
        return AppLocalizations.of(context)!.newsList;
      case 'todayMention':
        return AppLocalizations.of(context)!.todayMention;
      case 'about':
        return AppLocalizations.of(context)!.about;
      case 'result':
        return AppLocalizations.of(context)!.result;
      case 'home':
        return AppLocalizations.of(context)!.home;
      case 'topics':
        return AppLocalizations.of(context)!.topics;
      case 'search':
        return AppLocalizations.of(context)!.search;
      case 'subscribe':
        return AppLocalizations.of(context)!.subscribe;
      case 'works':
        return AppLocalizations.of(context)!.works;
      case 'noInternetConnection':
        return AppLocalizations.of(context)!.noInternetConnection;
      case 'tryagain':
        return AppLocalizations.of(context)!.tryagain;
      case 'photo':
        return AppLocalizations.of(context)!.photo;
      case 'video':
        return AppLocalizations.of(context)!.video;
      case 'youtube':
        return AppLocalizations.of(context)!.youtube;
      case 'audio':
        return AppLocalizations.of(context)!.audio;
      case 'document':
        return AppLocalizations.of(context)!.document;
      case 'similarNews':
        return AppLocalizations.of(context)!.similarNews;
      case 'internetError':
        return AppLocalizations.of(context)!.internetError;
      default:
        return '';
    }
  }
}
