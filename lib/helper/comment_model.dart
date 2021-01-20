import 'package:flutter/material.dart';
import 'package:a_knitting_app/helper/usermodel.dart';

class CommentModel {
  final UserModel user;
  final String comment;
  final DateTime time;

  const CommentModel({
    @required this.user,
    @required this.comment,
    @required this.time,
  });
}