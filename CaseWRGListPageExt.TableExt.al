tableextension 55152 CaseWRGListPageExt extends "Case WSG"
{
    fields
    {
        modify(Status)
        {
            trigger OnAfterValidate()
            var
                RelatedRecordWSG: Record "Related Record WSG";
                SalesHeader: Record "Sales Header";
                SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                OpenReturnOrdersExists: Boolean;
            begin
                if Rec.Status <> xRec.Status then begin
                    if (Rec.Status <> Status::New) and ((Rec."Customer Complaint" = '') or (Rec."Customer Expectation" = '')) then
                        Error(CustomerComplaintorExpectationErrLbl);
                    //check if there is an open return order which is not posted yet and throw an error.
                    if (Rec.Status = Status::Resolved) or (Rec.Status = Status::Cancelled) then begin
                        RelatedRecordWSG.SetRange("Case No.", Rec."No.");
                        RelatedRecordWSG.SetRange("Table Id", Database::"Sales Header");
                        RelatedRecordWSG.SetRange("Document Page Id", Page::"Sales Return Order");
                        if RelatedRecordWSG.FindSet() then
                            repeat
                                if SalesHeader.Get(SalesHeader."Document Type"::"Return Order", RelatedRecordWSG."Document No.") then begin
                                    SalesCrMemoHeader.Reset();
                                    SalesCrMemoHeader.SetRange("Return Order No.", SalesHeader."No.");
                                    if SalesCrMemoHeader.IsEmpty() then begin
                                        OpenReturnOrdersExists := true;
                                        break;
                                    end;
                                end;
                            until RelatedRecordWSG.Next() = 0;

                        if OpenReturnOrdersExists then
                            Error(OpenReturnOrderExistsErrLbl);
                    end;
                end;
            end;
        }
        field(55101; "SalesPerson Code"; Text[50])
        {
        }
        field(55102; "Department Specification"; Text[100])
        {
        }
        field(55103; "Sales Header No."; Text[100])
        {
            trigger OnValidate()
            var
                SalesRecordForCase: Record SalesRecordForCase;
                CaseLineListPart: Page CaseLineListPart;
            begin
            end;
        }
        field(55104; "Location Code"; Text[100])
        {
        }
        field(55105; Priority; Text[100])
        {
        }
        field(55106; "CS Status"; Text[100])
        {
        }
        field(55107; "Assigned Date"; Date)
        {
        }
        field(55108; "Follow Up Date"; Date)
        {
        }
        field(55109; "Resolution Date 2"; Date)
        {
        }
        field(55110; "Second Case"; Enum YesNo)
        {
        }
        field(55111; "Sales Quote No."; Text[100])
        {
        }
        field(55112; "Customer Complaint"; Text[100])
        {
        }
        field(55113; "Customer Expectation"; Text[100])
        {
        }
        field(55114; "Lookup Type"; Enum LookupTypeNew)
        {
        }
        field(55115; "Sales Invoice Header No."; Text[100])
        {
        }
        field(55116; "Must Arrive Date"; Date)
        {
        }
        field(55117; "Tracking No."; Text[20])
        {
        }
        field(55118; "Describe Issue Blob"; Blob)
        {
        }
        field(55119; "Responsible Owner Current"; Text[100])
        {
        }
        field(55120; "Ship To Address"; Text[200])
        {
        }
        field(55121; "Ship To Address 2"; Text[200])
        {
        }
        field(55122; "Ship To Name"; Text[200])
        {
        }
        field(55123; "City"; Text[200])
        {
        }
        field(55124; "State"; Text[200])
        {
        }
        field(55125; "Post Code"; Text[200])
        {
        }
        field(55126; "Ship To Contact"; Text[200])
        {
        }
        field(55127; "Describe Issue"; Text[2048])
        {
        }
        field(55128; "External Doc No."; Text[200])
        {
        }
        field(55129; "Shipment Date"; Date)
        {
        }
        field(55130; "Contact Email 2"; Text[100])
        {
        }
        modify("Entity No.")
        {
            trigger OnAfterValidate()
            var
                Customer: Record Customer;
            begin
                Customer.Reset();
                Customer.SetRange("No.", Rec."Entity No.");
                if Customer.FindFirst() then Rec."SalesPerson Code" := Customer."Salesperson Code";
            end;
        }
    }
    keys
    {
        key(Secondary; "Reason Code")
        {
        }
        key(Secondary2; "Department Specification")
        {
        }
        key(Secondary3; "Created On DateTime")
        {
        }
    }

    var
        OpenReturnOrderExistsErrLbl: Label 'There are open Return Orders associated with this case.';
        CustomerComplaintorExpectationErrLbl: Label 'Customer Complaint (or) Customer Expectation cannot be empty.';

}
