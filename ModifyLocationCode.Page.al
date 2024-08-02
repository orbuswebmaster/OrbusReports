page 55191 ModifyLocationCode
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            field(SalesInvoiceHeaderNo; SalesInvoiceHeaderNo)
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice Header No.';
                Editable = false;
            }
            field(CurrentLocationCode; CurrentLocationCode)
            {
                ApplicationArea = All;
                Caption = 'Current Location Code';
                Editable = false;
            }
            field(NewLocationCode; NewLocationCode)
            {
                ApplicationArea = All;
                Caption = 'New Location Code';
                TableRelation = Location.Code;
            }
        }
    }
    var SalesInvoiceHeaderNo: Text;
    CurrentLocationCode: Text;
    NewLocationCode: Text;
    procedure GetValues(InvoiceNo: Text; CurrentLocationCodevar: Text)
    var
    begin
        SalesInvoiceHeaderNo:=InvoiceNo;
        CurrentLocationCode:=CurrentLocationCodevar;
    end;
    procedure ModifySalesInvoiceHeaderRecord()
    var
        ModifySalesInvoiceHeaderLoc: Codeunit ModifySalesInvoiceHeaderLoc;
    begin
        ModifySalesInvoiceHeaderLoc.ModifySalesInvoiceHeaderLoc(SalesInvoiceHeaderNo, NewLocationCode);
    end;
}
