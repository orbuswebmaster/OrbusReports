pageextension 55199 ContactCardPageExt extends "Contact Card"
{
    layout
    {
        addafter("E-Mail")
        {
            field("CSAT Monthly Survey"; Rec."CSAT Monthly Survey")
            {
                ApplicationArea = All;
            }
        }
    }
}
