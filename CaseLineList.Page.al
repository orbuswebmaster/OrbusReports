page 55195 CaseLineList
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Case Line';
    SourceTable = CaseLine;
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field("Case No."; Rec."Case No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Record No."; Rec."Sales Record No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = All;
                }
                field("SalesPerson Code"; Rec."SalesPerson Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Department Specification"; Rec."Department Specification")
                {
                    ApplicationArea = All;
                }
                field("Department Dimension"; Rec."Department Dimension")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Resolution Code"; Rec."Resolution Code")
                {
                    ApplicationArea = All;
                }
                field("Resolution Document"; Rec."Resolution Document")
                {
                    ApplicationArea = All;
                }
                field("Resolution No."; Rec."Resolution No.")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("DateTime Created"; Rec."DateTime Created")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
