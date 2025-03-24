// report 55159 CreditCardTransactions
// {
//     Caption = 'Credit Card Transactions';
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     ExcelLayout = './ReportLayouts/CreditCardTransactions.xlsx';

//     dataset
//     {
//         dataitem(SalesInvoiceHeader; "Sales Invoice Header")
//         {
//             RequestFilterFields = "Sell-to Customer No.", "Document Date";

//             column(Customer_No; "Sell-to Customer No.")
//             {
//             }
//             column(Invoice_No; "No.")
//             {
//             }
//             column(PO_Number; "External Document No.")
//             {
//             }
//             column(Order_No; "Order No.")
//             {
//             }
//             dataitem(EFTTransactions; "EFT Transaction -CL-")
//             {
//                 DataItemLinkReference = SalesInvoiceHeader;
//                 DataItemLink = "Document No."=field("No.");

//                 column(Transaction_Date; "Transaction Date")
//                 {
//                 }
//                 column(Amount; "Signed Transaction Amt.")
//                 {
//                 }
//                 trigger OnPreDataItem()
//                 var
//                 begin
//                     EFTTransactions.Reset();
//                     EFTTransactions.SetRange("Document No.", SalesInvoiceHeader."No.");
//                     EFTTransactions.SetRange("Method Type", EFTTransactions."Method Type"::Settle);
//                     EFTTransactions.SetRange("Transaction Status", EFTTransactions."Transaction Status"::Approved);
//                 end;
//             }
//         }
//     }
// }
