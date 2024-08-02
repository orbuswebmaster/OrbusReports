reportextension 55184 StubCheckStubReportExt extends "Check (Stub/Check/Stub)"
{
    RDLCLayout = './ReportLayouts/StubCheckStub.rdl';

    dataset
    {
        add(GenJnlLine)
        {
            column(Orbus_Document_No_; "Document No.")
            {
            }
            column(Orbus_Document_Date; Format("Document Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
            column(Orbus_Description; Description)
            {
            }
            column(Orbus_Amount; Format(Amount, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_Inv__Discount__LCY_; Format("Inv. Discount (LCY)", 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_NetAmount; Format(Orbus_NetAmount, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_External_Document_No_; "External Document No.")
            {
            }
            column(Orbus_OverallTotal; Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Orbus_Account_No_; "Account No.")
            {
            }
            column(Orbus_CheckNo; Orbus_CheckNo)
            {
            }
            column(Orbus_BankAccountNo; Orbus_BankAccountNo)
            {
            }
            column(Orbus_BankRoutingNo; Orbus_BankRoutingNo)
            {
            }
            column(CurrentDate; CurrentDate)
            {
            }
            column(Orbus_VendorName; Orbus_VendorName)
            {
            }
            column(Orbus_VendorAddress1; Orbus_VendorAddress1)
            {
            }
            column(Orbus_VendorAddress2; Orbus_VendorAddress2)
            {
            }
            column(Orbus_VendorCity; Orbus_VendorCity)
            {
            }
            column(Orbus_VendorState; Orbus_VendorState)
            {
            }
            column(Orbus_VendorZipCode; Orbus_VendorZipCode)
            {
            }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {
            }
            column(Orbus_PayText; Orbus_PayText)
            {
            }
            column(Orbus_OverallTotalForCheck; Orbus_OverallTotalForCheck)
            {
            }
            column(Orbus_OverTotalText; Orbus_OverTotalText)
            {
            }
            column(Applies_to_Ext__Doc__No_; "Applies-to Ext. Doc. No.")
            {
            }
            column(OrbusJournal_Batch_Name; "Journal Batch Name")
            {
            }
            column(OrbusJournal_Template_Name; "Journal Template Name")
            {
            }
            column(OrbusLine_No_; "Line No.")
            {
            }
            column(Orbus_InvoiceDate; Orbus_InvoiceDate)
            {
            }
            column(Check_No; "Check No")
            {
            }
        }
        /*addbefore(CheckPages)
        {
            dataitem(GeneralJournalLine; "Gen. Journal Line")
            {
                RequestFilterFields = "Journal Batch Name", "Journal Template Name";
                RequestFilterHeading = 'Gen Journal Line Filters';
                DataItemTableView = WHERE("Journal Template Name" = filter('PAYMENTS'));

                column(TestAmount; Amount)
                {

                }
                column(TestJournal_Template_Name; "Journal Template Name")
                {

                }
                column(TestJournal_Batch_Name; "Journal Batch Name")
                {

                }
                column(TestLine_No_; "Line No.")
                {

                }
            }
        }*/
        modify(GenJnlLine)
        {
        RequestFilterFields = "Journal Template Name", "Journal Batch Name";

        trigger OnBeforeAfterGetRecord()
        var
            Vendor: Record Vendor;
            BankAccount: Record "Bank Account";
            var1: Integer;
            GeneralJournalLine: Record "Gen. Journal Line";
            TotalAmount: Decimal;
            TotalDisocunt: Decimal;
            PurchaseInvoiceHeader: Record "Purch. Inv. Header";
        begin
            CurrentDate:=Format(Today(), 0, '<Month Text> <Day>, <Year4>');
            Vendor.Reset();
            Vendor.SetRange("No.", GenJnlLine."Account No.");
            if Vendor.FindFirst()then begin
                Orbus_VendorName:=Vendor.Name;
                Orbus_VendorAddress1:=Vendor.Address;
                Orbus_VendorAddress2:=Vendor."Address 2";
                Orbus_VendorCity:=Vendor.City;
                Orbus_VendorState:=Vendor.County;
                Orbus_VendorZipcode:=Vendor."Post Code";
            end;
            PurchaseInvoiceHeader.Reset();
            PurchaseInvoiceHeader.SetRange("No.", GenJnlLine."Applies-to Doc. No.");
            if PurchaseInvoiceHeader.FindFirst()then Orbus_InvoiceDate:=Format(PurchaseInvoiceHeader."Posting Date", 0, '<Month>/<Day>/<Year4>');
            var1:=var1 + 1;
            if var1 = 1 then begin
                Orbus_BankAccountNo:='';
                Orbus_BankRoutingNo:='';
                Orbus_CheckNo:=GenJnlLine."Document No.";
            end;
            if Orbus_BankAccountNo = 'Not valid value for Bank Account No.' then Orbus_BankAccountNo:='Not valid value for Bank Account No.'
            else
            begin
                BankAccount.Reset();
                BankAccount.SetRange("No.", GenJnlLine."Bal. Account No.");
                if BankAccount.FindFirst()then begin
                    Orbus_BankAccountNo:=BankAccount."Bank Account No.";
                    Orbus_BankRoutingNo:=BankAccount."Transit No.";
                end
                else
                begin
                    Orbus_BankAccountNo:='Not valid value for Bank Account No.';
                    Orbus_BankRoutingNo:='';
                end;
            end;
            GeneralJournalLine.Reset();
            GeneralJournalLine.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
            GeneralJournalLine.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
            GeneralJournalLine.SetRange("Check No", GenJnlLine."Check No");
            GeneralJournalLine.CalcSums(Amount, "Inv. Discount (LCY)");
            TotalAmount:=GeneralJournalLine.Amount;
            TotalDisocunt:=GeneralJournalLine."Inv. Discount (LCY)";
            Orbus_OverallTotal:=TotalAmount - TotalDisocunt;
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalForCheck:='$*******' + Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_NetAmount:=GenJnlLine.Amount - GenJnlLine."Inv. Discount (LCY)";
            GetCheckNo();
            GetAmountTextForCheck();
        end;
        }
    }
    requestpage
    {
        layout
        {
            modify(UseCheckNo)
            {
                Visible = false;
            }
        }
    }
    var Orbus_NetAmount: Decimal;
    Orbus_OverallTotal: Decimal;
    Orbus_OverallTotalText1: Text;
    Orbus_OverallTotalForCheck: Text;
    CurrentDate: Text;
    Orbus_VendorName: Text;
    Orbus_VendorAddress1: Text;
    Orbus_VendorAddress2: Text;
    Orbus_VendorCity: Text;
    Orbus_VendorState: Text;
    Orbus_VendorZipCode: Text;
    Orbus_BankRoutingNo: Text;
    Orbus_BankAccountNo: Text;
    Orbus_CheckNo: Text;
    Orbus_PayText5Digits: Text;
    Orbus_PayText4Digits: Text;
    Orbus_PayText3Digits: Text;
    Orbus_PayText2Digits: Text;
    Orbus_PayText1Digit: Text;
    Orbus_OverTotalText: Text;
    Orbus_PayText: Text;
    Orbus_PayTextCents: Text;
    Orbus_PayCentsFirst: Text;
    Orbus_InvoiceDate: Text;
    local procedure GetCheckNo()
    var
        BankAccount: Record "Bank Account";
        var1: Integer;
    begin
    /*var1 := var1 + 1;
        if
        var1 = 1
        then begin
            BankAccount.Reset();
            BankAccount.SetRange("No.", GenJnlLine."Bal. Account No.");
            if
            BankAccount.FindFirst()
            then
                Orbus_CheckNo := IncStr(BankAccount."Last Check No.")
        end
        else
            exit*/
    end;
    local procedure GetAmountTextForCheck()
    var
    begin
        if StrLen(Orbus_OverallTotalText1) = 4 then begin
            if Orbus_OverallTotalText1.StartsWith('0')then Orbus_PayText1Digit:='';
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText1Digit:='One ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText1Digit:='Two ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText1Digit:='Three ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText1Digit:='Four ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText1Digit:='Five ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText1Digit:='Six ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText1Digit:='Seven ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText1Digit:='Eight ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText1Digit:='Nine ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_PayTextCents:='AND ' + DelStr(Orbus_OverallTotalText1, 1, 2) + '/' + '100';
            Orbus_PayText:='****' + Orbus_PayText1Digit + Orbus_PayTextCents;
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
        end;
        //
        if StrLen(Orbus_OverallTotalText1) = 5 then begin
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText2Digits:='Twenty ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText2Digits:='Thirty ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText2Digits:='Forty ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText2Digits:='Fifty ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText2Digits:='Sixty ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText2Digits:='Seventy ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText2Digits:='Eighty ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText2Digits:='Ninety ';
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 1);
            if Orbus_OverallTotalText1.StartsWith('0')then Orbus_PayText1Digit:='';
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText1Digit:='One ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText1Digit:='Two ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText1Digit:='Three ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText1Digit:='Four ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText1Digit:='Five ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText1Digit:='Six ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText1Digit:='Seven ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText1Digit:='Eight ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText1Digit:='Nine ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_PayTextCents:='AND ' + DelStr(Orbus_OverallTotalText1, 1, 3) + '/' + '100';
            Orbus_PayText:='****' + Orbus_PayText2Digits + Orbus_PayText1Digit + Orbus_PayTextCents;
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
        end;
        //
        if StrLen(Orbus_OverallTotalText1) = 5 then begin
            if Orbus_OverallTotalText1.StartsWith('10')then Orbus_PayText2Digits:='Ten ';
            if Orbus_OverallTotalText1.StartsWith('11')then Orbus_PayText2Digits:='Eleven ';
            if Orbus_OverallTotalText1.StartsWith('12')then Orbus_PayText2Digits:='Twelve ';
            if Orbus_OverallTotalText1.StartsWith('13')then Orbus_PayText2Digits:='Thirteen ';
            if Orbus_OverallTotalText1.StartsWith('14')then Orbus_PayText2Digits:='Fourteen ';
            if Orbus_OverallTotalText1.StartsWith('15')then Orbus_PayText2Digits:='Fifteen ';
            if Orbus_OverallTotalText1.StartsWith('16')then Orbus_PayText2Digits:='Sixteen ';
            if Orbus_OverallTotalText1.StartsWith('17')then Orbus_PayText2Digits:='Seventeen ';
            if Orbus_OverallTotalText1.StartsWith('18')then Orbus_PayText2Digits:='Eighteen ';
            if Orbus_OverallTotalText1.StartsWith('19')then Orbus_PayText2Digits:='Nineteen ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_PayTextCents:='AND ' + DelStr(Orbus_OverallTotalText1, 1, 3) + '/' + '100';
            Orbus_PayText:='****' + Orbus_PayText2Digits + Orbus_PayText1Digit + Orbus_PayTextCents;
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
        end;
        //
        if StrLen(Orbus_OverallTotalText1) = 6 then begin
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText3Digits:='One Hundred ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText3Digits:='Two Hundred ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText3Digits:='Three Hundred ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText3Digits:='Four Hundred ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText3Digits:='Five Hundred ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText3Digits:='Six Hundred ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText3Digits:='Seven Hundred ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText3Digits:='Eight Hundred ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText3Digits:='Nine Hundred ';
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 1);
            if Orbus_OverallTotalText1.StartsWith('10')then Orbus_PayText2Digits:='Ten ';
            if Orbus_OverallTotalText1.StartsWith('11')then Orbus_PayText2Digits:='Eleven ';
            if Orbus_OverallTotalText1.StartsWith('12')then Orbus_PayText2Digits:='Twelve ';
            if Orbus_OverallTotalText1.StartsWith('13')then Orbus_PayText2Digits:='Thirteen ';
            if Orbus_OverallTotalText1.StartsWith('14')then Orbus_PayText2Digits:='Fourteen ';
            if Orbus_OverallTotalText1.StartsWith('15')then Orbus_PayText2Digits:='Fifteen ';
            if Orbus_OverallTotalText1.StartsWith('16')then Orbus_PayText2Digits:='Sixteen ';
            if Orbus_OverallTotalText1.StartsWith('17')then Orbus_PayText2Digits:='Seventeen ';
            if Orbus_OverallTotalText1.StartsWith('18')then Orbus_PayText2Digits:='Eighteen ';
            if Orbus_OverallTotalText1.StartsWith('19')then Orbus_PayText2Digits:='Nineteen ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText2Digits:='Twenty ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText2Digits:='Thirty ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText2Digits:='Forty ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText2Digits:='Fifty ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText2Digits:='Sixty ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText2Digits:='Seventy ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText2Digits:='Eighty ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText2Digits:='Ninety ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 2);
            if Orbus_OverallTotalText1.StartsWith('0')then Orbus_PayText1Digit:='';
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText1Digit:='One ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText1Digit:='Two ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText1Digit:='Three ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText1Digit:='Four ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText1Digit:='Five ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText1Digit:='Six ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText1Digit:='Seven ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText1Digit:='Eight ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText1Digit:='Nine ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_PayTextCents:='AND ' + DelStr(Orbus_OverallTotalText1, 1, 4) + '/' + '100';
            Orbus_PayText:='****' + Orbus_PayText3Digits + Orbus_PayText2Digits + Orbus_PayText1Digit + Orbus_PayTextCents;
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
        end;
        //
        if StrLen(Orbus_OverallTotalText1) = 8 then begin
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText4Digits:='One Thousand ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText4Digits:='Two Thousand ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText4Digits:='Three Thousand ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText4Digits:='Four Thousand ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText4Digits:='Five Thousand ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText4Digits:='Six Thousand ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText4Digits:='Seven Thousand ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText4Digits:='Eight Thousand ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText4Digits:='Nine Thousand ';
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 2);
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText3Digits:='One Hundred ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText3Digits:='Two Hundred ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText3Digits:='Three Hundred ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText3Digits:='Four Hundred ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText3Digits:='Five Hundred ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText3Digits:='Six Hundred ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText3Digits:='Seven Hundred ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText3Digits:='Eight Hundred ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText3Digits:='Nine Hundred ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 3);
            if Orbus_OverallTotalText1.StartsWith('10')then Orbus_PayText2Digits:='Ten ';
            if Orbus_OverallTotalText1.StartsWith('11')then Orbus_PayText2Digits:='Eleven ';
            if Orbus_OverallTotalText1.StartsWith('12')then Orbus_PayText2Digits:='Twelve ';
            if Orbus_OverallTotalText1.StartsWith('13')then Orbus_PayText2Digits:='Thirteen ';
            if Orbus_OverallTotalText1.StartsWith('14')then Orbus_PayText2Digits:='Fourteen ';
            if Orbus_OverallTotalText1.StartsWith('15')then Orbus_PayText2Digits:='Fifteen ';
            if Orbus_OverallTotalText1.StartsWith('16')then Orbus_PayText2Digits:='Sixteen ';
            if Orbus_OverallTotalText1.StartsWith('17')then Orbus_PayText2Digits:='Seventeen ';
            if Orbus_OverallTotalText1.StartsWith('18')then Orbus_PayText2Digits:='Eighteen ';
            if Orbus_OverallTotalText1.StartsWith('19')then Orbus_PayText2Digits:='Nineteen ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText2Digits:='Twenty ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText2Digits:='Thirty ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText2Digits:='Forty ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText2Digits:='Fifty ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText2Digits:='Sixty ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText2Digits:='Seventy ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText2Digits:='Eighty ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText2Digits:='Ninety ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 4);
            if Orbus_OverallTotalText1.StartsWith('0')then Orbus_PayText1Digit:='';
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText1Digit:='One ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText1Digit:='Two ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText1Digit:='Three ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText1Digit:='Four ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText1Digit:='Five ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText1Digit:='Six ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText1Digit:='Seven ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText1Digit:='Eight ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText1Digit:='Nine ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_PayTextCents:='AND ' + DelStr(Orbus_OverallTotalText1, 1, 6) + '/' + '100';
            Orbus_PayText:='****' + Orbus_PayText4Digits + Orbus_PayText3Digits + Orbus_PayText2Digits + Orbus_PayText1Digit + Orbus_PayTextCents;
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
        end;
        if StrLen(Orbus_OverallTotalText1) = 9 then begin
            if Orbus_OverallTotalText1.StartsWith('11')then Orbus_PayText5Digits:='Eleven Thousand ';
            if Orbus_OverallTotalText1.StartsWith('12')then Orbus_PayText5Digits:='Twelve Thousand ';
            if Orbus_OverallTotalText1.StartsWith('13')then Orbus_PayText5Digits:='Thirteen Thousand ';
            if Orbus_OverallTotalText1.StartsWith('14')then Orbus_PayText5Digits:='Fourteen Thousand ';
            if Orbus_OverallTotalText1.StartsWith('15')then Orbus_PayText5Digits:='Fifteen Thousand ';
            if Orbus_OverallTotalText1.StartsWith('16')then Orbus_PayText5Digits:='Sixteen Thousand ';
            if Orbus_OverallTotalText1.StartsWith('17')then Orbus_PayText5Digits:='Seventeen Thousand ';
            if Orbus_OverallTotalText1.StartsWith('18')then Orbus_PayText5Digits:='Eighteen Thousand ';
            if Orbus_OverallTotalText1.StartsWith('19')then Orbus_PayText5Digits:='Nineteen Thousand ';
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 3);
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText3Digits:='One Hundred ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText3Digits:='Two Hundred ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText3Digits:='Three Hundred ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText3Digits:='Four Hundred ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText3Digits:='Five Hundred ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText3Digits:='Six Hundred ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText3Digits:='Seven Hundred ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText3Digits:='Eight Hundred ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText3Digits:='Nine Hundred ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 4);
            if Orbus_OverallTotalText1.StartsWith('10')then Orbus_PayText2Digits:='Ten ';
            if Orbus_OverallTotalText1.StartsWith('11')then Orbus_PayText2Digits:='Eleven ';
            if Orbus_OverallTotalText1.StartsWith('12')then Orbus_PayText2Digits:='Twelve ';
            if Orbus_OverallTotalText1.StartsWith('13')then Orbus_PayText2Digits:='Thirteen ';
            if Orbus_OverallTotalText1.StartsWith('14')then Orbus_PayText2Digits:='Fourteen ';
            if Orbus_OverallTotalText1.StartsWith('15')then Orbus_PayText2Digits:='Fifteen ';
            if Orbus_OverallTotalText1.StartsWith('16')then Orbus_PayText2Digits:='Sixteen ';
            if Orbus_OverallTotalText1.StartsWith('17')then Orbus_PayText2Digits:='Seventeen ';
            if Orbus_OverallTotalText1.StartsWith('18')then Orbus_PayText2Digits:='Eighteen ';
            if Orbus_OverallTotalText1.StartsWith('19')then Orbus_PayText2Digits:='Nineteen ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText2Digits:='Twenty ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText2Digits:='Thirty ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText2Digits:='Forty ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText2Digits:='Fifty ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText2Digits:='Sixty ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText2Digits:='Seventy ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText2Digits:='Eighty ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText2Digits:='Ninety ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 5);
            if Orbus_OverallTotalText1.StartsWith('0')then Orbus_PayText1Digit:='';
            if Orbus_OverallTotalText1.StartsWith('1')then Orbus_PayText1Digit:='One ';
            if Orbus_OverallTotalText1.StartsWith('2')then Orbus_PayText1Digit:='Two ';
            if Orbus_OverallTotalText1.StartsWith('3')then Orbus_PayText1Digit:='Three ';
            if Orbus_OverallTotalText1.StartsWith('4')then Orbus_PayText1Digit:='Four ';
            if Orbus_OverallTotalText1.StartsWith('5')then Orbus_PayText1Digit:='Five ';
            if Orbus_OverallTotalText1.StartsWith('6')then Orbus_PayText1Digit:='Six ';
            if Orbus_OverallTotalText1.StartsWith('7')then Orbus_PayText1Digit:='Seven ';
            if Orbus_OverallTotalText1.StartsWith('8')then Orbus_PayText1Digit:='Eight ';
            if Orbus_OverallTotalText1.StartsWith('9')then Orbus_PayText1Digit:='Nine ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_PayTextCents:='AND ' + DelStr(Orbus_OverallTotalText1, 1, 7) + '/' + '100';
            Orbus_PayText:='****' + Orbus_PayText5Digits + Orbus_PayText3Digits + Orbus_PayText2Digits + Orbus_PayText1Digit + Orbus_PayTextCents;
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
        end;
        if StrLen(Orbus_OverTotalText) = 9 then begin
            if Orbus_OverTotalText.StartsWith('2')then Orbus_PayText5Digits:='Twenty ';
            if Orbus_OverTotalText.StartsWith('3')then Orbus_PayText5Digits:='Thirty ';
            if Orbus_OverTotalText.StartsWith('4')then Orbus_PayText5Digits:='Fourty ';
            if Orbus_OverTotalText.StartsWith('5')then Orbus_PayText5Digits:='Fifty ';
            if Orbus_OverTotalText.StartsWith('6')then Orbus_PayText5Digits:='Sixty ';
            if Orbus_OverTotalText.StartsWith('7')then Orbus_PayText5Digits:='Seventy ';
            if Orbus_OverTotalText.StartsWith('8')then Orbus_PayText5Digits:='Eighty ';
            if Orbus_OverTotalText.StartsWith('9')then Orbus_PayText5Digits:='Ninety ';
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 1);
            if Orbus_OverTotalText.StartsWith('0')then Orbus_PayText4Digits:='Thousand ';
            if Orbus_OverTotalText.StartsWith('1')then Orbus_PayText4Digits:='One Thousand ';
            if Orbus_OverTotalText.StartsWith('2')then Orbus_PayText4Digits:='Two Thousand ';
            if Orbus_OverTotalText.StartsWith('3')then Orbus_PayText4Digits:='Three Thousand ';
            if Orbus_OverTotalText.StartsWith('4')then Orbus_PayText4Digits:='Four Thousand ';
            if Orbus_OverTotalText.StartsWith('5')then Orbus_PayText4Digits:='Five Thousand ';
            if Orbus_OverTotalText.StartsWith('6')then Orbus_PayText4Digits:='Six Thousand ';
            if Orbus_OverTotalText.StartsWith('7')then Orbus_PayText4Digits:='Seven Thousand ';
            if Orbus_OverTotalText.StartsWith('8')then Orbus_PayText4Digits:='Eight Thousand ';
            if Orbus_OverTotalText.StartsWith('9')then Orbus_PayText4Digits:='Nine Thousand ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 3);
            if Orbus_OverTotalText.StartsWith('1')then Orbus_PayText3Digits:='One Hundred ';
            if Orbus_OverTotalText.StartsWith('2')then Orbus_PayText3Digits:='Two Hundred ';
            if Orbus_OverTotalText.StartsWith('3')then Orbus_PayText3Digits:='Three Hundred ';
            if Orbus_OverTotalText.StartsWith('4')then Orbus_PayText3Digits:='Four Hundred ';
            if Orbus_OverTotalText.StartsWith('5')then Orbus_PayText3Digits:='Five Hundred ';
            if Orbus_OverTotalText.StartsWith('6')then Orbus_PayText3Digits:='Six Hundred ';
            if Orbus_OverTotalText.StartsWith('7')then Orbus_PayText3Digits:='Seven Hundred ';
            if Orbus_OverTotalText.StartsWith('8')then Orbus_PayText3Digits:='Eight Hundred ';
            if Orbus_OverTotalText.StartsWith('9')then Orbus_PayText3Digits:='Nine Hundred ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 4);
            if Orbus_OverTotalText.StartsWith('10')then Orbus_PayText2Digits:='Ten ';
            if Orbus_OverTotalText.StartsWith('11')then Orbus_PayText2Digits:='Eleven ';
            if Orbus_OverTotalText.StartsWith('12')then Orbus_PayText2Digits:='Twelve ';
            if Orbus_OverTotalText.StartsWith('13')then Orbus_PayText2Digits:='Thirteen ';
            if Orbus_OverTotalText.StartsWith('14')then Orbus_PayText2Digits:='Fourteen ';
            if Orbus_OverTotalText.StartsWith('15')then Orbus_PayText2Digits:='Fifteen ';
            if Orbus_OverTotalText.StartsWith('16')then Orbus_PayText2Digits:='Sixteen ';
            if Orbus_OverTotalText.StartsWith('17')then Orbus_PayText2Digits:='Seventeen ';
            if Orbus_OverTotalText.StartsWith('18')then Orbus_PayText2Digits:='Eighteen ';
            if Orbus_OverTotalText.StartsWith('19')then Orbus_PayText2Digits:='Nineteen ';
            if Orbus_OverTotalText.StartsWith('2')then Orbus_PayText2Digits:='Twenty ';
            if Orbus_OverTotalText.StartsWith('3')then Orbus_PayText2Digits:='Thirty ';
            if Orbus_OverTotalText.StartsWith('4')then Orbus_PayText2Digits:='Forty ';
            if Orbus_OverTotalText.StartsWith('5')then Orbus_PayText2Digits:='Fifty ';
            if Orbus_OverTotalText.StartsWith('6')then Orbus_PayText2Digits:='Sixty ';
            if Orbus_OverTotalText.StartsWith('7')then Orbus_PayText2Digits:='Seventy ';
            if Orbus_OverTotalText.StartsWith('8')then Orbus_PayText2Digits:='Eighty ';
            if Orbus_OverTotalText.StartsWith('9')then Orbus_PayText2Digits:='Ninety ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_OverallTotalText1:=DelStr(Orbus_OverallTotalText1, 1, 5);
            if Orbus_OverTotalText.StartsWith('0')then Orbus_PayText1Digit:='';
            if Orbus_OverTotalText.StartsWith('1')then Orbus_PayText1Digit:='One ';
            if Orbus_OverTotalText.StartsWith('2')then Orbus_PayText1Digit:='Two ';
            if Orbus_OverTotalText.StartsWith('3')then Orbus_PayText1Digit:='Three ';
            if Orbus_OverTotalText.StartsWith('4')then Orbus_PayText1Digit:='Four ';
            if Orbus_OverTotalText.StartsWith('5')then Orbus_PayText1Digit:='Five ';
            if Orbus_OverTotalText.StartsWith('6')then Orbus_PayText1Digit:='Six ';
            if Orbus_OverTotalText.StartsWith('7')then Orbus_PayText1Digit:='Seven ';
            if Orbus_OverTotalText.StartsWith('8')then Orbus_PayText1Digit:='Eight ';
            if Orbus_OverTotalText.StartsWith('9')then Orbus_PayText1Digit:='Nine ';
            Orbus_OverallTotalText1:=Format(Orbus_OverallTotal, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
            Orbus_PayTextCents:='AND ' + DelStr(Orbus_OverallTotalText1, 1, 7) + '/' + '100';
            Orbus_PayText:='****' + Orbus_PayText5Digits + Orbus_PayText4Digits + Orbus_PayText3Digits + Orbus_PayText2Digits + Orbus_PayText1Digit + Orbus_PayTextCents;
            Orbus_OverTotalText:=Format(Orbus_OverallTotal);
        end;
    end;
}
