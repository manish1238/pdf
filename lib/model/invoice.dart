import 'package:generate_pdf_invoice_example/model/customer.dart';
import 'package:generate_pdf_invoice_example/model/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String name;
  final String designation;
  final String bank;
  final String accountNo;
  final String month;
  final String workingDays;
  final String empId;

  const InvoiceInfo({
    required this.name,
    required this.designation,
    required this.bank,
    required this.accountNo,
    required this.month,
    required this.workingDays,
    required this.empId,
  });
}

class InvoiceItem {
  final String description;
  final String date;
  final String quantity;
  final String vat;
  final String unitPrice;

  const InvoiceItem({
    required this.description,
    required this.date,
    required this.quantity,
    required this.vat,
    required this.unitPrice,
  });
}
