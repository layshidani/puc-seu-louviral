// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:seu_lourival/app/data/models/user_model.dart';
import 'package:seu_lourival/core/utils/datetime_helper.dart';
import 'package:seu_lourival/core/values/text_size.dart';

class ReportModel {
  final String? id;
  final String author;
  final String title;
  final String description;
  final String photoURL;
  final String createdAt;
  final String updatedAt;
  final bool isPrivate;
  final String phone;
  String category;
  String status;
  HomeData homeData;

  ReportModel({
    this.id,
    this.author = '',
    this.title = '',
    this.description = '',
    this.photoURL = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.isPrivate = true,
    this.status = '',
    this.category = '',
    required this.phone,
    required this.homeData,
  });

  set setReportStatus(String status) {
    this.status = status;
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
        id: json['id'],
        author: json['author'],
        title: json['title'],
        description: json['description'],
        photoURL: json['photoURL'],
        createdAt: DateTimeHelper.fromTimeStamp(json['createdAt']),
        updatedAt: DateTimeHelper.fromTimeStamp(json['updatedAt']),
        isPrivate: json['isPrivate'],
        status: json['status'],
        category: json['category'],
        phone: json['phone'],
        homeData: HomeData.fromJson(json['homeData']));
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'photoURL': photoURL,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isPrivate': isPrivate,
      'status': status,
      'author': author,
      'category': category,
      'homeData': homeData,
      'phone': phone,
    };
  }
}

enum ReportStatus { OPEN, IN_PROGRESS, DONE }

extension ReportStatusExtension on ReportStatus {
  String get description {
    switch (this) {
      case ReportStatus.OPEN:
        return 'Em aberto';
      case ReportStatus.IN_PROGRESS:
        return 'Em progresso';
      case ReportStatus.DONE:
        return 'Concluído';
    }
  }
}

enum ReportCategory {
  DEFAULT,
  ELECTRIC,
  HYDRAULIC,
  KEYCHAIN,
  PAINTING,
  ELEVATOR,
  COMPLAINT
}

extension ReportCategoryExtension on ReportCategory {
  String get description {
    switch (this) {
      case ReportCategory.ELECTRIC:
        return 'Elétrica';
      case ReportCategory.HYDRAULIC:
        return 'Hidráulica';
      case ReportCategory.KEYCHAIN:
        return 'Chaveiro';
      case ReportCategory.PAINTING:
        return 'Pintura';
      case ReportCategory.ELEVATOR:
        return 'Elevador';
      case ReportCategory.COMPLAINT:
        return 'Reclamação';
      case ReportCategory.DEFAULT:
        return 'Outros';
    }
  }
}

Icon getReportStatusColor(String status) {
  var st = ReportStatusHelper.fromString(status);
  switch (st) {
    case ReportStatus.OPEN:
      return Icon(
        Icons.lightbulb_rounded,
        color: Colors.amber[600],
      );
    case ReportStatus.IN_PROGRESS:
      return const Icon(
        Icons.autorenew,
        color: Colors.orange,
      );
    case ReportStatus.DONE:
      return Icon(
        Icons.check_circle,
        color: Colors.green[700],
      );
  }
}

Icon getReportCategoryIcon(String category) {
  var type = ReportCategoryHelper.fromString(category);

  switch (type) {
    case ReportCategory.DEFAULT:
      return const Icon(
        Icons.build_outlined,
        color: Colors.white,
        size: DSTextSize.xl,
      );
    case ReportCategory.ELECTRIC:
      return const Icon(
        Icons.wb_incandescent_sharp,
        color: Colors.white,
        size: DSTextSize.xl,
      );
    case ReportCategory.HYDRAULIC:
      return const Icon(
        Icons.water_drop_outlined,
        color: Colors.white,
        size: DSTextSize.xl,
      );
    case ReportCategory.KEYCHAIN:
      return const Icon(
        Icons.key_outlined,
        color: Colors.white,
        size: DSTextSize.xl,
      );
    case ReportCategory.PAINTING:
      return const Icon(
        Icons.format_paint_outlined,
        color: Colors.white,
        size: DSTextSize.xl,
      );
    case ReportCategory.ELEVATOR:
      return const Icon(
        Icons.elevator_outlined,
        color: Colors.white,
        size: DSTextSize.xl,
      );
    case ReportCategory.COMPLAINT:
      return const Icon(
        Icons.waving_hand_rounded,
        color: Colors.white,
        size: DSTextSize.xl,
      );
    default:
      return const Icon(
        Icons.build_outlined,
        color: Colors.white,
        size: DSTextSize.xl,
      );
  }
}

Color? getReportCategoryColor(String category) {
  var type = ReportCategoryHelper.fromString(category);

  switch (type) {
    case ReportCategory.DEFAULT:
      return Colors.grey[900];
    case ReportCategory.ELECTRIC:
      return Colors.amber[900];
    case ReportCategory.HYDRAULIC:
      return Colors.blue[800];
    case ReportCategory.KEYCHAIN:
      return Colors.brown[900];
    case ReportCategory.PAINTING:
      return Colors.purple[800];
    case ReportCategory.ELEVATOR:
      return Colors.grey[800];
    case ReportCategory.COMPLAINT:
      return Colors.pink[800];
    default:
      return Colors.green[900];
  }
}

class ReportStatusHelper {
  static ReportStatus fromString(String status) {
    return ReportStatus.values.firstWhere((status) => status == status);
  }
}

class ReportCategoryHelper {
  static ReportCategory fromString(String category) {
    try {
      final cat = ReportCategory.values.firstWhere((reportCategory) {
        return category.contains(reportCategory.description);
      });
      return cat;
    } catch (e) {
      return ReportCategory.DEFAULT;
    }
  }
}
