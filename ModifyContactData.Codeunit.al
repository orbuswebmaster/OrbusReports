codeunit 55195 ModifyContactData
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.Reset();
        if SalesHeader.FindSet()then repeat if SalesHeader."Sell-to Contact No." <> '' then begin
                    SalesHeader."Sell-To Contact No. (Custom)":=SalesHeader."Sell-to Contact No.";
                    SalesHeader."Sell-To Contact Name (Custom)":=SalesHeader."Sell-to Contact";
                    SalesHeader."Sell-To Phone No. (Custom)":=SalesHeader."Sell-to Phone No.";
                    SalesHeader."Sell-To Email (Custom)":=SalesHeader."Sell-to E-Mail";
                    SalesHeader.Modify();
                end;
            until SalesHeader.Next() = 0 end;
    procedure SellToEmailCustom(SellToEmailCustom: Text): Integer var
        Contact: Record Contact;
    begin
        Contact.Reset();
        Contact.SetRange("E-Mail", SellToEmailCustom);
        if Contact.FindFirst()then exit(1)
        else
        begin
            if Dialog.Confirm('There is no record in Contact table with value of ' + SellToEmailCustom + ' for email. Would you still like to modify data to this value?', true)then exit(2)
            else
                exit(3)end;
    end;
    procedure SellToEmailCustom1(SellToEmailCustom: Text; SellToContactNoCustom: Text; SellToContactNameCustom: Text; SelltoEmail: Text)
    var
        Contact: Record Contact;
    begin
        Contact.Reset();
        Contact.SetRange("E-Mail", SellToEmailCustom);
        if Contact.FindFirst()then begin
            SellToContactNoCustom:=Contact."No.";
            SellToContactNameCustom:=Contact.Name;
            SelltoEmail:=SellToEmailCustom;
        /*SalesHeader.Modify();*/
        end;
    end;
    procedure SellToEmailCustom2(SellToEmailCustom: Text; SellToEmail: Text; SalesHeader: Record "Sales Header")
    var
        Contact: Record Contact;
    begin
        SellToEmailCustom:=SellToEmail;
        SalesHeader.Modify();
    end;
/*procedure SellToEmailCustom3()
    var
    Contact: Record Contact;
    begin
                Contact.Reset();
                Contact.SetRange("E-Mail", Rec."Sell-To Email (Custom)");
                if
                Contact.FindFirst()
                then
                    begin
                        Rec."Sell-To Contact No. (Custom)" := Contact."No.";
                        Rec."Sell-To Contact Name (Custom)" := Contact.Name;
                        Rec."Sell-to E-Mail" := Rec."Sell-To Email (Custom)";
                        Rec.Modify();
                    end;


    end;*/
}
