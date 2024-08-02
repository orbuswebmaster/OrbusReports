report 55104 InspectionSheet
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Inspection Sheet';
    RDLCLayout = 'ReportLayouts/InspectionSheet.rdl';

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.", "Sell-to Customer Name";
            DataItemTableView = where("Document Type"=const("Return Order"));

            column(No_; "No.")
            {
            }
            column(Bill_to_Name; "Bill-to Name")
            {
            }
            column(Ship_to_Name; "Ship-to Name")
            {
            }
            dataitem(Line; "Sales Line")
            {
                column(Document_No_; "Document No.")
                {
                }
                column(Line_No_; "Line No.")
                {
                }
                column(Type; Type)
                {
                }
                column(No_OnSalesLine; "No.")
                {
                }
                column(ProdBOmLineItemNo; ProdBOmLineItemNo)
                {
                }
                column(ProdBOMLineDescription; ProdBOMLineDescription)
                {
                }
                column(Description; Description)
                {
                }
                column(ProdBOMLIneLineNo; ProdBOMLIneLineNo)
                {
                }
                column(Variant_Code; "Variant Code")
                {
                }
                column(ProdBOMLineVariant; ProdBOMLineVariant)
                {
                }
                trigger OnPreDataItem()
                var
                begin
                    Line.Reset();
                    Line.SetRange("Document No.", Header."No.");
                    Line.SetRange(Type, Line.Type::Item);
                end;
                trigger OnAfterGetRecord()
                var
                    SKU: Record "Stockkeeping Unit";
                    ProdBOMLine: Record "Production BOM Line";
                    ProdBomNo: Text;
                    TypeHelper: Codeunit "Type Helper";
                    LineBreak: Text[2];
                begin
                    ProdBOmLineItemNo:='';
                    ProdBOMLineDescription:='';
                    ProdBOMLIneLineNo:='';
                    Linebreak:=TypeHelper.CRLFSeparator();
                    SKU.Reset();
                    SKU.SetRange("Item No.", Line."No.");
                    SKU.SetRange("Variant Code", Line."Variant Code");
                    SKU.SetRange("Location Code", Line."Location Code");
                    if SKU.FindFirst()then begin
                        if SKU."Production BOM No." <> '' then begin
                            ProdBomNo:=SKU."Production BOM No.";
                            ProdBOMLine.Reset();
                            ProdBOMLine.SetFilter("Production BOM No.", ProdBomNo);
                            if ProdBOMLine.FindSet()then repeat ProdBOmLineItemNo:=ProdBOmLineItemNo + ProdBOMLine."No." + LineBreak;
                                    ProdBOMLineDescription:=ProdBOMLineDescription + ProdBOMLine.Description + LineBreak;
                                    ProdBOMLIneLineNo:=ProdBOMLIneLineNo + Format(ProdBOMLine."Line No.") + LineBreak;
                                    ProdBOMLineVariant:=ProdBOMLineVariant + ProdBOMLine."Variant Code" + LineBreak;
                                until ProdBOMLine.Next() = 0;
                            ProdBOmLineItemNo:=DelChr(ProdBOmLineItemNo, '>', LineBreak);
                            ProdBOMLineDescription:=DelChr(ProdBOMLineDescription, '>', LineBreak);
                            ProdBOMLIneLineNo:=DelChr(ProdBOMLIneLineNo, '>', LineBreak);
                            ProdBOMLineVariant:=DelChr(ProdBOMLineVariant, '>', LineBreak);
                        end;
                    end;
                end;
            }
        }
    }
    /*requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; SourceExpression)
                    {
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }*/
    var myInt: Integer;
    ProdBOmLineItemNo: Text;
    ProdBOMLineDescription: Text;
    ProdBOMLIneLineNo: Text;
    ProdBOMLineVariant: Text;
    local procedure GetCustomDataOnReport()
    var
        SalesLine: Record "Sales Line";
        SKU: Record "Stockkeeping Unit";
        ProdBOMLine: Record "Production BOM Line";
    begin
    end;
}
