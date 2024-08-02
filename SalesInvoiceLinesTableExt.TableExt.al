tableextension 55149 SalesInvoiceLinesTableExt extends "Sales Invoice Line"
{
    fields
    {
        field(50010; "Long Description"; Text[600])
        {
        }
        field(55101; "Assembly BOM";enum YesNo)
        {
        }
        field(55102; "Assigned User ID"; Code[50])
        {
        }
        field(55103; "Ship-To-State"; Text[50])
        {
        }
        field(55104; "Sales Order Created At"; Text[50])
        {
            ObsoleteState = Removed;
        }
        field(55105; "SalesOrder Created At"; DateTime)
        {
        }
        field(55106; "Shortcut Dimension 3 (Value)"; Text[50])
        {
        }
        field(55107; "Shortcut Dimension 4 (Value)"; Text[50])
        {
        }
        field(55108; "Shortcut Dimension 5 (Value)"; Text[50])
        {
        }
        field(55109; "Shortcut Dimension 6 (Value)"; Text[50])
        {
        }
        field(55110; "Shortcut Dimension 7 (Value)"; Text[50])
        {
        }
        field(55111; "Shortcut Dimension 8 (Value)"; Text[50])
        {
        }
        field(55112; Status;Enum "Sales Document Status")
        {
        }
    }
}
