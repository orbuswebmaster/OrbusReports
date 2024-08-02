report 55193 ProductionCoverSheet
{
    RDLCLayout = './ReportLayouts/ProductionCoverSheet.rdl';
    ApplicationArea = All;
    Caption = 'Production Cover Sheet';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            column(No; "No.")
            {
            }
            column(SourceNo; "Source No.")
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(Location; "Location Code")
            {
            }
            column(UserID; UserID)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(PrintedDate; PrintedDate)
            {
            }
            column(EncodedBarcodeProdOrderNo; EncodedBarcodeProdOrderNo)
            {
            }
            column(WorkDescriptionVar; WorkDescriptionVar)
            {
            }
            column(OperationNo; OperationNo)
            {
            }
            column(Operation3000Barcode; Operation3000Barcode)
            {
            }
            column(Operation3010Barcode; Operation3010Barcode)
            {
            }
            column(OperationNo3000; OperationNo3000)
            {
            }
            column(OperationNo3010; OperationNo3010)
            {
            }
            column(OperationNo3020; OperationNo3020)
            {
            }
            column(Operation3020Barcode; Operation3020Barcode)
            {
            }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                column(ItemNo; "Item No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(VariantCode; "Variant Code")
                {
                }
                column(BinCode; "Bin Code")
                {
                }
                column(ItemBarcode; ItemBarcode)
                {
                }
                column(Comment; Comment)
                {
                }
                column(VariantColumnHeader; VariantColumnHeader)
                {
                }
                trigger OnPreDataItem()
                var
                begin
                    "Prod. Order Line".Reset();
                    "Prod. Order Line".SetRange("Prod. Order No.", "Production Order"."No.");
                end;
                trigger OnAfterGetRecord()
                var
                    SalesCommentLine: Record "Sales Comment Line";
                    SalesLine: Record "Sales Line";
                    LineBreak: Text;
                    TypeHelper: Codeunit "Type Helper";
                begin
                    GetItemNoBarcodes();
                    GetOpertionNo();
                    GetVariantColumnHeader();
                    GetComments();
                /*Comment := '';
                LineBreak := TypeHelper.CRLFSeparator();
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", "Prod. Order Line"."Source No.");
                SalesLine.SetRange("No.", "Prod. Order Line"."Item No.");
                if
                SalesLine.FindFirst()
                then
                    begin
                        SalesCommentLine.Reset();
                        SalesCommentLine.SetRange("No.", SalesLine."Document No.");
                        SalesCommentLine.SetRange("Document Line No.", SalesLine."Line No.");
                        if
                        SalesCommentLine.FindSet()
                        then
                        repeat
                        Comment := Comment + Format(SalesCommentLine."Line No.") +': ' + SalesCommentLine.Comment + LineBreak;
                        until
                        SalesCommentLine.Next() = 0;
                    end
                else
                Comment := '';*/
                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
            begin
                SalesHeader.Reset();
                SalesHeader.SetRange("No.", "Production Order"."Source No.");
                if SalesHeader.FindFirst()then CustomerName:=SalesHeader."Bill-to Name";
                PrintedDate:=Format(Today(), 0, '<Month>/<Day>/<Year4>');
                UserID:=UserId();
                StartDate:=Format("Production Order"."Starting Date", 0, '<Month>/<Day><Year4>');
                EndDate:=Format("Production Order"."Ending Date", 0, '<Month>/<Day>/<Year4>');
                ProduceBarcodes();
                WorkDescriptionVar:=GetWorkOrder();
                GetOpertionNoandBarcodes();
            end;
        }
    }
    var CustomerName: Text;
    PrintedDate: Text;
    UserID: Text;
    StartDate: Text;
    EndDate: Text;
    EncodedBarcodeProdOrderNo: Text;
    WorkDescriptionVar: Text;
    ItemBarcode: Text;
    Comment: Text;
    OperationNo: Text;
    VariantColumnHeader: Text;
    OperationNo3000: Text;
    OperationNo3010: Text;
    OperationNo3020: Text;
    Operation3000Barcode: Text;
    Operation3010Barcode: Text;
    Operation3020Barcode: Text;
    trigger OnPostReport()
    var
        ProductionOrder: Record "Production Order";
        var1: Integer;
    begin
        ProductionOrder.Reset();
        ProductionOrder.SetFilter("No.", "Production Order"."No.");
        if ProductionOrder.FindSet()then repeat ProductionOrder."Printed By":=UserID();
                ProductionOrder."Printed At":=CurrentDateTime();
                if ProductionOrder.Modify()then var1:=1
                else
                    Error('Not all Production Order records were modified. Please run the report again');
            until ProductionOrder.Next() = 0;
    end;
    procedure ProduceBarcodes()
    var
        BarcodeInterface: Interface "Barcode Font Provider";
    begin
        BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeInterface.ValidateInput("Production Order"."No.", Enum::"Barcode Symbology"::Code39);
        EncodedBarcodeProdOrderNo:=BarcodeInterface.EncodeFont("Production Order"."No.", Enum::"Barcode Symbology"::Code39);
    end;
    procedure GetWorkOrder(): text;
    var
        SalesHeader: Record "Sales Header";
        TempBlob: Codeunit "Temp Blob";
        Inst: InStream;
        Out: OutStream;
        WorkDescription: Text;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("No.", "Production Order"."Source No.");
        if SalesHeader.FindFirst()then begin
            TempBlob.CreateInStream(Inst);
            TempBlob.CreateOutStream(Out);
            SalesHeader."Work Description".CreateInStream(Inst);
            SalesHeader.CalcFields("Work Description");
            Inst.ReadText(WorkDescription);
            exit(WorkDescription);
        end;
    end;
    procedure GetItemNoBarcodes()
    var
        BarcodeInterface: Interface "Barcode Font Provider";
    begin
        BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
        BarcodeInterface.ValidateInput("Prod. Order Line"."Item No.", Enum::"Barcode Symbology"::Code39);
        ItemBarcode:=BarcodeInterface.EncodeFont("Prod. Order Line"."Item No.", Enum::"Barcode Symbology"::Code39);
    end;
    procedure GetComments()
    var
        SalesCommentLine: Record "Sales Comment Line";
        SalesLine: Record "Sales Line";
        LineBreak: Text;
        TypeHelper: Codeunit "Type Helper";
    begin
        Comment:='';
        LineBreak:=TypeHelper.CRLFSeparator();
        SalesLine.Reset();
        SalesLine.SetRange("Document No.", "Production Order"."Source No.");
        SalesLine.SetRange("No.", "Prod. Order Line"."Item No.");
        if SalesLine.FindFirst()then begin
            SalesCommentLine.Reset();
            SalesCommentLine.SetRange("No.", SalesLine."Document No.");
            SalesCommentLine.SetRange("Document Line No.", SalesLine."Line No.");
            if SalesCommentLine.FindSet()then repeat Comment:=Comment + Format(SalesCommentLine."Line No.") + ': ' + SalesCommentLine.Comment + LineBreak;
                until SalesCommentLine.Next() = 0;
        end
        else
            Comment:='';
        if Comment = '' then exit
        else
        begin
            Comment:=DelChr(Comment, '>', LineBreak);
            Comment:='Comments:' + LineBreak + Comment;
        end;
    end;
    procedure GetOpertionNo()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        TypeHelper: Codeunit "Type Helper";
        LineBreak: Text;
    begin
        OperationNo:='';
        LineBreak:='';
        LineBreak:=TypeHelper.CRLFSeparator();
        ProdOrderRoutingLine.Reset();
        ProdOrderRoutingLine.SetRange("Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
        ProdOrderRoutingLine.SetRange("Routing Reference No.", "Prod. Order Line"."Line No.");
        if ProdOrderRoutingLine.FindSet()then repeat OperationNo:=OperationNo + ProdOrderRoutingLine."Operation No." + LineBreak;
            until ProdOrderRoutingLine.Next() = 0;
        if OperationNo = '' then OperationNo:='Operation Nos.: None'
        else
        begin
            OperationNo:=DelChr(OperationNo, '>', LineBreak);
            OperationNo:='Operation Nos:' + LineBreak + OperationNo;
        end;
    end;
    procedure GetVariantColumnHeader()
    var
        ProdOrderLine: Record "Prod. Order Line";
        var1: Integer;
    begin
        VariantColumnHeader:='';
        var1:=0;
        ProdOrderLine.Reset();
        ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
        if ProdOrderLine.FindSet()then repeat if ProdOrderLine."Variant Code" <> '' then var1:=var1 + 1;
            until ProdOrderLine.Next() = 0;
        if var1 > 0 then VariantColumnHeader:='Variant Code'
        else
            VariantColumnHeader:='';
    end;
    procedure GetOpertionNoandBarcodes()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        var1: Integer;
        var2: Integer;
        var3: Integer;
        BarcodeInterface: Interface "Barcode Font Provider";
        UserSetup: Record "User Setup";
    begin
        var1:=0;
        var2:=0;
        var3:=0;
        Operation3000Barcode:='';
        Operation3010Barcode:='';
        Operation3020Barcode:='';
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserID());
        if UserSetup.FindFirst()then begin
            if UserSetup."Can View Operation Barcodes" = true then begin
                ProdOrderRoutingLine.Reset();
                ProdOrderRoutingLine.SetRange("Prod. Order No.", "Production Order"."No.");
                ProdOrderRoutingLine.SetFilter("Operation No.", '3000');
                if ProdOrderRoutingLine.FindSet()then var1:=var1 + 1;
                ProdOrderRoutingLine.Reset();
                ProdOrderRoutingLine.SetRange("Prod. Order No.", "Production Order"."No.");
                ProdOrderRoutingLine.SetFilter("Operation No.", '3010');
                if ProdOrderRoutingLine.FindSet()then var2:=var2 + 1;
                ProdOrderRoutingLine.Reset();
                ProdOrderRoutingLine.SetRange("Prod. Order No.", "Production Order"."No.");
                ProdOrderRoutingLine.SetFilter("Operation No.", '3020');
                if ProdOrderRoutingLine.FindSet()then var3:=var3 + 1;
                if var1 > 0 then begin
                    OperationNo3000:='Operation No.: 3000';
                    BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeInterface.ValidateInput('3000', Enum::"Barcode Symbology"::Code39);
                    Operation3000Barcode:=BarcodeInterface.EncodeFont('3000', Enum::"Barcode Symbology"::Code39);
                end
                else
                    OperationNo3000:='';
                if var2 > 0 then begin
                    OperationNo3010:='Operation No.: 3010';
                    BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeInterface.ValidateInput('3010', Enum::"Barcode Symbology"::Code39);
                    Operation3010Barcode:=BarcodeInterface.EncodeFont('3010', Enum::"Barcode Symbology"::Code39);
                end
                else
                    OperationNo3010:='';
                if var3 > 0 then begin
                    OperationNo3020:='Operation No.: 3020';
                    BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeInterface.ValidateInput('3020', Enum::"Barcode Symbology"::Code39);
                    Operation3020Barcode:=BarcodeInterface.EncodeFont('3020', Enum::"Barcode Symbology"::Code39);
                end
                else
                    Operation3020Barcode:='';
            end;
        end;
    end;
}
