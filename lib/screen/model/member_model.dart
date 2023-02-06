// To parse this JSON data, do
//
//     final memberModel = memberModelFromJson(jsonString);

import 'dart:convert';

MemberModel memberModelFromJson(String str) => MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
    MemberModel({
        required this.members,
    });

    List<Member> members;

    factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        members: List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
    };
}

class Member {
    Member({
        required this.id,
        required this.name,
        required this.lastName,
        required this.phone,
    });

    int id;
    String name;
    String lastName;
    int phone;

    factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        name: json["name"],
        lastName: json["last_name"],
        phone: json["phone"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_name": lastName,
        "phone": phone,
    };
}
