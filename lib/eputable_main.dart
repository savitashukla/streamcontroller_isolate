
import 'package:equatable/equatable.dart';

class AssignRackState extends Equatable {
   const AssignRackState(
      {
        required this.contnt,
      });

  final int contnt;

  AssignRackState copyWith(
      {
        contnt,


      }) {
    return AssignRackState(
        contnt: contnt ?? this.contnt,
    );
  }

  @override
  List<Object?> get props => [contnt];
}