pageextension 55137 SalesOrderReturnListPageExt extends "Sales Return Order List"
{
    actions
    {
        addafter("&Print")
        {
            action(RegisteredPickReport)
            {
                ApplicationArea = All;
                Caption = 'Inspection Sheet Report';
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::InspectionSheet, true, true, SalesHeader);
                end;
            }
            action(ReturnOrder)
            {
                ApplicationArea = All;
                Caption = 'Print Return Orders';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    ReturnOrderCustom: Report ReturnOrderCustom;
                    SalesHeader: Record "Sales Header";
                    var1: Text;
                    var2: text;
                    TempBlob: Codeunit "Temp Blob";
                    Inst: InStream;
                    Out: OutStream;
                    RecRef: RecordRef;
                    FileName: Text;
                begin
                    FileName:='Sales Return Order- ' + Rec."No." + '.pdf';
                    var2:='';
                    var1:='';
                    SalesHeader.Reset();
                    CurrPage.SetSelectionFilter(SalesHeader);
                    if SalesHeader.FindSet()then repeat var1:=var1 + SalesHeader."No." + '|';
                        until SalesHeader.Next() = 0;
                    var1:=DelChr(var1, '>', '|');
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("No.", var1);
                    RecRef.GetTable(SalesHeader);
                    TempBlob.CreateInStream(Inst);
                    TempBlob.CreateOutStream(Out);
                    Report.SaveAs(Report::ReturnOrderCustom, '', ReportFormat::Pdf, Out, RecRef);
                    DownloadFromStream(Inst, '', '', '', FileName);
                end;
            /*repeat
                    var1 := var1 + SalesHeader."No." + '|';
                    until 
                    SalesHeader.Next() = 0;

                    var1 := DelChr(var1, '>', '|');


                    ReturnOrderCustom.GetValues(var1);
                    ReturnOrderCustom.RunModal();*/
            }
        }
    }
}
