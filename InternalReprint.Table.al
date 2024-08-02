table 55101 InternalReprint
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "User ID"; Code[50])
        {
        }
        field(3; "Date/Time Inserted"; DateTime)
        {
        }
        field(4; File; Blob)
        {
        }
        field(5; "Date Inserted"; Date)
        {
        }
        field(6; "Sales Header Record"; Text[100])
        {
        }
        field(7; "Sell-to Customer No."; Text[100])
        {
        }
        field(8; "Ship Date"; Date)
        {
        }
        field(9; "Shipping Agent Code"; Text[100])
        {
        }
        field(10; "Shipping Agent Service"; Text[100])
        {
        }
        field(11; "Production Order No."; Text[100])
        {
        }
        field(12; "Submitted By"; Text[100])
        {
        }
        field(13; "Date Issued"; Date)
        {
        }
        field(14; "Art Coordinator"; Text[100])
        {
        }
        field(15; "Reason For Reprint";Enum ReasonForReprint)
        {
        }
        field(16; "FIle Printed By"; Text[100])
        {
        }
        field(17; "At Fault User"; Text[500])
        {
        }
        field(18; Rerip; Boolean)
        {
        }
        field(19; Reprint; Boolean)
        {
        }
        field(20; Notes; Text[300])
        {
        }
        field(21; Item; Text[100])
        {
        }
        field(22; Material; Text[100])
        {
        }
        field(23; Size; Text[200])
        {
        }
        field(24; Quantity; Text[10])
        {
        }
        field(25; "Graphic Finished"; Boolean)
        {
        }
        field(26; "Location Code"; Text[50])
        {
        }
        field(27; "Project Manager"; Text[100])
        {
        }
        field(28; "Design No"; Text[100])
        {
        }
        field(29; Other; Text[200])
        {
        }
        field(30; "Detailing Metal"; Boolean)
        {
        }
        field(31; "Detailing Wood"; Boolean)
        {
        }
        field(32; "Instruction Detailing"; Boolean)
        {
        }
        field(33; "Department Requesting Rework"; Text[100])
        {
        }
        field(34; "Department Performing Rework"; Text[100])
        {
        }
        field(35; "Root Cause For Rework"; Text[100])
        {
        }
        field(37; "Root Cause Department"; Text[100])
        {
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
        }
    }
}
