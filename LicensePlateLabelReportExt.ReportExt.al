reportextension 55109 LicensePlateLabelReportExt extends "LPM License Plate Label"
{
    RDLCLayout = './ReportLayouts/OrbusLicensePlateLabel.rdl';

    dataset
    {
        add(diLicensePlate)
        {
            column(CustomBarcode39; CustomBarcode39)
            {
            }
            column(Description; Description)
            {
            }
            column(Status; Status)
            {
            }
        }
        modify(diLicensePlate)
        {
        trigger OnAfterAfterGetRecord()
        var
        begin
            GetBarcodes();
        end;
        }
    }
    var CustomBarcode39: Text;
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
        BarcodeString:=diLicensePlate."No.";
        BarcodeFontProviderInterface.ValidateInput(BarcodeString, BarcodeSymbology);
        CustomBarcode39:=BarcodeFontProviderInterface.EncodeFont(BarcodeString, BarcodeSymbology);
    end;
}
