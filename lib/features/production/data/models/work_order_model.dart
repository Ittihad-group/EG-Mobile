import 'package:eg_mobile/core/data/seed_data.dart';
import '../../domain/entities/work_order_entity.dart';

class WorkOrderModel extends WorkOrderEntity {
  const WorkOrderModel({
    required super.id,
    required super.number,
    required super.productAr,
    required super.productEn,
    required super.lineAr,
    required super.lineEn,
    required super.qty,
    required super.progress,
    required super.status,
    required super.dueDate,
  });

  factory WorkOrderModel.fromSeed(SeedWorkOrder w) => WorkOrderModel(
        id: w.id,
        number: w.number,
        productAr: w.productAr,
        productEn: w.productEn,
        lineAr: w.lineAr,
        lineEn: w.lineEn,
        qty: w.qty,
        progress: w.progress,
        status: w.status,
        dueDate: w.dueDate,
      );

  WorkOrderEntity toEntity() => WorkOrderEntity(
        id: id,
        number: number,
        productAr: productAr,
        productEn: productEn,
        lineAr: lineAr,
        lineEn: lineEn,
        qty: qty,
        progress: progress,
        status: status,
        dueDate: dueDate,
      );
}
