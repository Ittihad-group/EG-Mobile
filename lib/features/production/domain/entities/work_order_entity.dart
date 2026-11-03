import 'package:equatable/equatable.dart';

class WorkOrderEntity extends Equatable {
  const WorkOrderEntity({
    required this.id,
    required this.number,
    required this.productAr,
    required this.productEn,
    required this.lineAr,
    required this.lineEn,
    required this.qty,
    required this.progress,
    required this.status,
    required this.dueDate,
  });

  final String id;
  final String number;
  final String productAr;
  final String productEn;
  final String lineAr;
  final String lineEn;
  final int qty;
  final int progress;
  final String status;
  final String dueDate;

  @override
  List<Object?> get props => [id, number, status, progress];
}
