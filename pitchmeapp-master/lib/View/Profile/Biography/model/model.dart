import 'dart:convert';

import 'package:pitch_me_app/models/auth/userLoginModel.dart';

BiogaphyModel biogaphyModelFromJson(String str) =>
    BiogaphyModel.fromJson(json.decode(str));

String biogaphyModelToJson(BiogaphyModel data) => json.encode(data.toJson());

class BiogaphyModel {
  String message;
  BioResult result;
  int matchObj;

  BiogaphyModel({
    required this.message,
    required this.result,
    required this.matchObj,
  });

  factory BiogaphyModel.fromJson(Map<String, dynamic> json) => BiogaphyModel(
        message: json["message"],
        result: BioResult.fromJson(json["result"]),
        matchObj: json["matchObj"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result.toJson(),
        "matchObj": matchObj,
      };
}

class BioResult {
  List<BioDoc> docs;

  BioResult({
    required this.docs,
  });

  factory BioResult.fromJson(Map<String, dynamic> json) => BioResult(
        docs: List<BioDoc>.from(json["docs"].map((x) => BioDoc.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
      };
}

class BioDoc {
  String id;
  String userid;
  String picture;
  String identity;
  String face;
  String skillCertificate;
  String proofFunds;
  String location;
  String skills;
  String education;
  String experience;
  String wealth;
  String add;
  String nda;
  String signature;
  String comment;
  int status;
  String createdAt;
  String updatedAt;
  int v;
  int proofFundsstatus;
  int skillCertificatestatus;
  int identitystatus;
  int signaturestatus;
  User user;

  BioDoc({
    required this.id,
    required this.userid,
    required this.picture,
    required this.identity,
    required this.face,
    required this.skillCertificate,
    required this.proofFunds,
    required this.location,
    required this.skills,
    required this.education,
    required this.experience,
    required this.wealth,
    required this.add,
    required this.nda,
    required this.signature,
    required this.comment,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.proofFundsstatus,
    required this.skillCertificatestatus,
    required this.identitystatus,
    required this.signaturestatus,
    required this.user,
  });

  factory BioDoc.fromJson(Map<String, dynamic> json) => BioDoc(
        id: json["_id"],
        userid: json["userid"],
        picture: json["Picture"],
        identity: json["Identity"],
        face: json["Face"],
        skillCertificate: json["SkillCertificate"],
        proofFunds: json["ProofFunds"],
        location: json["Location"],
        skills: json["Skills"],
        education: json["Education"],
        experience: json["Experience"],
        wealth: json["Wealth"],
        add: json["Add"],
        nda: json["nda"],
        signature: json["signature"],
        comment: json["comment"],
        status: json["status"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
        proofFundsstatus: json["ProofFundsstatus"],
        skillCertificatestatus: json["SkillCertificatestatus"],
        identitystatus: json["Identitystatus"],
        signaturestatus: json['Signaturestatus'],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userid": userid,
        "Picture": picture,
        "Identity": identity,
        "Face": face,
        "SkillCertificate": skillCertificate,
        "ProofFunds": proofFunds,
        "Location": location,
        "Skills": skills,
        "Education": education,
        "Experience": experience,
        "Wealth": wealth,
        "Add": add,
        "nda": nda,
        "signature": signature,
        "comment": comment,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
        "ProofFundsstatus": proofFundsstatus,
        "SkillCertificatestatus": skillCertificatestatus,
        "Identitystatus": identitystatus,
        "Signaturestatus": signaturestatus,
        "user": user.toJson(),
      };
}
