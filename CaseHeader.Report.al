report 55195 CaseHeader
{
    RDLCLayout = './ReportLayouts/CaseHeader.rdl';
    DefaultLayout = Excel;
    ExcelLayout = './ReportLayouts/CaseHeader.xlsx';

    dataset
    {
        dataitem("Case WSG"; "Case WSG")
        {
            column(No; "No.")
            {
            }
            column(EntityName; "Entity Name")
            {
            }
            column(EntityNo; "Entity No.")
            {
            }
            column(SalesHeaderNo; "Sales Header No.")
            {
            }
            column(SalesInvoiceHeaderNo; "Sales Invoice Header No.")
            {
            }
            column(SalesQuoteNo; "Sales Quote No.")
            {
            }
            column(ReasonCode; "Reason Code")
            {
            }
            column(AssignedDate; Format("Assigned Date", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(ResolutionDate; Format("Resolution Date 2", 0, '<Month,2>/<Day,2>/<Year4>'))
            {
            }
            column(AssignedUserID; "Assigned User ID")
            {
            }
            column(ReasonNotes; "Reason Notes")
            {
            }
            column(SecondCase; "Second Case")
            {
            }
            column(Status; Status)
            {
            }
            column(UserID; UserID)
            {
            }
            column(DateTimeProduced; DateTimeProduced)
            {
            }
            column(NoOfRecords; NoOfRecords)
            {
            }
            column(Duration; Duration)
            {
            }
            column(AscendingVar; AscendingVar)
            {
            }
            column(DurationText; DurationText)
            {
            }
            column(Location_Code; "Location Code")
            {
            }
            column(DepartmentSpecification; "Department Specification")
            {
            }
            column(Responsible_Owner; "Responsible Owner Current")
            {
            }
            column(Resolution_Code; "Resolution Code")
            {
            }
            trigger OnPreDataItem()
            var
            begin
                "Case WSG".Reset();
                "Case WSG".SetFilter("Reason Code", ReasonCode);
                "Case WSG".SetFilter("Entity Name", CustomerName);
                "Case WSG".SetFilter("Department Specification", DepartmentSpecification);
                if StatusVar <> StatusVar::Blank then "Case WSG".SetRange(Status, StatusVar);
                if LocationCode <> '' then "Case WSG".SetFilter("Location Code", LocationCode);
                if (StartingDate <> 0D) and (EndingDate <> 0D) then "Case WSG".SetFilter(SystemCreatedAt, Format(StartingDate) + '..' + Format(EndingDate));
                if (StartingDate <> 0D) and (EndingDate = 0D) then "Case WSG".SetFilter(SystemCreatedAt, '>=' + Format(StartingDate));
                if (StartingDate = 0D) and (EndingDate <> 0D) then "Case WSG".SetFilter(SystemCreatedAt, '<=' + Format(EndingDate));
                "Case WSG".SetCurrentKey("Reason Code");
                //"Case WSG".SetCurrentKey("Department Specification");
                if AscendingVar = AscendingVar::Ascending then
                    "Case WSG".Ascending(true)
                else
                    "Case WSG".Ascending(false);
            end;

            trigger OnAfterGetRecord()
            var
                CaseHeaderVar: Record "Case WSG";
            begin
                DurationText := '';
                Duration := 0;
                if ("Case WSG"."Resolution Date 2" = 0D) and ("Case WSG"."Assigned Date" <> 0D) then
                    Duration := Today() - "Case WSG"."Assigned Date";
                if ("Case WSG"."Assigned Date" = 0D) and ("Case WSG"."Resolution Date 2" = 0D) then
                    Duration := 0;
                if ("Case WSG"."Resolution Date 2" <> 0D) and ("Case WSG"."Assigned Date" <> 0D) then
                    Duration := "Case WSG"."Resolution Date 2" - "Case WSG"."Assigned Date";

                //DurationText := Format(Duration) + ' Days';
                DurationText := Format(Duration);
                //if DurationText = '0 Days'
                if DurationText = '0'
                  then
                    //DurationText := 'N/A';
                    DurationText := '0';
                //CaseHeaderVar.Reset();
                //CaseHeaderVar.SetFilter("Reason Code", ReasonCode);
                //CaseHeaderVar.SetFilter();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(ReasonCode; ReasonCode)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CaseReasonWSG: Record "Case Reason Code WSG";
                        var1: Integer;
                        CaseReasonListPage: Page "Case Reason Codes WSG";
                    begin
                        CaseReasonListPage.LookupMode(true);
                        if CaseReasonListPage.RunModal() = Action::LookupOK then begin
                            ReasonCode := CaseReasonListPage.ProduceValues();
                        end;
                    end;

                    trigger OnValidate()
                    var
                        CaseReasonWSG: Record "Case Reason Code WSG";
                        var1: Integer;
                    begin
                        CaseReasonWSG.Reset();
                        CaseReasonWSG.SetFilter(Code, ReasonCode);
                        if CaseReasonWSG.FindFirst() then
                            var1 := 1
                        else
                            Error('Data/Value modified for reason code global variable is not based on existing record in "Reason Code" table');
                    end;
                }
                field(CustomerName; CustomerName)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustomerList: Page "Customer List";
                        Customer: Record Customer;
                    begin
                        CustomerList.LookupMode(true);
                        if CustomerList.RunModal() = Action::LookupOK then CustomerName := CustomerList.ProduceValues2();
                    end;

                    trigger OnValidate()
                    var
                        CustomerList: Page "Customer List";
                        Customer: Record Customer;
                        var1: Integer;
                    begin
                        Customer.Reset();
                        Customer.SetFilter(Name, CustomerName);
                        if Customer.FindSet() then
                            var1 := 1
                        else
                            Error('Data/Value in Customer Name global variable has to be based on existing record in Customer Table');
                    end;
                }
                field(DepartmentSpecification; DepartmentSpecification)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CaseReasonDetail: Record CaseReasonDetail;
                        var1: Integer;
                        CaseReasonDetailPageVar: Page CaseReasonDetailList;
                    begin
                        CaseReasonDetailPageVar.LookupMode(true);
                        if CaseReasonDetailPageVar.RunModal() = Action::LookupOK then begin
                            DepartmentSpecification := CaseReasonDetailPageVar.ProduceValues();
                        end;
                    end;

                    trigger OnValidate()
                    var
                        CaseReasonWSG: Record "Case Reason Code WSG";
                        var1: Integer;
                    begin
                        CaseReasonWSG.Reset();
                        CaseReasonWSG.SetFilter(Code, ReasonCode);
                        if CaseReasonWSG.FindFirst() then
                            var1 := 1
                        else
                            Error('Data/Value modified for reason code global variable is not based on existing record in "Reason Code" table');
                    end;
                }
                field(LocationCode; LocationCode)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Location: Record Location;
                        var1: Integer;
                    begin
                        Location.Reset();
                        Location.SetFilter(Code, LocationCode);
                        if Location.FindFirst() then
                            var1 := 1
                        else
                            Error('Data/Value needs to be based on existing record in Location table');
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Location: Record Location;
                        var1: Integer;
                    begin
                        if Page.RunModal(Page::"Location List", Location) = Action::LookupOK then LocationCode := Location.Code;
                    end;
                }
                field(StatusVar; StatusVar)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field(StartingDate; StartingDate)
                {
                    ApplicationArea = All;
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = All;
                }
                field(AscendingVar; AscendingVar)
                {
                    ApplicationArea = All;
                }
            }
        }
        trigger OnOpenPage()
        var
        begin
            StatusVar := StatusVar::Blank;
        end;
    }
    var
        ReasonCode: Text;
        CustomerName: Text;
        DepartmentSpecification: Text;
        StartingDate: Date;
        EndingDate: Date;
        UserID: Text;
        DateTimeProduced: Text;
        NoOfRecords: Integer;
        Duration: Integer;
        AscendingVar: Enum AscendingDescending;
        DurationText: Text;
        LocationCode: Text;
        StatusVar: enum "Case Statuses WSG";

    trigger OnInitReport()
    var
    begin
        UserID := UserID();
        DateTimeProduced := Format(CurrentDateTime, 0, '<Month,2>/<Day,2>/<Year4> <Hours12>:<Minutes,2> <AM/PM>');
    end;

    procedure GetValues(DepSpec: Text; ReasCode: Text; CustName: Text)
    var
    begin
        ReasonCode := ReasCode;
        DepartmentSpecification := DepSpec;
        CustomerName := CustName;
    end;
}
