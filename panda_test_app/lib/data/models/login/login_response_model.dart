import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable(includeIfNull: false, createToJson: false)
class LoginResponseModel {
  final bool success;
  final String? token;
  final String? message;

  LoginResponseModel({
    required this.success,
    this.token,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}
