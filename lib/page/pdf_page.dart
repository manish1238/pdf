import 'package:flutter/material.dart';
import 'package:generate_pdf_invoice_example/api/pdf_api.dart';
import 'package:generate_pdf_invoice_example/api/pdf_invoice_api.dart';
import 'package:generate_pdf_invoice_example/main.dart';
import 'package:generate_pdf_invoice_example/model/customer.dart';
import 'package:generate_pdf_invoice_example/model/invoice.dart';
import 'package:generate_pdf_invoice_example/model/supplier.dart';
import 'package:generate_pdf_invoice_example/widget/button_widget.dart';
import 'package:generate_pdf_invoice_example/widget/title_widget.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Payslip'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleWidget(
                  icon: Icons.picture_as_pdf,
                  text: 'Generate Invoice',
                ),
                const SizedBox(height: 48),
                ButtonWidget(
                  text: 'Invoice PDF',
                  onClicked: () async {
                    final date = DateTime.now();
                    final dueDate = date.add(Duration(days: 7));

                    final invoice = Invoice(
                      supplier: Supplier(
                        name: 'Manish Saxena',
                        address: 'Street 19, India Delhi',
                        paymentInfo: 'https://paypal.me/sarahfieldzz',
                      ),
                      customer: Customer(
                        name: 'Iconex Exhibition',
                        address: 'delhi east of kailash, delhi, india',
                      ),
                      info: InvoiceInfo(
                        name: 'Manish Saxena',
                        designation: 'Flutter Developer',
                        bank: 'Federal Bank.',
                        accountNo: '909090909090090',
                        empId: 'TEC1011',
                        month:'December' ,
                        workingDays:'365' ,
                      ),
                      items: [
                        // InvoiceItem(
                        //   description: 'Employee Id',
                        //   date: 'TEC101',
                        //   quantity: 'Joining Date',
                        //   vat:  'Joining Date',
                        //   unitPrice:'9 Sept 2022',
                        // ),
                        // InvoiceItem(
                        //   description: 'Employee Name',
                        //   date: 'Manish Saxena',
                        //   quantity: 'Designation',
                        //   vat:  'Flutter Developer',
                        //   unitPrice:'9 Sept 2022',
                        // ),
                        //   InvoiceItem(
                        //   description: 'Provident Fund No.',
                        //   date: 'TEC101',
                        //   quantity: 'ESCI No.',
                        //   vat:  'Jasdfsd',
                        //   unitPrice:'9 Sept 2022',
                        // ),
                        // InvoiceItem(
                        //   description: 'Bank Name',
                        //   date: 'Federal Bank',
                        //   quantity: 'Account No',
                        //   vat:  'ADE99997990D',
                        //   unitPrice:'9 Sept 2022',
                        // ),
                        // InvoiceItem(
                        //   description: 'Total Working Days',
                        //   date: '20',
                        //   quantity: 'Payable Days',
                        //   vat:  '20',
                        //   unitPrice:'9 Sept 2022',
                        // ),
                        InvoiceItem(
                            description: 'Basic Wage',
                            date: '20,000',
                            quantity: 'PF',
                            vat: '20,000',
                            unitPrice: 5.99.toString(),
                        ),
                        InvoiceItem(
                          description: 'HRA',
                          date: "5000",
                          quantity:'TDS',
                          vat:'0',
                          unitPrice: 0.99.toString(),
                        ),
                        InvoiceItem(
                          description: 'Reimbursement',
                          date: '10,000',
                          quantity: '',
                          vat:'',
                          unitPrice: '0.0',
                        ),
                         InvoiceItem(
                          description: 'Special Allowance',
                          date: '0.0',
                          quantity: '',
                          vat:'',
                          unitPrice: '0.0',
                        ),

                        // details(
                        //   employeeId: 'employeeId',
                        //     employeeName: 'employeeName',
                        //     pfNumber: 'pfNumber',
                        //     bankName: 'bankName',
                        //     totalWorkingDays:
                        //     'totalWorkingDays',
                        //     joiningDate: 'joiningDate',
                        //     designation: 'designation',
                        //     esciNumber: 'esciNumber',
                        //     accountNumber: 'accountNumber',
                        //     payableDays: 'payableDays',
                        // )
                        // InvoiceItem(
                        //   description: 'Mango',
                        //   date: DateTime.now(),
                        //   quantity: 1,
                        //   vat: 0.19,
                        //   unitPrice: 1.59,
                        // ),
                        // InvoiceItem(
                        //   description: 'Blue Berries',
                        //   date: DateTime.now(),
                        //   quantity: 5,
                        //   vat: 0.19,
                        //   unitPrice: 0.99,
                        // ),
                        // InvoiceItem(
                        //   description: 'Lemon',
                        //   date: DateTime.now(),
                        //   quantity: 4,
                        //   vat: 0.19,
                        //   unitPrice: 1.29,
                        // ),
                      ],
                    );

                    final pdfFile = await PdfInvoiceApi.generate(invoice);

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
