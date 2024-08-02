reportextension 55198 MovementListReportExt extends "Movement List"
{
    RDLCLayout = './ReportLayouts/MovementList.rdl';

    dataset
    {
        modify("Warehouse Activity Header")
        {
        trigger OnBeforeAfterGetRecord()
        var
            BarcodeInterface: Interface "Barcode Font Provider";
        begin
            GetHeaderBarcodeValues();
            GetCurrentDateTimeandUserID();
            LineNo:=0;
        end;
        }
        add("Warehouse Activity Header")
        {
            column(No; "No.")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(AssignedUserID; "Assigned User ID")
            {
            }
            column(TodayVar; TodayVar)
            {
            }
            column(TimeVar; TimeVar)
            {
            }
            column(UserID; UserID)
            {
            }
            column(EncodedBarcodeMovementNo; EncodedBarcodeMovementNo)
            {
            }
        }
        modify("Warehouse Activity Line")
        {
        trigger OnBeforeAfterGetRecord()
        var
        begin
            GetLineBarcodeValues();
            GetLineNo();
        end;
        }
        add("Warehouse Activity Line")
        {
            column(LineNo; LineNo)
            {
            }
            column(ItemNo; "Item No.")
            {
            }
            column(VariantCode; "Variant Code")
            {
            }
            column(Description; Description)
            {
            }
            column(Zone; "Zone Code")
            {
            }
            column(BinCode; "Bin Code")
            {
            }
            column(ActivityType; "Activity Type")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(UnitofMeasureCode; "Unit of Measure Code")
            {
            }
            column(EncodedBarcodeItemNo; EncodedBarcodeItemNo)
            {
            }
        }
    }
    var EncodedBarcodeMovementNo: Text;
    EncodedBarcodeItemNo: Text;
    LineNo: Integer;
    TodayVar: Text;
    UserID: Text;
    TimeVar: Text;
    procedure GetHeaderBarcodeValues()
    var
        BarcodeInterface: Interface "Barcode Font Provider";
    begin
        BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeInterface.ValidateInput("Warehouse Activity Header"."No.", Enum::"Barcode Symbology"::Code39);
        EncodedBarcodeMovementNo:=BarcodeInterface.EncodeFont("Warehouse Activity Header"."No.", Enum::"Barcode Symbology"::Code39);
    end;
    procedure GetLineBarcodeValues()
    var
        BarcodeInterface: Interface "Barcode Font Provider";
        ItemReference: Record "Item Reference";
        BarcodeString: text;
    begin
        ItemReference.Reset();
        ItemReference.SetRange("Item No.", "Warehouse Activity Line"."Item No.");
        ItemReference.SetRange("Variant Code", "Warehouse Activity Line"."Variant Code");
        if ItemReference.FindFirst()then BarcodeString:=ItemReference."Reference No."
        else
            BarcodeString:="Warehouse Activity Line"."Item No.";
        BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeInterface.ValidateInput(BarcodeString, Enum::"Barcode Symbology"::Code39);
        EncodedBarcodeItemNo:=BarcodeInterface.EncodeFont(BarcodeString, Enum::"Barcode Symbology"::Code39);
    end;
    procedure GetLineNo()
    var
        var1: Integer;
    begin
        LineNo:=LineNo + 1;
    end;
    procedure GetCurrentDateTimeandUserID()
    var
    begin
        TodayVar:=Format(Today(), 0, '<Month Text> <Day>, <Year4>');
        TimeVar:=Format(Time(), 0, '<Hours12>:<Minutes,2>:<Seconds,2> <AM/PM>');
        UserID:=UserID();
    end;
}
