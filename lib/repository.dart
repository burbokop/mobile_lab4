import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_lab4/utils.dart';

part 'repository.g.dart';

@JsonSerializable()
class Repository {
  Repository(this.name, this.description);
  String name;
  String description;

  @override
  String toString() => 'Repository($name)';

  factory Repository.fromJson(Map<String, dynamic> json) => _$RepositoryFromJson(json);
  Map<String, dynamic> toJson() => _$RepositoryToJson(this);

  static listFromJson(List<dynamic> json) =>
      json.map((j) => Repository.fromJson(cast<Map<String, dynamic>>(j))).toList();
}
