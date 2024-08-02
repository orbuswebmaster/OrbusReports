pageextension 55142 PostedSalesInvoiceDocExt extends "Posted Sales Invoice"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Industry Shortcut Dimension"; Rec."Industry Shortcut Dimension")
            {
                ApplicationArea = All;
                Caption = 'Industry Code';
                Editable = false;
            }
        }
        addafter("Work Description")
        {
            field("Created At"; Rec."Created At")
            {
                ApplicationArea = All;
                Caption = 'Created At';
            }
            field(Created_By; Rec.Created_By)
            {
                ApplicationArea = All;
                Caption = 'Created By';
            }
        }
        addafter("Shipping Agent Code")
        {
            field("Shipping Agent Service Code 2"; Rec."Shipping Agent Service Code 2")
            {
                ApplicationArea = All;
                Caption = 'Shipping Agent Service Code';
            }
        }
        addafter("Due Date")
        {
            field("Case No."; Rec."Case No.")
            {
                ApplicationArea = All;
                Caption = 'Case No.';
            }
        }
    }
    actions
    {
        addafter(Print)
        {
            action(WorkOrderReport)
            {
                ApplicationArea = All;
                Caption = 'Work Order';
                Promoted = true;
                PromotedCategory = Category6;
                Image = Report;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    TempBlob: Codeunit "Temp Blob";
                    Inst: InStream;
                    Out: OutStream;
                    Test1: Text;
                    test2: Text;
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    SalesInvoiceHeader.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.RunModal(Report::CustomWorkOrder, true, true, SalesInvoiceHeader);
                end;
            }
            action(Test)
            {
                ApplicationArea = All;
                Caption = 'Test';
                Promoted = true;
                PromotedCategory = Category6;
                Image = Report;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                    TempBlob: Codeunit "Temp Blob";
                    Inst: InStream;
                    Out: OutStream;
                    Test1: Text;
                    test2: Text;
                begin
                    Rec.CalcFields(Rec."Work Description");
                    Rec."Work Description".CreateInStream(Inst);
                    Inst.ReadText(Test1);
                    Message('%1', Test1);
                    if Rec."Work Description".HasValue()then Message('Has Value')
                    else
                        Message('No blob value');
                end;
            }
        }
        addafter(CreateNewCaseWSG)
        {
            action(InsertCaseRecord)
            {
                Caption = 'Insert Case Record';
                ApplicationArea = All;
                Image = Insert;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CaseHeader: Record "Case WSG";
                    var1: Text;
                    var2: Text;
                    NoSeriesLine: Record "No. Series Line";
                begin
                    if Dialog.Confirm('Are you sure you want to insert record into Case HEader tbale based on Sales Invoice HEader record: ' + Rec."No." + '?', true)then begin
                        var2:=CurrPage.ObjectId(true);
                        var2:=var2.Replace('Page ', '');
                        NoSeriesLine.Reset();
                        NoSeriesLine.SetFilter("Series Code", 'CASE');
                        if NoSeriesLine.Findfirst()then var1:=IncStr(NoSeriesLine."Last No. Used")
                        else
                            var1:='CASE-00000001';
                        CaseHeader.Init();
                        CaseHeader."No.":=var1;
                        CaseHeader."Entity No.":=Rec."Sell-to Customer No.";
                        CaseHeader."Entity Name":=Rec."Sell-to Customer Name";
                        CaseHeader."SalesPerson Code":=Rec."Salesperson Code";
                        CaseHeader."Location Code":=Rec."Location Code";
                        CaseHeader."Sales Invoice Header No.":=Rec."No.";
                        CaseHeader."Sales Header No.":=Rec."Order No.";
                        CaseHeader."Contact Name":=Rec."Sell-to Customer Name";
                        CaseHeader."Contact Phone":=Rec."Sell-to Phone No.";
                        CaseHeader."Contact Email 2":=Rec."Sell-to E-Mail";
                        CaseHeader."External Doc No.":=Rec."External Document No.";
                        CaseHeader."Source Page Id":=132;
                        CaseHeader."Source Page Name":=var2;
                        CaseHeader."Source No.":=Rec."No.";
                        CaseHeader."Created On DateTime":=CurrentDateTime();
                        CaseHeader."Created By":=UserId();
                        if CaseHeader.Insert()then begin
                            NoSeriesLine.Reset();
                            NoSeriesLine.SetFilter("Series Code", 'CASE');
                            if NoSeriesLine.FindFirst()then begin
                                NoSeriesLine."Last No. Used":=var1;
                                NoSeriesLine."Last Date Used":=Today();
                                if NoSeriesLine.Modify()then begin
                                    CaseHeader.Reset();
                                    CaseHeader.SetFilter("No.", var1);
                                    if CaseHeader.FindFirst()then Page.Run(Page::"Case Card WSG", CaseHeader)
                                    else
                                        Error('Record was either not inserted into Case table or not found. Please try to insert case record again.');
                                end;
                            end;
                        end
                        else
                            Error('Record did not get inserted into Case Header table. Please try again.');
                    end;
                end;
            }
        }
    }
}
