page 55184 SalesInvoiceLinesCustom
{
    ApplicationArea = All;
    Caption = 'Posted Sales Lines';
    SourceTable = Customer;
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            field(Filter1; Filter1)
            {
                ApplicationArea = All;
                Caption = 'Customer No.';
                Editable = false;
            }
            field(DocType; Rec.DocType)
            {
                ApplicationArea = All;
                Caption = 'Document Type Filter';

                trigger OnValidate()
                var
                begin
                    if Rec.DocType = Rec.DocType::"Posted Sales Invoice" then PostedInvoiceVisible:=true
                    else
                        PostedInvoiceVisible:=false;
                    if Rec.DocType = Rec.DocType::"Posted Shipments" then PostedShipmentVisible:=true
                    else
                        PostedShipmentVisible:=false;
                    if Rec.DocType = Rec.DocType::"Posted Return Receipts" then PostedReceiptVisible:=true
                    else
                        PostedReceiptVisible:=false;
                    if Rec.DocType = Rec.DocType::"Posted Credit Memos" then PostedCreditMemosVisible:=true
                    else
                        PostedCreditMemosVisible:=false;
                end;
            }
            field(SelectRecords; SelectRecords)
            {
                ApplicationArea = All;
                Caption = 'Select Records';

                trigger OnLookup(var Text: Text): Boolean var
                    SalesInvoiceLine: Record "Sales Invoice Line";
                    SalesShipmentLine: Record "Sales Shipment Line";
                    PostedSalesInvoiceLinesPage: Page "Posted Sales Invoice Lines";
                    PostedSalesShipmentLinesPage: Page "Posted Sales Shipment Lines";
                    PostedSalesCreditMemoLinesPage: Page "Posted Sales Credit Memo Lines";
                    SalesCreditMemoLine: Record "Sales Cr.Memo Line";
                    ReturnReceiptLine: Record "Return Receipt Line";
                    PostedReceiptLineListPage: Page "Posted Return Receipt Lines";
                    LineNo1: Text;
                    RecRef: RecordRef;
                begin
                    if Rec.DocType = Rec.DocType::"Posted Sales Invoice" then begin
                        UniqueGuid:='';
                        PostedSalesInvoiceLinesPage.LookupMode(true);
                        SalesInvoiceLine.Reset();
                        SalesInvoiceLine.SetRange("Sell-to Customer No.", Filter1);
                        PostedSalesInvoiceLinesPage.SetTableView(SalesInvoiceLine);
                        if PostedSalesInvoiceLinesPage.RunModal() = Action::LookupOK then begin
                            SalesInvoiceLine.Reset();
                            PostedSalesInvoiceLinesPage.SetSelectionFilter(SalesInvoiceLine);
                            if SalesInvoiceLine.FindSet()then repeat UniqueGuid:=UniqueGuid + Format(SalesInvoiceLine.SystemId) + '|';
                                until SalesInvoiceLine.Next() = 0;
                            UniqueGuid:=DelChr(UniqueGuid, '>', '|');
                        end;
                    end;
                    if Rec.DocType = Rec.DocType::"Posted Shipments" then begin
                        UniqueGuid:='';
                        PostedSalesShipmentLinesPage.LookupMode(true);
                        SalesShipmentLine.Reset();
                        SalesShipmentLine.SetRange("Sell-to Customer No.", Filter1);
                        PostedSalesShipmentLinesPage.SetTableView(SalesShipmentLine);
                        if PostedSalesShipmentLinesPage.RunModal() = Action::LookupOK then begin
                            SalesShipmentLine.Reset();
                            PostedSalesShipmentLinesPage.SetSelectionFilter(SalesShipmentLine);
                            if SalesShipmentLine.FindSet()then repeat UniqueGuid:=UniqueGuid + Format(SalesShipmentLine.SystemId) + '|';
                                until SalesShipmentLine.Next() = 0;
                            UniqueGuid:=DelChr(UniqueGuid, '>', '|');
                        end;
                    end;
                    if Rec.DocType = Rec.DocType::"Posted Credit Memos" then begin
                        UniqueGuid:='';
                        PostedSalesCreditMemoLinesPage.LookupMode(true);
                        SalesCreditMemoLine.Reset();
                        SalesCreditMemoLine.SetRange("Sell-to Customer No.", Filter1);
                        PostedSalesCreditMemoLinesPage.SetTableView(SalesCreditMemoLine);
                        if PostedSalesCreditMemoLinesPage.RunModal() = Action::LookupOK then begin
                            SalesCreditMemoLine.Reset();
                            PostedSalesCreditMemoLinesPage.SetSelectionFilter(SalesCreditMemoLine);
                            if SalesCreditMemoLine.FindSet()then repeat UniqueGuid:=UniqueGuid + Format(SalesCreditMemoLine.SystemId) + '|';
                                until SalesCreditMemoLine.Next() = 0;
                            UniqueGuid:=DelChr(UniqueGuid, '>', '|');
                        end;
                    end;
                    if Rec.DocType = Rec.DocType::"Posted Return Receipts" then begin
                        UniqueGuid:='';
                        PostedReceiptLineListPage.LookupMode(true);
                        ReturnReceiptLine.Reset();
                        ReturnReceiptLine.SetRange("Sell-to Customer No.", Filter1);
                        PostedReceiptLineListPage.SetTableView(ReturnReceiptLine);
                        if PostedReceiptLineListPage.RunModal() = Action::LookupOK then begin
                            ReturnReceiptLine.Reset();
                            PostedReceiptLineListPage.SetSelectionFilter(ReturnReceiptLine);
                            if ReturnReceiptLine.FindSet()then repeat UniqueGuid:=UniqueGuid + Format(ReturnReceiptLine.SystemId) + '|';
                                until ReturnReceiptLine.Next() = 0;
                            UniqueGuid:=DelChr(UniqueGuid, '>', '|');
                        end;
                    end;
                end;
            }
            field(UniqueGuid; UniqueGuid)
            {
                ApplicationArea = All;
                Caption = 'Unique GUID';
                Editable = false;
            }
        /*part(Part1; "Posted Sales Invoice Subform")
            {
                Visible = PostedInvoiceVisible;
                ApplicationArea = All;
                SubPageLink = "Sell-to Customer No." = field("No.");

            }
            part(Part2; "Posted Sales Shpt. Subform")
            {
                Visible = PostedShipmentVisible;
                ApplicationArea = All;
                SubPageLink = "Sell-to Customer No." = field("No.");
            }

            part(Part3; "Get Pst.Doc-RtrnRcptLn Subform")
            {
                Visible = PostedReceiptVisible;
                ApplicationArea = All;
                SubPageLink = "Sell-to Customer No." = field("No.");
            }
            part(Part4; "Get Post.Doc-S.Cr.MemoLn Sbfrm")
            {
                Visible = PostedCreditMemosVisible;
                ApplicationArea = All;
                SubPageLink = "Sell-to Customer No." = field("No.");

            }*/
        }
    }
    trigger OnOpenPage()
    var
    begin
        Rec.Reset();
        Rec.SetRange("No.", Filter1);
        PostedInvoiceVisible:=true;
        PostedShipmentVisible:=false;
        PostedReceiptVisible:=false;
        PostedCreditMemosVisible:=false;
    end;
    procedure ApplyFilter(var1: Code[20])
    var
    begin
        Filter1:=var1;
    end;
    procedure GetDocType(): Text var
    begin
        if Rec.DocType = Rec.DocType::"Posted Sales Invoice" then exit('Posted Sales Invoice');
        if Rec.DocType = Rec.DocType::"Posted Credit Memos" then exit('Posted Credit Memos');
        if Rec.DocType = Rec.DocType::"Posted Return Receipts" then exit('Posted Return Receipts');
        if Rec.DocType = Rec.DocType::"Posted Shipments" then exit('Posted Shipments')end;
    procedure GetValues1(): Text var
    begin
        exit(UniqueGuid)end;
    var Filter1: Code[20];
    DocumentTypeFilter: Enum DocType;
    PostedInvoiceVisible: Boolean;
    PostedShipmentVisible: Boolean;
    PostedReceiptVisible: Boolean;
    PostedCreditMemosVisible: Boolean;
    SelectRecords: Text;
    UniqueGuid: Text;
}
