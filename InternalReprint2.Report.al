report 55192 InternalReprint2
{
    ApplicationArea = All;
    Caption = 'Internal Reprint';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './ReportLayouts/OrbusInternalReprint.rdl';

    dataset
    {
        dataitem(InternalReprint; InternalReprint)
        {
            column(EntryNo; "Entry No.")
            {
            }
            column(SourceNo; "Sales Header Record")
            {
            }
            column(ShipDate; "Ship Date")
            {
            }
            column(ShipDateText; ShipDateText)
            {
            }
            column(ShippingAgentCode; "Shipping Agent Code")
            {
            }
            column(ShippingAgentService; "Shipping Agent Service")
            {
            }
            column(ProductionOrderRecord; "Production Order No.")
            {
            }
            column(SubmittedBy; "Submitted By")
            {
            }
            column(DateIssued; "Date Issued")
            {
            }
            column(DateIssuedText; DateIssuedText)
            {
            }
            column(ArtCoordinator; "Art Coordinator")
            {
            }
            column(ReasonForReprint; "Reason For Reprint")
            {
            }
            column(FilePrintedBy; "FIle Printed By")
            {
            }
            column(AtFaultUser; "At Fault User")
            {
            }
            column(Rerip; Rerip)
            {
            }
            column(Reprint; Reprint)
            {
            }
            column(Notes; Notes)
            {
            }
            column(Item; Item)
            {
            }
            column(Material; Material)
            {
            }
            column(Size; Size)
            {
            }
            column(Quantity1; Quantity)
            {
            }
            column(GraphicFinished; "Graphic Finished")
            {
            }
            column(EncodedSalesHeaderNoBarcode; EncodedSalesHeaderNoBarcode)
            {
            }
            column(EncodedProductionOrderNoBarcode; EncodedProductionOrderNoBarcode)
            {
            }
            column(ReripText; ReripText)
            {
            }
            column(ReprintText; ReprintText)
            {
            }
            column(GraphicsFinishedText; GraphicsFinishedText)
            {
            }
            column(DetailingMetalText; DetailingMetalText)
            {
            }
            column(DetailingWoodText; DetailingWoodText)
            {
            }
            column(InstructionDetailingText; InstructionDetailingText)
            {
            }
            column(Other; Other)
            {
            }
            column(ProjectManager; "Project Manager")
            {
            }
            column(DesignNo; "Design No")
            {
            }
            column(LocationCode; "Location Code")
            {
            }
            column(DateTimeInserted; "Date/Time Inserted")
            {
            }
            column(DepartmentRequestingRework; "Department Requesting Rework")
            {
            }
            column(DepartmentToPerformRework; "Department Performing Rework")
            {
            }
            column(RootCauseForRework; "Root Cause For Rework")
            {
            }
            column(RootCauseDepartment; "Root Cause Department")
            {
            }
            column(OtherReasonCaption; OtherReasonCaption)
            {
            }
            column(ReripCaption; ReripCaption)
            {
            }
            column(ReprintCaption; ReprintCaption)
            {
            }
            column(FinishedCaption; FinishedCaption)
            {
            }
            column(ValueForOther; ValueForOther)
            {
            }
            trigger OnAfterGetRecord()
            var
            begin
                GetBarcodeValues();
                ShipDateText:=Format(InternalReprint."Ship Date", 0, '<Month>/<Day>/<Year4>');
                DateIssuedText:=Format(InternalReprint."Date Issued", 0, '<Month>/<Day>/<Year4>');
                GetValuesForBooleanTableFields();
                GetYesNoForReripReprintGraphicsFinshed();
                ReripReprintFinishedVisible();
                OtherVisible();
            end;
        }
    }
    var EncodedSalesHeaderNoBarcode: Text;
    EncodedProductionOrderNoBarcode: Text;
    ShipDateText: Text;
    DateIssuedText: Text;
    ReripText: Text;
    ReprintText: Text;
    GraphicsFinishedText: Text;
    DetailingMetalText: Text;
    DetailingWoodText: Text;
    InstructionDetailingText: Text;
    CurrentDateTime: DateTime;
    Material: Text[100];
    Quantity1: Text[10];
    Notes: Text[300];
    ProductionOrderRecord: Text;
    ClientName: Text;
    ShipDate: Date;
    ShippingAgentCode: Text;
    ShippingAgentService: Text;
    SourceNo: Text;
    SubmittedBy: Text;
    DateIssued: Date;
    ArtCoordinator: Text;
    ReasonForReprint: Enum ReasonForReprint;
    FilePrintedBy: Text;
    AtFaultUser: Text;
    Rerip: Boolean;
    Reprint: Boolean;
    Item: Text[100];
    Size: Text[200];
    GraphicFinished: Boolean;
    EntryNo: Text;
    LocationCode: Text;
    MandatoryVar: Boolean;
    DateTimeVar: DateTime;
    MandatoryVar1: Boolean;
    DepartmentRequestingRework: Text;
    DepartmentToPerformRework: Text;
    RootCauseForRework: Text;
    ProjectManager: Text;
    DesignNo: Text;
    ValueForOther: Text;
    DetailingMetal: Boolean;
    DetailingWood: Boolean;
    InstructionDetailing: Boolean;
    DateTimeInserted: Text;
    RootCauseDepartment: Text;
    ReripCaption: Text;
    ReprintCaption: Text;
    FinishedCaption: Text;
    OtherReasonCaption: Text;
    procedure GetBarcodeValues()
    var
        BarcodeSymbology: Enum "Barcode Font Provider";
        BarcodeInterface: Interface "Barcode Font Provider";
        EncodedSalesOrderNoBarcode: Text;
    begin
        if InternalReprint."Production Order No." = '' then begin
            BarcodeInterface:=BarcodeSymbology::IDAutomation1D;
            BarcodeInterface.ValidateInput(InternalReprint."Sales Header Record", Enum::"Barcode Symbology"::Code128);
            EncodedSalesHeaderNoBarcode:=BarcodeInterface.EncodeFont(InternalReprint."Sales Header Record", Enum::"Barcode Symbology"::Code128);
        end
        else
        begin
            BarcodeInterface:=BarcodeSymbology::IDAutomation1D;
            BarcodeInterface.ValidateInput(InternalReprint."Sales Header Record", Enum::"Barcode Symbology"::Code128);
            BarcodeInterface.ValidateInput(InternalReprint."Production Order No.", Enum::"Barcode Symbology"::Code128);
            EncodedSalesHeaderNoBarcode:=BarcodeInterface.EncodeFont(InternalReprint."Sales Header Record", Enum::"Barcode Symbology"::Code128);
            EncodedProductionOrderNoBarcode:=BarcodeInterface.EncodeFont(InternalReprint."Production Order No.", Enum::"Barcode Symbology"::Code128);
        end;
    end;
    procedure GetValuesForBooleanTableFields()
    var
    begin
        if InternalReprint."Detailing Metal" = true then DetailingMetalText:='Yes'
        else
            DetailingMetalText:='No';
        if InternalReprint."Detailing Wood" = true then DetailingWoodText:='Yes'
        else
            DetailingWoodText:='No';
        if InternalReprint."Instruction Detailing" = true then InstructionDetailingText:='Yes'
        else
            InstructionDetailingText:='No';
    end;
    procedure GetYesNoForReripReprintGraphicsFinshed()
    var
    begin
        if InternalReprint.Reprint = true then ReprintText:='Yes'
        else
            ReprintText:='No';
        if InternalReprint.Rerip = true then ReripText:='Yes'
        else
            ReripText:='No';
        if InternalReprint."Graphic Finished" = true then GraphicsFinishedText:='Yes'
        else
            GraphicsFinishedText:='No';
    end;
    procedure ReripReprintFinishedVisible()
    var
    begin
        if InternalReprint."Department Performing Rework" = 'Graphics' then begin
            ReripCaption:='RERIP';
            ReprintCaption:='REPRINT';
            FinishedCaption:='FINISHED';
        end
        else
        begin
            ReripCaption:='';
            ReprintCaption:='';
            FinishedCaption:='';
            ReripText:='';
            ReprintText:='';
            GraphicsFinishedText:='';
        end;
    end;
    procedure OtherVisible()
    var
    begin
        if InternalReprint."Root Cause For Rework" = 'Other' then begin
            OtherReasonCaption:='Other Reason';
            ValueForOther:=InternalReprint.Other;
        end
        else
        begin
            OtherReasonCaption:='';
            ValueForOther:='';
        end;
    end;
}
