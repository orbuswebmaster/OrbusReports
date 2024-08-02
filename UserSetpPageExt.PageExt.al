pageextension 55124 UserSetpPageExt extends "User Setup"
{
    layout
    {
        addafter("Allow Posting To")
        {
            field("Can Delete Sales Orders"; Rec."Can Delete Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Can Delete Sales Orders';
                ToolTip = 'This boolean field allows users to delete Sales Orders if toggled to true';
            }
            field("Allow Item Variants"; Rec."Allow Item Variants")
            {
                Caption = 'Allow Item Variants';
                ApplicationArea = All;
                ToolTip = 'If this boolean field is marked "true", then users will be able to insert records into Item Variants table';
            }
            field("Can Modify Item No."; Rec."Can Modify Item No.")
            {
                ApplicationArea = All;
                Caption = 'Can Modify item No.';
                Tooltip = 'If this boolean field has a value of "true", then users will be able to modify the "No." table field for item records';
            }
            field("Finance Block"; Rec."Finance Block")
            {
                ApplicationArea = All;
                Caption = 'Finance Block';
            }
            field("Payment Method Block"; Rec."Payment Method Block")
            {
                ApplicationArea = All;
                Caption = 'Payment Method Block';
            }
            field("Item Card"; Rec."Item Card")
            {
                ApplicationArea = All;
                Caption = 'Item Card';
            }
            field("Terms Control"; Rec."Terms Control")
            {
                ApplicationArea = All;
                Caption = 'Terms Control';
            }
            field("Can View Operation Barcodes"; Rec."Can View Operation Barcodes")
            {
                ApplicationArea = All;
            }
            field("Modify Department Requesting"; Rec."Modify Department Requesting")
            {
                ApplicationArea = All;
            }
            field("Modify Department Performing"; Rec."Modify Department Performing")
            {
                ApplicationArea = All;
            }
            field("Modify Root Cause"; Rec."Modify Root Cause")
            {
                ApplicationArea = All;
            }
            field("Modify Root Cause Department"; Rec."Modify Root Cause Department")
            {
                ApplicationArea = All;
            }
            field("Can Modify/Insert PM Records"; Rec."Can Modify/Insert PM Records")
            {
                ApplicationArea = All;
            }
            field("Can Delete Internal Rework Rec"; Rec."Can Delete Internal Rework Rec")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                begin
                    if Rec."Can Delete Internal Rework Rec" = true then begin
                        if Dialog.Confirm('This will allow User: ' + Rec."User ID" + ' do delete records in Internal Rework table. Allow this access for User: ' + Rec."User ID" + '?', true)then exit
                        else
                        begin
                            Rec."Can Delete Internal Rework Rec":=xRec."Can Delete Internal Rework Rec";
                            Rec.Modify();
                        end;
                    end;
                end;
            }
            field("User Permission Set Visible"; Rec."User Permission Set Visible")
            {
                ApplicationArea = All;
            }
        }
    }
}
