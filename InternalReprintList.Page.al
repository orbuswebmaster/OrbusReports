page 55110 InternalReprintList
{
    ApplicationArea = All;
    SourceTable = InternalReprint;
    Caption = 'Internal Rework';
    UsageCategory = Lists;
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                Editable = false;

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.';
                    Visible = false;
                }
                field(DownloadFile; DownloadFile)
                {
                    ApplicationArea = All;
                    Caption = 'Download File';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        TempBlob: Codeunit "Temp Blob";
                        Inst: InStream;
                        Out: OutStream;
                        Filename: Text;
                        InternalReprint: Record InternalReprint;
                        InternalReprintReport: Report InternalReprint;
                        RecRef: RecordRef;
                        var1: Text;
                    begin
                        //InternalReprint.Reset();
                        //InternalReprint.SetRange("Entry No.", Rec."Entry No.");
                        //Report.Run(Report::InternalReprint, false, true, InternalReprint);
                        var1:='';
                        InternalReprint.Reset();
                        CurrPage.SetSelectionFilter(InternalReprint);
                        if InternalReprint.FindSet()then repeat var1:=var1 + Format(InternalReprint."Entry No.") + '|';
                            until InternalReprint.Next() = 0;
                        var1:=DelChr(var1, '>', '|');
                        Filename:='InternalReprint-' + Format(Rec."Entry No.") + '.pdf';
                        TempBlob.CreateInStream(Inst);
                        TempBlob.CreateOutStream(Out);
                        InternalReprint.Reset();
                        InternalReprint.SetFilter("Entry No.", var1);
                        RecRef.GetTable(InternalReprint);
                        Report.SaveAs(Report::InternalReprint2, '', ReportFormat::Pdf, Out, RecRef);
                        DownloadFromStream(Inst, '', '', '', Filename);
                    end;
                }
                field("Sales Header Record"; Rec."Sales Header Record")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Header Record';
                }
                field("Production Order No."; Rec."Production Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'Production Order No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Caption = 'Location Code';
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = All;
                    Caption = 'Date Issued';
                }
                field("Submitted By"; Rec."Submitted By")
                {
                    ApplicationArea = All;
                    Caption = 'Submitted By';
                }
                field("FIle Printed By"; Rec."FIle Printed By")
                {
                    ApplicationArea = All;
                    Caption = 'File Printed By';
                }
                field("Department Requesting Rework"; Rec."Department Requesting Rework")
                {
                    ApplicationArea = All;
                }
                field("Department Performing Rework"; Rec."Department Performing Rework")
                {
                    ApplicationArea = All;
                }
                field("Root Cause Department"; Rec."Root Cause Department")
                {
                    ApplicationArea = All;
                }
                field("Root Cause For Rework"; Rec."Root Cause For Rework")
                {
                    ApplicationArea = All;
                }
                field("At Fault User"; Rec."At Fault User")
                {
                    ApplicationArea = All;
                    Caption = 'At Fault User';
                }
                field("Graphic Finished"; Rec."Graphic Finished")
                {
                    ApplicationArea = All;
                    Caption = 'Graphic Finished';
                }
                field(Rerip; Rec.Rerip)
                {
                    ApplicationArea = All;
                    Caption = 'Rerip';
                }
                field(Reprint; Rec.Reprint)
                {
                    ApplicationArea = All;
                    Caption = 'Reprint';
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    Caption = 'Notes';
                }
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                }
                field(Material; Rec.Material)
                {
                    ApplicationArea = All;
                    Caption = 'Material';
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                    Caption = 'Size';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Caption = 'User ID';
                }
                field("Date/Time Inserted"; Rec."Date/Time Inserted")
                {
                    ApplicationArea = All;
                    Caption = 'Date/Time Report Produced';
                }
                field("Ship Date"; Rec."Ship Date")
                {
                    ApplicationArea = All;
                    Caption = 'Ship Date';
                }
                field("Shipping Agent Code"; Rec."Shipping Agent Code")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Agent Code';
                }
                field("Shipping Agent Service"; Rec."Shipping Agent Service")
                {
                    ApplicationArea = All;
                    Caption = 'Shipping Agent Service';
                }
                field("Art Coordinator"; Rec."Art Coordinator")
                {
                    ApplicationArea = All;
                    Caption = 'Art Coordinator';
                }
                field("Project Manager"; Rec."Project Manager")
                {
                    ApplicationArea = All;
                }
                field("Design No"; Rec."Design No")
                {
                    ApplicationArea = All;
                }
                field("Detailing Metal"; Rec."Detailing Metal")
                {
                    ApplicationArea = All;
                }
                field("Detailing Wood"; Rec."Detailing Wood")
                {
                    ApplicationArea = All;
                }
                field("Instruction Detailing"; Rec."Instruction Detailing")
                {
                    ApplicationArea = All;
                }
                field(Other; Rec.Other)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Delete)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = Delete;
                Visible = VisibleVar;
                Caption = 'Delete';

                trigger OnAction()
                var
                    InternalReprint: Record InternalReprint;
                begin
                    if Dialog.Confirm('All records selected in the table will be deleted. Are you sure you want to delete the selected records in the table', true)then begin
                        InternalReprint.Reset();
                        CurrPage.SetSelectionFilter(InternalReprint);
                        if InternalReprint.FindSet()then InternalReprint.DeleteAll();
                    end
                    else
                        Message('No records have been deleted in the table');
                end;
            }
            action(Download)
            {
                ApplicationArea = All;
                Caption = 'Download';

                trigger OnAction()
                var
                    InternalReprint: Record InternalReprint;
                    var1: Text;
                    TempBlob: Codeunit "Temp Blob";
                    Inst: InStream;
                    Out: OutStream;
                    RecRef: RecordRef;
                    Filename: Text;
                begin
                    var1:='';
                    InternalReprint.Reset();
                    CurrPage.SetSelectionFilter(InternalReprint);
                    if InternalReprint.FindSet()then repeat var1:=var1 + Format(InternalReprint."Entry No.") + '|';
                        until InternalReprint.Next() = 0;
                    var1:=DelChr(var1, '>', '|');
                    TempBlob.CreateInStream(Inst);
                    TempBlob.CreateOutStream(Out);
                    InternalReprint.Reset();
                    InternalReprint.SetFilter("Entry No.", var1);
                    RecRef.GetTable(InternalReprint);
                    Report.SaveAs(Report::InternalReprint, '', ReportFormat::Pdf, Out, RecRef);
                    Filename:='Test.pdf';
                    DownloadFromStream(Inst, '', '', '', Filename);
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        DownloadFile:='Download File';
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", UserId());
        if UserSetup.FindFirst()then begin
            if UserSetup."Can Delete Internal Rework Rec" = true then VisibleVar:=true
            else
                VisibleVar:=false;
        end;
    end;
    /*trigger OnAfterGetCurrRecord()
    var
        TempBlob: Codeunit "Temp Blob";
        InternalReprint: Record InternalReprint;
        Inst: InStream;
        Out: OutStream;
        RecRef: RecordRef;
        Params: text;
    begin
        if
        Rec.File.HasValue()
        then
            exit
        else begin
            TempBlob.CreateInStream(Inst);
            TempBlob.CreateOutStream(Out);
            InternalReprint.Reset();
            InternalReprint.SetRange("Entry No.", Rec."Entry No.");
            RecRef.GetTable(InternalReprint);
            Report.SaveAs(Report::InternalReprint, '', ReportFormat::Pdf, Out, RecRef);
            Rec.File.CreateOutStream(Out);
            CopyStream(Out, Inst);
            Rec.Modify();
        end;
    end;*/
    var DownloadFile: Text;
    VisibleVar: Boolean;
}
