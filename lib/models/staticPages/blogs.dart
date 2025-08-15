// To parse this JSON data, do
//
//     final blogsListModel = blogsListModelFromJson(jsonString);

import 'dart:convert';

BlogsListModel blogsListModelFromJson(String str) => BlogsListModel.fromJson(json.decode(str));

String blogsListModelToJson(BlogsListModel data) => json.encode(data.toJson());

class BlogsListModel {
    BlogsListModel({
        this.blogs,
        this.latest,
    });

    List<Latest>? blogs;
    Latest? latest;

    factory BlogsListModel.fromJson(Map<String, dynamic> json) => BlogsListModel(
        blogs: List<Latest>.from(json["blogs"].map((x) => Latest.fromJson(x))),
        latest: Latest.fromJson(json["latest"]),
    );

    Map<String, dynamic> toJson() => {
        "blogs": List<dynamic>.from(blogs!.map((x) => x.toJson())),
        "latest": latest!.toJson(),
    };
}

class Latest {
    Latest({
        this.id,
        this.image,
        this.title,
        this.slug,
        this.description,
        this.createdAt,
    });

    int? id;
    String? image;
    String? title;
    String? slug;
    String? description;
    String? createdAt;

    factory Latest.fromJson(Map<String, dynamic> json) => Latest(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "slug": slug,
        "description": description,
        "created_at": createdAt,
    };
}
