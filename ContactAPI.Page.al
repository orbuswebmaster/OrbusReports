page 55122 ContactAPI
{
    ApplicationArea = All;
    SourceTable = Contact;
    PageType = API;
    EntityName = 'Contact';
    EntitySetName = 'Contact';
    APIPublisher = 'Orbus';
    APIGroup = 'Orbus';
    DelayedInsert = true;
    Caption = 'Contact API';

    layout
    {
        area(Content)
        {
            repeater(Main)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(EMail; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field(CSATMonthlySurvey; Rec."CSAT Monthly Survey")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if(Rec.Type <> Rec.Type::Company) or (Rec.Type <> Rec.Type::Person)then Error('Value for "Type" table field has to have a value of "Person" or "Company"');
                    end;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean var
    begin
        if(Rec.Type <> Rec.Type::Company) or (Rec.Type <> Rec.Type::Person)then Error('Value for "Type" table field has to have a value of "Person" or "Company"');
    end;
}
