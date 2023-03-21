import 'dart:io';
import 'package:flutter/services.dart';
import 'package:generate_pdf_invoice_example/api/pdf_api.dart';
import 'package:generate_pdf_invoice_example/model/customer.dart';
import 'package:generate_pdf_invoice_example/model/invoice.dart';
import 'package:generate_pdf_invoice_example/model/supplier.dart';
import 'package:generate_pdf_invoice_example/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      header: (context)=>buildCompanyNameHeader(),
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 1* PdfPageFormat.cm),
        // buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_payslip.pdf', pdf: pdf);
  }
  static Widget buildCompanyNameHeader() => Align(alignment: Alignment.center,child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Tech Eight Consultancy'),
      SizedBox(height: 2 * PdfPageFormat.mm),
      Text('B-181, East of Kailash, New Delhi-110065'),   SizedBox(height: 3 * PdfPageFormat.mm),
    ],
  ) );
  static Widget  buildHeader(Invoice invoice) {
   // final _logo = await rootBundle.loadString('assets/logo.svg');
   //  final profileImage = pw.MemoryImage(
   //      (await rootBundle.load('assets/profile.jpg')).buffer.asUint8List(),
   //  );
   // final netImage = await networkImage('https://www.nfet.net/nfet.jpg');
 return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  // SizedBox(height: 1 * PdfPageFormat.cm),
  // Row(
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // children: [
  // buildSupplierAddress(invoice.supplier),
  // Container(
  // height: 50,
  // width: 50,
  // // child: pw.Image(netImage),
  // child:
  //   // pw.Image(networkImage('https://www.nfet.net/nfet.jpg')),
  // BarcodeWidget(
  //   barcode: Barcode.qrCode(),
  //   data: invoice.info.number,
  // ),
  // ),
  // ],
  // ),
  SizedBox(height: 1 * PdfPageFormat.cm),
  Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
  // buildCustomerAddress(invoice.customer),
  buildInvoiceInfo(invoice.info),
  buildInvoiceInfoTwo(invoice.info),
  ],
  ),
  ],
  );
}

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>[
      'Name',
      'Designation',
      'Bank',
      'Account No.'
    ];
    final data = <String>[
      info.name,
      info.designation,
      info.bank,
      info.accountNo,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }
  static Widget buildInvoiceInfoTwo(InvoiceInfo info) {
    final titles = <String>[
      'Month',
      'No of Working Days',
      'Employee ID',
    ];
    final data = <String>[
      info.month,
      info.workingDays,
      info.empId
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200,);
      }),
    );
  }
  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address),
        ],
      );

  // static Widget buildTitle(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'INVOICE',
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 0.8 * PdfPageFormat.cm),
  //         // Text(invoice.info.description),
  //         // SizedBox(height: 0.8 * PdfPageFormat.cm),
  //       ],
  //     );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Earning',
      'Amount',
      'Deduction',
      'Amount',
      // 'VAT',
      // 'Total'
    ];
    final data = invoice.items.map((item) {
      // final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.description,
        '${item.date}',
        // Utils.formatDate(item.date),
        '${item.quantity}',
        // '${item.unitPrice}',
        '${item.vat}',
        // '\$ ${total.toStringAsFixed(2)
        // }'
        // ,
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        4:Alignment.centerLeft,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    // final netTotal = invoice.items
    //     .map((item) => item.unitPrice * item.quantity)
    //     .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value:'55,000',
                  // value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'Net Deduction',
                  value: '10,000',
                  // value: Utils.formatPrice(vat),
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Net Salary',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: '45,000',
                  // value: Utils.formatPrice(total),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Text('Forty Five Thousands Only' ,style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Text('Computer generated does not require signature.', style: TextStyle(
                  fontSize: 14,
                ),textAlign: TextAlign.center)
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: 'B-181, GF, Raja Dhir Sen Marg, East Of Kailash, New Delhi-110065'),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text('Computer generated does not require signature.')
          // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
