
import 'package:a_knitting_app/helper/usermodel.dart';
import 'package:a_knitting_app/helper/postmodel.dart';
import 'package:a_knitting_app/helper/comment_model.dart';


class DemoValues {
  static final List<UserModel> users = [
    UserModel(
      id: "1",
      name: "Ishfar",
      email: "ishfar@gmail.com",
      image: "assets/images/user_small.png",
      followers: 123,
      joined: DateTime(2020, 12,25),
      posts: 12,
    ),
    UserModel(
      id: "2",
      name: "Ishrak",
      email: "ishrak@gmail.com",
      image: "assets/images/user_small.png",
      followers: 456,
      joined: DateTime(2021, 1, 1),
      posts: 13,
    ),
    UserModel(
      id: "3",
      name: "Shakleen",
      email: "shakleen@gmail.com",
      image: "assets/images/user_small.png",
      followers: 789,
      joined: DateTime(2021, 1, 19),
      posts: 14,
    ),
  ];

  static final String _body =
      """WOW I MISS UUM.""";

  static final List<CommentModel> _comments = <CommentModel>[
    CommentModel(
      comment:
          "WONDERFUL. ",
      user: users[0],
      time: DateTime(2020, 12, 30),
    ),
    CommentModel(
      comment: "HOW TO KNIT IT. ",
      user: users[1],
      time: DateTime(2020, 12, 30),
    ),
    CommentModel(
      comment: "Beautiful. ",
      user: users[0],
      time: DateTime(2020, 6, 30),
    ),
    CommentModel(
      comment: "Cute. ",
      user: users[2],
      time: DateTime(2020, 4, 30),
    ),
    CommentModel(
      comment: "Cute.",
      user: users[1],
      time: DateTime(2020, 5, 30),
    ),
    CommentModel(
      comment:
          "Teach me Guru. ",
      user: users[2],
      time: DateTime(2020, 6, 30),
    ),
    CommentModel(
      comment:
          "Nice. ",
      user: users[1],
      time: DateTime(2020, 4, 30),
    ),
    CommentModel(
      comment: "Nice. ",
      user: users[0],
      time: DateTime(2020, 5, 30),
    ),
    CommentModel(
      comment:
          "I like it. ",
      user: users[1],
      time: DateTime(2020, 6, 30),
    ),
  ];

  static final List<PostModel> posts = [
    PostModel(
      id: "1",
      author: users[0],
      title: "Maple Tree",
      summary: "An in-depth study on maple trees.",
      body: "This knitting of maple leave.",
      imageURL: "assets/images/mapletree.png",
      postTime: DateTime(2020, 11, 27, 7, 36),
      reacts: 123,
      views: 456,
      comments: _comments,
    ),
    PostModel(
      id: "2",
      author: users[1],
      title: "Glove ready for Winter",
      summary: "Ready for winter",
      body: _body,
      imageURL: "assets/images/glove.png",
      postTime: DateTime(2020, 12, 25),
      reacts: 321,
      views: 654,
      comments: _comments,
    ),
    PostModel(
      id: "3",
      author: users[2],
      title: "My Teddy",
      summary: "Where is my honey?",
      body: _body * 2,
      imageURL: "assets/images/bear.png",
      postTime: DateTime(2020, 12, 28),
      reacts: 213,
      views: 546,
      comments: _comments,
    ),
  ];
}