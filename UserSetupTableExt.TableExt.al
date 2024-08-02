tableextension 55138 UserSetupTableExt extends "User Setup"
{
    fields
    {
        field(55101; "Can Delete Sales Orders"; Boolean)
        {
        }
        field(55102; "Allow Item Variants"; Boolean)
        {
        }
        field(55103; "Can Modify Item No."; Boolean)
        {
        }
        field(55104; "Finance Block"; Boolean)
        {
        }
        field(55105; "Item Card"; Boolean)
        {
        }
        field(55108; "Payment Method Block"; Boolean)
        {
        }
        field(55109; "Terms Control"; Boolean)
        {
        }
        field(55110; "Install Apps/Extensions"; Boolean)
        {
        }
        field(55111; "Modify Department Performing"; Boolean)
        {
        }
        field(55112; "Modify Department Requesting"; Boolean)
        {
        }
        field(55113; "Modify Root Cause"; Boolean)
        {
        }
        field(55114; "Can View Operation Barcodes"; Boolean)
        {
            trigger OnValidate()
            var
            begin
                if Rec."Can View Operation Barcodes" = true then begin
                    if Dialog.Confirm('This will allow user: ' + UserId() + ' ' + 'to view operation barcodes on Production Order Cover Sheet Report when run. Do you wish to mark boolean table field to true?', true)then exit
                    else
                    begin
                        Rec."Can View Operation Barcodes":=xRec."Can View Operation Barcodes";
                        Rec.Modify();
                    end;
                end;
            end;
        }
        field(55115; "Can Modify/Insert PM Records"; Boolean)
        {
        }
        field(55117; "Modify Root Cause Department"; Boolean)
        {
        }
        field(55118; "Can Delete Internal Rework Rec"; Boolean)
        {
        }
        field(55119; "User Permission Set Visible"; Boolean)
        {
        }
    }
}
