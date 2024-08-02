report 55187 "Custom Customer Statement"
{
    RDLCLayout = './ReportLayouts/OrbusCustomerStatement.rdl';
    Caption = 'Custom Customer Statement';
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(CustLedgEntry; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date");
            RequestFilterFields = "Customer No.";

            column(RemainAmt_CustLedgEntry2; "Remaining Amount")
            {
            }
            column(PostDate_CustLedgEntry2; Format("Posting Date", 0, '<Month>/<Day>/<Year4>'))
            {
            }
            column(DocNo_CustLedgEntry2; "Document No.")
            {
            }
            column(Desc_CustLedgEntry2; Description)
            {
            }
            column(DueDate_CustLedgEntry2; Format("Due Date"))
            {
            }
            column(OriginalAmt_CustLedgEntry2; "Original Amount")
            {
            }
            column(CurrCode_CustLedgEntry2; "Currency Code")
            {
            }
            column(CustNo_CustLedgEntry2; "Customer No.")
            {
            }
            column(TodayDate; Format(TodayDate, 0, '<Month Text> <Day,2>, <Year4>'))
            {
            }
            column(BalanceText; BalanceText)
            {
            }
            column(External_Document_No_; "External Document No.")
            {
            }
            column(Document_Type; "Document Type")
            {
            }
            column(CustomerName; CustomerName)
            {
            }
            column(CustomerContact; CustomerContact)
            {
            }
            column(Address1; Address1)
            {
            }
            column(Address2; Address2)
            {
            }
            column(City; City)
            {
            }
            column(State; State)
            {
            }
            column(ZipCode; ZipCode)
            {
            }
            column(Country; Country)
            {
            }
            column(Date1; Date1)
            {
            }
            column(AmountWithin1Month; Format(AmountWithin1Month, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Amount1to2Months; Format(Amount1to2Months, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(Amount2to3Months; Format(Amount2to3Months, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(AmountOver3Months; Format(AmountOver3Months, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            column(CurrentBalance; Format(CurrentBalance, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>'))
            {
            }
            trigger OnPreDataItem()
            var
            begin
                if GetCustomerWithBalance = true then begin
                    CustLedgEntry.SetRange("Posting Date", StartingDate, EndingDate);
                    CustLedgEntry.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
                    CustLedgEntry.SetFilter("Amount 2", '<>0');
                end
                else
                begin
                    CustLedgEntry.SetRange("Posting Date", StartingDate, EndingDate);
                    CustLedgEntry.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
                end;
            end;
            trigger OnAfterGetRecord()
            var
                DCLE: Record "Detailed Cust. Ledg. Entry";
                CustLedEntry1: Record "Cust. Ledger Entry";
                var1: Decimal;
            begin
                GetCustomerInfo();
                CustLedEntry1.Reset();
                CustLedEntry1.SetRange("Customer No.", CustLedgEntry."Customer No.");
                CustLedEntry1.SetRange("Posting Date", StartingDate, EndingDate);
                CustLedEntry1.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
                CustLedEntry1.SetFilter("Amount 2", '<>0');
                CustLedEntry1.CalcSums("Amount 2");
                Balance:=CustLedEntry1."Amount 2";
                BalanceText:=Format(Balance, 0, '$<Precision,2:2><Sign><Integer Thousand><Decimals>');
                CustLedEntry1.Reset();
                CustLedEntry1.SetRange("Customer No.", CustLedgEntry."Customer No.");
                CustLedEntry1.SetRange("Posting Date", StartingDate, EndingDate);
                CustLedEntry1.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
                CustLedEntry1.SetFilter("Amount 2", '<>0');
                CustLedEntry1.SetRange(Current, true);
                CustLedEntry1.CalcSums("Amount 2");
                CurrentBalance:=CustLedEntry1."Amount 2";
                CustLedEntry1.Reset();
                CustLedEntry1.SetRange("Customer No.", CustLedgEntry."Customer No.");
                CustLedEntry1.SetRange("Posting Date", StartingDate, EndingDate);
                CustLedEntry1.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
                CustLedEntry1.SetFilter("Amount 2", '<>0');
                CustLedEntry1.SetRange("1 to 30", true);
                CustLedEntry1.CalcSums("Amount 2");
                AmountWithin1Month:=CustLedEntry1."Amount 2";
                CustLedEntry1.Reset();
                CustLedEntry1.SetRange("Customer No.", CustLedgEntry."Customer No.");
                CustLedEntry1.SetRange("Posting Date", StartingDate, EndingDate);
                CustLedEntry1.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
                CustLedEntry1.SetFilter("Amount 2", '<>0');
                CustLedEntry1.SetRange("31 to 60", true);
                CustLedEntry1.CalcSums("Amount 2");
                Amount1to2Months:=CustLedEntry1."Amount 2";
                CustLedEntry1.Reset();
                CustLedEntry1.SetRange("Customer No.", CustLedgEntry."Customer No.");
                CustLedEntry1.SetRange("Posting Date", StartingDate, EndingDate);
                CustLedEntry1.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
                CustLedEntry1.SetFilter("Amount 2", '<>0');
                CustLedEntry1.SetRange("61 to 90", true);
                CustLedEntry1.CalcSums("Amount 2");
                Amount2to3Months:=CustLedEntry1."Amount 2";
                CustLedEntry1.Reset();
                CustLedEntry1.SetRange("Customer No.", CustLedgEntry."Customer No.");
                CustLedEntry1.SetRange("Posting Date", StartingDate, EndingDate);
                CustLedEntry1.SetFilter("Document Type Text", 'Payment|Invoice|Credit Memo');
                CustLedEntry1.SetFilter("Amount 2", '<>0');
                CustLedEntry1.SetRange("Over 90", true);
                CustLedEntry1.CalcSums("Amount 2");
                AmountOver3Months:=CustLedEntry1."Amount 2";
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Ending Date';
                    }
                    field(GetCustomerWithBalance; GetCustomerWithBalance)
                    {
                        ApplicationArea = All;
                        Caption = 'Get Customers With Balance';
                    }
                }
            }
        }
        trigger OnOpenPage()
        var
            CLE1: Record "Cust. Ledger Entry";
            GetValuesForCustLedgerEntries2: Codeunit GetValuesForCustLedgerEntries2;
            GetValuesForCustLedgerEntries3: Codeunit GetValuesForCustLedgerEntries3;
        begin
            GetCustomerWithBalance:=true;
        end;
    }
    var var1: Text;
    var2: Text;
    TodayDate: Date;
    StartingDate: Date;
    EndingDate: Date;
    CustomerNumber: Text;
    Balance: Decimal;
    BalanceText: Text;
    LineAmount: Decimal;
    var10: Text;
    OrginalAmount: Decimal;
    OutstandingAmount: Decimal;
    CustomerNo: Text;
    CustomerName: Text;
    Address1: Text;
    Address2: Text;
    City: Text;
    State: Text;
    ZipCode: Text;
    Country: Text;
    CustomerContact: Text;
    GetCustomerWithBalance: Boolean;
    Date1: Integer;
    AmountWithin1Month: Decimal;
    Amount1to2Months: Decimal;
    Amount2to3Months: Decimal;
    AmountOver3Months: Decimal;
    LineAmountOver3Months: Decimal;
    CurrentBalance: Decimal;
    trigger OnInitReport()
    var
        CustLedEntry1: Record "Cust. Ledger Entry";
    begin
        TodayDate:=Today();
    end;
    trigger OnPreReport()
    var
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        DCLE: Record "Detailed Cust. Ledg. Entry";
    begin
        if(StartingDate = 0D) or (EndingDate = 0D)then Error('Need to fill out starting and ending date fields');
    end;
    local procedure GetCustomerInfo()
    var
        Customer: Record Customer;
    begin
        Customer.Reset();
        Customer.SetRange("No.", CustLedgEntry."Customer No.");
        if Customer.FindFirst()then begin
            CustomerName:=Customer.Name;
            Address1:=Customer.Address;
            Address2:=Customer."Address 2";
            City:=Customer.City;
            State:=Customer.County;
            ZipCode:=Customer."Post Code";
            Country:=Customer."Country/Region Code";
            CustomerContact:=Customer.Contact;
        end;
    end;
    local procedure GetDocumentTypeTextFromCLE()
    var
        CLE1: Record "Cust. Ledger Entry";
    begin
        CLE1.Reset();
        if CLE1.FindSet()then repeat if CLE1."Document Type Text" = '' then begin
                    CLE1."Document Type Text":=Format(CLE1."Document Type", 0, '<Text>');
                    CLE1.Modify();
                end;
            until CLE1.Next() = 0;
    end;
}
