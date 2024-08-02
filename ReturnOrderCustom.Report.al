report 55194 ReturnOrderCustom
{
    RDLCLayout = './ReportLayouts/ReturnOrderCustom.rdl';
    ApplicationArea = All;
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            column(Ship_to_Address__Custom_; "Ship-to Address (Custom)")
            {
            }
            column(Ship_to_Address_2__Custom_; "Ship-to Address 2 (Custom)")
            {
            }
            column(Ship_to_City__Custom_; "Ship-to City (Custom)")
            {
            }
            column(Ship_to_Code__Custom_; "Ship-to Code (Custom)")
            {
            }
            column(Ship_to_Contact__Custom_; "Ship-to Contact (Custom)")
            {
            }
            column(Ship_To_CountryRegion__Custom_; "Ship-To CountryRegion (Custom)")
            {
            }
            column(Ship_To_County__Custom_; "Ship-To County (Custom)")
            {
            }
            column(Ship_to_Name__Custom_; "Ship-to Name (Custom)")
            {
            }
            column(Ship_to_Name_2__Custom_; "Ship-to Name 2 (Custom)")
            {
            }
            column(Ship_To_Post_Code__Custom_; "Ship-To Post Code (Custom)")
            {
            }
            column(Location_Code__Custom_; "Location Code (Custom)")
            {
            }
            column(CityStateZipCountry; CityStateZipCountry)
            {
            }
            column(Your_Reference; "Your Reference")
            {
            }
            column(RecordNo; RecordNo)
            {
            }
            column(SalesHeaderNos; SalesHeaderNos)
            {
            }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document No."=field("No.");

                column(No; "No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Comment; Comment)
                {
                }
                column(Document_No; "Document No.")
                {
                }
                column(Line_No; "Line No.")
                {
                }
                /*trigger OnPreDataItem()
            var
            begin
                "Sales Line".Reset();
                "Sales Line".SetFilter("Document No.", "Sales Header"."No.");
            end;*/
                trigger OnAfterGetRecord()
                var
                    SalesCommentLine: Record "Sales Comment Line";
                    LineBreak: Text;
                    TypeHelper: Codeunit "Type Helper";
                begin
                    if "Sales Line".Type = "Sales Line".Type::" " then CurrReport.Skip()
                    else
                    begin
                        LineBreak:=TypeHelper.CRLFSeparator();
                        Comment:='';
                        SalesCommentLine.Reset();
                        SalesCommentLine.SetRange("No.", "Sales Line"."Document No.");
                        SalesCommentLine.SetRange("Document Line No.", "Sales Line"."Line No.");
                        if SalesCommentLine.FindSet()then repeat Comment:=Comment + SalesCommentLine.Comment + LineBreak;
                            until SalesCommentLine.Next() = 0;
                        if Comment = '' then Comment:=''
                        else
                        begin
                            Comment:=DelChr(Comment, '>', LineBreak);
                            Comment:='Comments: ' + LineBreak + Comment;
                        end;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
                var1: Integer;
                var2: Integer;
            begin
                GetHeader();
                CityStateZipCountry:="Sales Header"."Ship-to City (Custom)" + ', ' + "Sales Header"."Ship-To County (Custom)" + ' ' + "Sales Header"."Ship-To Post Code (Custom)" + ' ' + "Sales Header"."Ship-To CountryRegion (Custom)";
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(SalesHeaderNos; SalesHeaderNos)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Header No';
                    Visible = VisibleVar1;
                    Editable = false;
                }
            }
        }
        trigger OnOpenPage()
        var
        begin
            if SalesHeaderNos = '' then VisibleVar1:=false
            else
                VisibleVar1:=true;
        end;
        var VisibleVar1: Boolean;
    }
    var CityStateZipCountry: Text;
    Comment: Text;
    RecordNo: Text;
    SalesHeaderNos: Text;
    procedure GetValues(var1: Text)
    var
    begin
        SalesHeaderNos:=var1;
    end;
    procedure GetHeader()
    var
    begin
        RecordNo:="Sales Header"."No.";
    end;
}
