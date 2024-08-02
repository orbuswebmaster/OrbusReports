reportextension 55193 ReportAuthorizationReportExt extends "Return Authorization"
{
    RDLCLayout = './ReportLayouts/ReturnAuthorizationCurrent.rdl';

    dataset
    {
        add("Sales Header")
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
        }
        add("Sales Line")
        {
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
        }
        modify("Sales Line")
        {
        trigger OnAfterAfterGetRecord()
        var
            SalesCommentLine: Record "Sales Comment Line";
            LineBreak: Text;
            TypeHelper: Codeunit "Type Helper";
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
        }
        modify("Sales Header")
        {
        trigger OnBeforeAfterGetRecord()
        var
        begin
            CityStateZipCountry:="Sales Header"."Ship-to City (Custom)" + ', ' + "Sales Header"."Ship-To County (Custom)" + ' ' + "Sales Header"."Ship-To Post Code (Custom)" + ' ' + "Sales Header"."Ship-To CountryRegion (Custom)";
        end;
        }
    }
    var CityStateZipCountry: Text;
    Comment: Text;
}
