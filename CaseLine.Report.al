report 55199 CaseLine
{
    RDLCLayout = './ReportLayouts/CaseLine.rdl';
    DefaultLayout = Excel;
    ExcelLayout = './ReportLayouts/CaseLine.xlsx';

    dataset
    {
        dataitem(CaseLine; CaseLine)
        {
            column(No; "No.")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(DepartmentDimension; "Department Dimension")
            {
            }
            column(CaseNo; "Case No.")
            {
            }
            column(ReasonCode; "Reason Code")
            {
            }
            column(AssignedUserID; "Assigned User ID")
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
            column(SalesRecordNo; "Sales Record No.")
            {
            }
            column(Name; Name)
            {
            }
            column(LineNo; "Line No.")
            {
            }
            column(Type; Type)
            {
            }
            column(QuantityTotal; QuantityTotal)
            {
            }
            column(TotalNoOfLines; TotalNoOfLines)
            {
            }
            column(SalesOrderNo; SalesOrderNo)
            {
            }
            column(SubFunction; "Department Specification")
            {
            }
            trigger OnPreDataItem()
            var
                var1: Text;
            begin
                CaseLine.Reset();
                CaseLine.SetFilter("Reason Code", ReasonCode);
                CaseLine.SetFilter("No.", No);
                if(StartingDate <> 0D) and (EndingDate <> 0D)then CaseLine.SetFilter(SystemCreatedAt, Format(StartingDate) + '..' + Format(EndingDate));
                if(StartingDate = 0D) and (EndingDate <> 0D)then CaseLine.SetFilter(SystemCreatedAt, '<=' + Format(EndingDate));
                if(StartingDate <> 0D) and (EndingDate = 0D)then CaseLine.SetFilter(SystemCreatedAt, '>=' + Format(StartingDate));
                if DepartmentSpecificationVar <> '' then CaseLine.SetFilter("Department Specification", DepartmentSpecificationVar);
            end;
            trigger OnAfterGetRecord()
            var
                var1: Integer;
                CaseLinevar: Record CaseLine;
            begin
                var1:=var1 + 1;
                if var1 = 1 then begin
                    CaseLinevar.Reset();
                    CaseLinevar.SetFilter("Reason Code", ReasonCode);
                    CaseLinevar.SetFilter("No.", No);
                    if(StartingDate <> 0D) and (EndingDate <> 0D)then CaseLinevar.SetFilter(SystemCreatedAt, Format(StartingDate) + '..' + Format(EndingDate));
                    if(StartingDate = 0D) and (EndingDate <> 0D)then CaseLinevar.SetFilter(SystemCreatedAt, '<=' + Format(EndingDate));
                    if(StartingDate <> 0D) and (EndingDate = 0D)then CaseLinevar.SetFilter(SystemCreatedAt, '>=' + Format(StartingDate));
                    CaseLineVar.CalcSums(Quantity);
                    QuantityTotal:=CaseLineVar.Quantity;
                    TotalNoOfLines:=CaseLineVar.Count();
                    SalesOrderNo:='';
                    SalesOrderNo:=CaseLine."Sales Record No.";
                end;
            /*if
                ReasonCode = 'Blank'
                then
                begin
                    if
                    CaseLine."Reason Code" <> ''
                    then
                    CurrReport.Skip();
                end;*/
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

                    trigger OnLookup(var Text: Text): Boolean var
                        CaseReasonWSG: Record "Case Reason Code WSG";
                        var1: Integer;
                        CaseReasonListPage: Page "Case Reason Codes WSG";
                    begin
                        CaseReasonListPage.LookupMode(true);
                        if CaseReasonListPage.RunModal() = Action::LookupOK then begin
                            ReasonCode:=CaseReasonListPage.ProduceValues();
                        end;
                    end;
                    trigger OnValidate()
                    var
                        CaseReasonWSG: Record "Case Reason Code WSG";
                        var1: Integer;
                    begin
                        if ReasonCode = 'Blank' then var1:=1
                        else
                        begin
                            CaseReasonWSG.Reset();
                            CaseReasonWSG.SetFilter(Code, ReasonCode);
                            if CaseReasonWSG.FindFirst()then var1:=1
                            else
                                Error('Data/Value modified for reason code global variable is not based on existing record in "Reason Code" table');
                        end;
                    end;
                }
                field(DepartmentSpecificationVar; DepartmentSpecificationVar)
                {
                    ApplicationArea = All;
                    Caption = 'Sub-Function';

                    trigger OnLookup(var Text: Text): Boolean var
                        CaseReasonDetail: Record CaseReasonDetail;
                    begin
                        CaseReasonDetail.Reset();
                        CaseReasonDetail.SetFilter("Reason Code", ReasonCode);
                        if Page.RunModal(Page::CaseReasonDetailList, CaseReasonDetail) = Action::LookupOK then DepartmentSpecificationVar:=CaseReasonDetail.Code;
                    end;
                    trigger OnValidate()
                    var
                        CaseReasonDetail: Record CaseReasonDetail;
                        var1: Integer;
                    begin
                        CaseReasonDetail.Reset();
                        CaseReasonDetail.SetFilter("Reason Code", ReasonCode);
                        CaseReasonDetail.SetFilter(Code, DepartmentSpecificationVar);
                        if CaseReasonDetail.FindFirst()then var1:=1
                        else
                            Error('Value/data for "Sub-Function" needs to be based on an existing record in the "Case Reason Detail" table with respect to Reason Code value: ' + ReasonCode);
                    end;
                }
                field(RecordType; RecordType)
                {
                    ApplicationArea = All;
                }
                field(No; No)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean var
                        Item: Record Item;
                        Resource: Record Resource;
                        ItemListPageVar: Page "Item List";
                        ResourceListPageVar: Page "Resource List";
                    begin
                        if RecordType = RecordType::" " then Error('Record Type global variable has to have a value other than "blank" in order to lookup to records in a table');
                        if RecordType = RecordType::Item then begin
                            ItemListPageVar.LookupMode(true);
                            if ItemListPageVar.RunModal() = Action::LookupOK then No:=ItemListPageVar.ProdcueValues()end
                        else
                        begin
                            if RecordType = RecordType::Resource then begin
                                ResourceListPageVar.LookupMode(true);
                                if ResourceListPageVar.RunModal() = Action::LookupOK then No:=ResourceListPageVar.ProduceValues();
                            end;
                        end;
                    end;
                }
                field(StartingDate; StartingDate)
                {
                    ApplicationArea = All;
                }
                field(EndingDate; EndingDate)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var StartingDate: Date;
    EndingDate: Date;
    RecordType: Enum RecordType;
    No: Text;
    ReasonCode: Text;
    UserId: text;
    DateTimeProduced: Text;
    QuantityTotal: Decimal;
    TotalNoOfLines: Integer;
    SalesOrderNo: Text;
    DepartmentSpecificationVar: Text;
    trigger OnInitReport()
    var
    begin
        UserID:=UserID();
        DateTimeProduced:=Format(CurrentDateTime, 0, '<Month,2>/<Day,2>/<Year4> <Hours12>:<Minutes,2> <AM/PM>');
    end;
    procedure GetValues(DepSpec: Text; ReasCode: Text; CustName: Text)
    var
    begin
        ReasonCode:=ReasCode;
    end;
}
