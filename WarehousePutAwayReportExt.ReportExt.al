reportextension 55131 WarehousePutAwayReportExt extends "Put-away List"
{
    RDLCLayout = './ReportLayouts/OrbusWarehousePutAway.rdl';

    dataset
    {
        add(WhseActLine)
        {
            column(EncodedSourceNo; EncodedSourceNo)
            {
            }
        }
        modify(WhseActLine)
        {
        trigger OnBeforeAfterGetRecord()
        var
        begin
            GetBarcodes();
        end;
        }
    }
    var BarcodeString: Text;
    EncodedSourceNo: Text;
    local procedure GetBarcodes()
    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeFontProviderInterface: Interface "Barcode Font Provider";
        BarcodeFontProviderEnum: Enum "Barcode Font Provider";
        BarcodeString: Text;
        BarcodeString2: Text;
    begin
        BarcodeSymbology:=BarcodeSymbology::Code39;
        BarcodeFontProviderInterface:=BarcodeFontProviderEnum::IDAutomation1D;
        BarcodeString:=WhseActLine."Source No.";
        BarcodeFontProviderInterface.ValidateInput(BarcodeString, BarcodeSymbology);
        EncodedSourceNo:=BarcodeFontProviderInterface.EncodeFont(BarcodeString, BarcodeSymbology);
    end;
}
