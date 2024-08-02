report 55191 InternalReprint
{
    ApplicationArea = All;
    Caption = 'Internal Rework';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './ReportLayouts/OrbusInternalReprint.rdl';

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            column(ProductionOrderRecord; ProductionOrderRecord)
            {
            }
            column(ClientName; ClientName)
            {
            }
            column(ShipDate; ShipDate)
            {
            }
            column(ShipDateText; ShipDateText)
            {
            }
            column(ShippingAgentCode; ShippingAgentCode)
            {
            }
            column(ShippingAgentService; ShippingAgentService)
            {
            }
            column(SourceNo; SourceNo)
            {
            }
            column(SubmittedBy; SubmittedBy)
            {
            }
            column(DateIssued; DateIssued)
            {
            }
            column(DateIssuedText; DateIssuedText)
            {
            }
            column(ArtCoordinator; ArtCoordinator)
            {
            }
            column(ReasonForReprint; ReasonForReprint)
            {
            }
            column(FilePrintedBy; FilePrintedBy)
            {
            }
            column(AtFaultUser; AtFaultUser)
            {
            }
            column(Rerip; Rerip)
            {
            }
            column(Reprint; Reprint)
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
            column(GraphicFinished; GraphicFinished)
            {
            }
            column(EncodedSalesHeaderNoBarcode; EncodedSalesHeaderNoBarcode)
            {
            }
            column(EncodedProductionOrderNoBarcode; EncodedProductionOrderNoBarcode)
            {
            }
            column(DateTimeInserted; DateTimeInserted)
            {
            }
            column(DepartmentRequestingRework; DepartmentRequestingRework)
            {
            }
            column(DepartmentToPerformRework; DepartmentToPerformRework)
            {
            }
            column(RootCauseForRework; RootCauseForRework)
            {
            }
            column(ValueForOther; ValueForOther)
            {
            }
            column(LocationCode; LocationCode)
            {
            }
            column(ProjectManager; ProjectManager)
            {
            }
            column(DesignNo; DesignNo)
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
            column(Quantity1; Quantity1)
            {
            }
            column(RootCauseDepartment; RootCauseDepartment)
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
            column(OtherReasonCaption; OtherReasonCaption)
            {
            }
            trigger OnAfterGetRecord()
            var
            begin
                GetBarcodeValues();
                GetYesNoForBooleanValues();
                ReripReprintFinishedVisible();
                OtherVisible();
                ShipDateText:=Format(ShipDate, 0, '<Month>/<Day>/<Year4>');
                DateIssuedText:=Format(DateIssued, 0, '<Month>/<Day>/<Year4>');
                DateTimeInserted:=Format(CurrentDateTime(), 0, '<Month>/<Day>/<Year4> <Hours12,2>:<Min,2> <AM/PM>')end;
            trigger OnPreDataItem()
            var
                SalesHeader: Record "Sales Header";
                InternalReprint: Record InternalReprint;
                ProductionOrder: Record "Production Order";
            begin
                "Production Order".Reset();
                "Production Order".SetFilter("No.", ProductionOrderRecord);
            end;
        }
    }
    requestpage
    {
        Caption = 'Internal Rework';

        layout
        {
            area(Content)
            {
                field(ProductionOrderRecord; ProductionOrderRecord)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Production Order No.';
                }
                field(ClientName; ClientName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Client Name';
                }
                field(ShipDate; ShipDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Ship Date';
                }
                field(ShippingAgentCode; ShippingAgentCode)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Shipping Agent Code';
                }
                field(ShippingAgentService; ShippingAgentService)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Shipping Agent Service';
                }
                field(SourceNo; SourceNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Record No.';
                }
                field(DateIssued; DateIssued)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Date Issued';
                }
                field(SubmittedBy; SubmittedBy)
                {
                    ApplicationArea = All;
                    Caption = 'Submitted By';
                }
                field(DepartmentRequestingRework; DepartmentRequestingRework)
                {
                    ApplicationArea = All;
                    Caption = 'Department Requesting Rework';
                    StyleExpr = ColorVarRequestingRework;

                    trigger OnLookup(var Text: Text): Boolean var
                        DepartmentToRequestReworkListPageVar: Page DepartmentRequestingReworkList;
                    begin
                        DepartmentToRequestReworkListPageVar.LookupMode(true);
                        if DepartmentToRequestReworkListPageVar.RunModal() = Action::LookupOK then begin
                            ColorVarRequestingRework:='Standard';
                            DepartmentRequestingRework:=DepartmentToRequestReworkListPageVar.ProduceValues();
                        //ShowGlobalPageVars();
                        end;
                    end;
                    trigger OnValidate()
                    var
                        DepartmentToRequestRework: Record DepartmentRequestingRework;
                    begin
                        DepartmentToRequestRework.Reset();
                        DepartmentToRequestRework.SetRange(Name, DepartmentRequestingRework);
                        if DepartmentToRequestRework.FindFirst()then ColorVarRequestingRework:='Standard'
                        else
                            Error('No record exists in Department Requesting Rework table with value of "' + DepartmentRequestingRework + '" for name table field');
                    end;
                }
                field(DepartmentToPerformRework; DepartmentToPerformRework)
                {
                    ApplicationArea = All;
                    Caption = 'Department To Perform Rework';
                    StyleExpr = ColorVarPerformingRework;

                    trigger OnLookup(var Text: Text): Boolean var
                        DepartmentToPerformReworkListPageVar: Page DepartmentToPerformRework;
                    begin
                        DepartmentToPerformReworkListPageVar.LookupMode(true);
                        if DepartmentToPerformReworkListPageVar.RunModal() = Action::LookupOK then begin
                            DepartmentToPerformRework:=DepartmentToPerformReworkListPageVar.ProduceValues();
                            MakeGlobalPageVariablesVisible();
                            ColorVarPerformingRework:='Standard';
                        end;
                    end;
                    trigger OnValidate()
                    var
                        DepartmentToPerformReworkVar: Record DepartmentToPerformRework;
                    begin
                        DepartmentToPerformReworkVar.Reset();
                        DepartmentToPerformReworkVar.SetRange(Name, DepartmentToPerformRework);
                        if DepartmentToPerformReworkVar.FindFirst()then begin
                            MakeGlobalPageVariablesVisible();
                            ColorVarPerformingRework:='Standard';
                        end
                        else
                            Error('No record exists in Department To Perform Rework table with value of "' + DepartmentToPerformRework + '" for name table field');
                    end;
                }
                field(RootCauseDepartment; RootCauseDepartment)
                {
                    ApplicationArea = All;
                    Caption = 'Root Cause Department';
                    StyleExpr = ColorVarRootCauseDepartment;

                    trigger OnLookup(var Text: Text): Boolean var
                        RootCauseDepListPageVar: Page RootCauseDepartmentList;
                    begin
                        RootCauseDepListPageVar.LookupMode(true);
                        if RootCauseDepListPageVar.RunModal() = Action::LookupOK then begin
                            RootCauseDepartment:=RootCauseDepListPageVar.ProduceValues();
                            /*if
                            RootCauseDepartment = 'Graphics'
                            then
                            begin
                                VisibleVarArtCoordinator := true;
                                VisibleVarDetailing := false;
                                VisibleVarFilePrintedToGraphicFinished := true;
                                VisibleVarArtCoordinator := true;
                            end
                            else
                            begin
                            VisibleVarArtCoordinator := false;
                            VisibleVarDetailing := true;
                            VisibleVarFilePrintedToGraphicFinished := false;
                            VisibleVarArtCoordinator := false;
                            end;*/
                            ColorVarRootCauseDepartment:='Standard';
                        end;
                    end;
                    trigger OnValidate()
                    var
                        RootCauseDepartmentVar: Record RootCauseDepartment;
                    begin
                        RootCauseDepartmentVar.Reset();
                        RootCauseDepartmentVar.SetRange(Name, RootCauseDepartment);
                        if RootCauseDepartmentVar.FindFirst()then ColorVarRootCauseDepartment:='Standard'
                        else
                            Error('No record exists in Root Cause Department table with value of "' + RootCauseDepartment + '" for name table field');
                    end;
                }
                field(RootCauseForRework; RootCauseForRework)
                {
                    ApplicationArea = All;
                    Caption = 'Root Cause For Rework';
                    StyleExpr = ColorVarRootCause;

                    trigger OnLookup(var Text: Text): Boolean var
                        RootCauseListPageVar: Page RootCauseList;
                    begin
                        RootCauseListPageVar.LookupMode(true);
                        RootCauseListPageVar.ApplyFilter(RootCauseDepartment);
                        if RootCauseListPageVar.RunModal() = Action::LookupOK then begin
                            RootCauseForRework:=RootCauseListPageVar.ProduceValues();
                            ColorVarRootCause:='Standard';
                            if RootCauseForRework = 'Other' then VisibleVarOther:=true
                            else
                                VisibleVarOther:=false;
                        end;
                    end;
                    trigger OnValidate()
                    var
                        RootCause: Record RootCause;
                    begin
                        RootCause.Reset();
                        RootCause.SetRange(Name, RootCauseForRework);
                        if RootCause.FindFirst()then ColorVarRootCause:='Standard'
                        else
                            Error('No record exists in Root Cause table with value of "' + RootCauseForRework + '" for name table field');
                    end;
                }
                group(VisibleVarOtherGroup)
                {
                    ShowCaption = false;
                    Visible = VisibleVarOther;

                    field(ValueForOther; ValueForOther)
                    {
                        ApplicationArea = All;
                        Caption = 'Other Reason';

                        trigger OnValidate()
                        var
                        begin
                            if ValueForOther = '' then begin
                                ValueForOther:='Blank';
                                ColorVarOther:='Unfavorable';
                            end
                            else
                                ColorVarOther:='Standard';
                        end;
                    }
                }
                //field(ReasonForReprint; ReasonForReprint)
                //{
                //ApplicationArea = All;
                //Caption = 'Reason For Reprint';
                //StyleExpr = ColorVarReasonForReprint;
                //trigger OnValidate()
                //var
                //begin
                //if
                //Size = ''
                //then
                //begin
                //Size := 'Blank';
                //ColorVarSize := 'Unfavorable'
                //end
                //else
                //ColorVarSize := 'Standard';
                //end;   
                //}
                field(Notes; Notes)
                {
                    ApplicationArea = All;
                    Caption = 'Detailed Reason For Rework';
                    StyleExpr = ColorVarNotes;

                    trigger OnValidate()
                    var
                    begin
                        if Notes = '' then begin
                            Notes:='Blank';
                            ColorVarNotes:='Unfavorable' end
                        else
                            ColorVarNotes:='Standard';
                    end;
                }
                field(ItemLookup; ItemLookup)
                {
                    ApplicationArea = All;
                    Caption = '';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        ProdOrderLine: Record "Prod. Order Line";
                        ProdOrderLineListPage: Page "Prod. Order Line List";
                    begin
                        ProdOrderLineListPage.LookupMode(true);
                        ProdOrderLine.Reset();
                        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrderRecord);
                        if ProdOrderLine.FindSet()then begin
                            ProdOrderLine.Reset();
                            ProdOrderLine.SetRange("Prod. Order No.", ProductionOrderRecord);
                            if Page.RunModal(Page::"Prod. Order Line List", ProdOrderLine) = Action::LookupOK then begin
                                Item:=ProdOrderLine."Item No.";
                                ColorVarItem:='Standard';
                            end;
                        end
                        else
                            Message('No items on Production Order: %1', ProductionOrderRecord);
                    end;
                }
                field(Item; Item)
                {
                    ApplicationArea = All;
                    Caption = 'Item';
                    StyleExpr = ColorVarItem;
                    Editable = false;
                }
                field(Material; Material)
                {
                    ApplicationArea = All;
                    Caption = 'Material';
                    StyleExpr = ColorVarMaterial;

                    trigger OnValidate()
                    var
                    begin
                        if Material = '' then begin
                            Material:='Blank';
                            ColorVarMaterial:='Unfavorable' end
                        else
                            ColorVarMaterial:='Standard';
                    end;
                }
                field(Size; Size)
                {
                    ApplicationArea = All;
                    Caption = 'Size';
                    StyleExpr = ColorVarSize;

                    trigger OnValidate()
                    var
                    begin
                        if Size = '' then begin
                            Size:='Blank';
                            ColorVarSize:='Unfavorable' end
                        else
                            ColorVarSize:='Standard';
                    end;
                }
                field(Quantity1; Quantity1)
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    StyleExpr = ColorVarQuantity;

                    trigger OnValidate()
                    var
                        MaxLength: Integer;
                    begin
                        MaxLength:=0;
                        MaxLength:=StrLen(Quantity1);
                        if MaxLength > 20 then Error('Max character length for this global variable is 20. Current length is ' + Format(MaxLength));
                        if Quantity1 = '' then begin
                            Quantity1:='Blank';
                            ColorVarQuantity:='Unfavorable' end
                        else
                            ColorVarQuantity:='Standard';
                    end;
                }
                group(ArtCoordinatorGroup)
                {
                    ShowCaption = false;
                    Visible = VisibleVarArtCoordinator;

                    field(ArtCoordinator; ArtCoordinator)
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Caption = 'Art Coordinator';
                    }
                }
                group(FilePrintedToGraphicFinished)
                {
                    ShowCaption = false;
                    Visible = VisibleVarFilePrintedToGraphicFinished;

                    field(FilePrintedBy; FilePrintedBy)
                    {
                        ApplicationArea = All;
                        Caption = 'File Printed By';
                        StyleExpr = ColorVarFilePrintedBy;

                        trigger OnLookup(var Text: Text): Boolean var
                            UserandLocation: Record UserandLocation;
                            UserandLocationListPage: Page UserandLocationListPage;
                            SalesHeader: Record "Sales Header";
                            ProductionOrder: Record "Production Order";
                        begin
                            UserandLocationListPage.LookupMode(true);
                            UserandLocationListPage.GetFilter(LocationCode);
                            if UserandLocationListPage.RunModal() = Action::LookupOK then begin
                                FilePrintedBy:=UserandLocationListPage.ProduceUserID();
                                ColorVarFilePrintedBy:='Standard';
                            end;
                        end;
                    }
                    field(AtFaultUser; AtFaultUser)
                    {
                        ApplicationArea = All;
                        Caption = 'At Fault User';
                        StyleExpr = ColorVarAtFaultUser;

                        trigger OnValidate()
                        var
                        begin
                            if AtFaultUser = '' then begin
                                AtFaultUser:='Blank';
                                ColorVarAtFaultUser:='Unfavorable' end
                            else
                                ColorVarAtFaultUser:='Standard';
                        end;
                    }
                    field(Rerip; Rerip)
                    {
                        ApplicationArea = All;
                        Caption = 'Rerip';
                    }
                    field(Reprint; Reprint)
                    {
                        ApplicationArea = All;
                        Caption = 'Reprint';
                    }
                    field(GraphicFinished; GraphicFinished)
                    {
                        ApplicationArea = All;
                        Caption = 'Graphic Finished';
                    }
                }
                group(Detailing)
                {
                    ShowCaption = false;
                    Visible = VisibleVarDetailing;

                    field(DetailingMetal; DetailingMetal)
                    {
                        ApplicationArea = All;
                    }
                    field(DetailingWood; DetailingWood)
                    {
                        ApplicationArea = All;
                    }
                    field(InstructionDetailing; InstructionDetailing)
                    {
                        ApplicationArea = All;
                    }
                }
                group(PMandDesignNoVisibleVar)
                {
                    ShowCaption = false;
                    Visible = VisibleVarProjectManagerandDesignNo;

                    field(ProjectManager; ProjectManager)
                    {
                        ApplicationArea = All;
                        StyleExpr = ColorVarProjectManager;

                        trigger OnLookup(var Text: Text): Boolean var
                            ProjectManagerListPageVar: Page ProjectManagerList;
                        begin
                            ProjectManagerListPageVar.LookupMode(true);
                            ProjectManagerListPageVar.OnlyDisplayVisible(true);
                            if ProjectManagerListPageVar.RunModal() = Action::LookupOK then begin
                                ProjectManager:=ProjectManagerListPageVar.ProduceName();
                                ColorVarProjectManager:='Standard';
                            end;
                        end;
                        trigger OnValidate()
                        var
                            ProjectManagerVar: Record ProjectManager;
                        begin
                            if ProjectManager = '' then begin
                                ProjectManager:='Blank';
                                ColorVarProjectManager:='Unfavorable' end
                            else
                            begin
                                ProjectManagerVar.Reset();
                                ProjectManagerVar.SetRange(Name, ProjectManager);
                                if ProjectManagerVar.FindFirst()then ColorVarProjectManager:='Standard'
                                else
                                    Error('No record exists in Project Manager table with value of "' + ProjectManager + '"');
                            end;
                        end;
                    }
                    field(DesignNo; DesignNo)
                    {
                        ApplicationArea = All;
                        StyleExpr = ColorVarDesignNo;

                        trigger OnValidate()
                        var
                        begin
                            if DesignNo = '' then begin
                                DesignNo:='Blank';
                                ColorVarDesignNo:='Unfavorable' end
                            else
                                ColorVarDesignNo:='Standard';
                        end;
                    }
                }
                field(LocationCode; LocationCode)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Location Code';
                }
                field(DateTimeVar; DateTimeVar)
                {
                    ApplicationArea = All;
                    Caption = 'Current Date/Time';
                    Editable = false;

                    trigger OnValidate()
                    var
                    begin
                        ColorVar(Quantity1, ColorVarQuantity);
                    end;
                }
            }
        }
        trigger OnOpenPage()
        var
        begin
            SubmittedBy:=UserId();
            DateIssued:=Today();
            ReasonForReprint:=ReasonForReprint::Blank;
            ColorVarSize:='Unfavorable';
            ColorVarQuantity:='Unfavorable';
            ColorVarNotes:='Unfavorable';
            ColorVarFilePrintedBy:='Unfavorable';
            ColorVarAtFaultUser:='Unfavorable';
            ColorVarReasonForReprint:='Unfavorable';
            ColorVarItem:='Unfavorable';
            ColorVarMaterial:='Unfavorable';
            DateTimeVar:=CurrentDateTime();
            Notes:='Blank';
            Size:='Blank';
            Quantity1:='Blank';
            Item:='Blank';
            Material:='Blank';
            ProjectManager:='Blank';
            DesignNo:='Blank';
            ValueForOther:='Blank';
            VisibleVarProjectManagerandDesignNo:=true;
            DepartmentRequestingRework:='Blank';
            DepartmentToPerformRework:='Blank';
            RootCauseForRework:='Blank';
            ColorVarRequestingRework:='Unfavorable';
            ColorVarRequestingRework:='Unfavorable';
            ColorVarRequestingRework:='Unfavorable';
            ColorVarRootCause:='Unfavorable';
            ColorVarPerformingRework:='Unfavorable';
            ColorVarProjectManager:='Unfavorable';
            ColorVarDesignNo:='Unfavorable';
            ColorVarPerformingRework:='Unfavorable';
            VisibleVarDetailing:=true;
            ItemLookup:='Click Here To Lookup Items';
            AtFaultUser:='Blank';
            FilePrintedBy:='Blank';
            ColorVarRootCauseDepartment:='Unfavorable';
            RootCauseDepartment:='Blank';
        end;
        var VisibleVarDetailing: Boolean;
        VisibleVarFilePrintedToGraphicFinished: Boolean;
        ColorVarNotes: Text;
        ColorVarSize: Text;
        ColorVarQuantity: Text;
        ColorVarFilePrintedBy: Text;
        ColorVarAtFaultUser: Text;
        ColorVarReasonForReprint: Text;
        ColorVarItem: Text;
        MandatoryVar2: Boolean;
        VisibleVarArtCoordinator: Boolean;
        ColorVarMaterial: Text;
        VisibleVarOther: Boolean;
        ColorVarOther: Text;
        VisibleVarProjectManagerandDesignNo: Boolean;
        ColorVarRootCause: Text;
        ColorVarRequestingRework: Text;
        ColorVarPerformingRework: Text;
        ItemLookup: Text;
        ColorVarProjectManager: Text;
        ColorVarDesignNo: Text;
        ColorVarRootCauseDepartment: Text;
        procedure ColorVar(var1: Text; var2: Text)
        var
        begin
            if var1 = '' then begin
                var1:='Blank';
                var2:='Unfavorable';
            end
            else
                var2:='Standard';
        end;
        procedure ShowGlobalPageVars()
        var
        begin
            if(DepartmentRequestingRework = 'Rental') or (DepartmentRequestingRework = 'Service Plus') or (DepartmentRequestingRework = 'Storage')then VisibleVarProjectManagerandDesignNo:=true
            else
                VisibleVarProjectManagerandDesignNo:=false;
        end;
        procedure MakeGlobalPageVariablesVisible()
        var
        begin
            if(DepartmentToPerformRework = 'Graphics') or (DepartmentToPerformRework = 'Graphic')then begin
                VisibleVarArtCoordinator:=true;
                VisibleVarDetailing:=false;
                VisibleVarFilePrintedToGraphicFinished:=true;
            end
            else
            begin
                VisibleVarArtCoordinator:=false;
                VisibleVarDetailing:=true;
                VisibleVarFilePrintedToGraphicFinished:=false;
            end;
        end;
    }
    trigger OnPreReport()
    var
        InternalReprint: Record InternalReprint;
        var1: Integer;
        Out: OutStream;
        Inst: InStream;
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        Parameters: Text;
    begin
        if(DepartmentRequestingRework = '') or (DepartmentToPerformRework = '') or (RootCauseForRework = '') or (DepartmentRequestingRework = 'Blank') or (DepartmentToPerformRework = 'Blank') or (RootCauseForRework = 'Blank')then Error('Department Requesting Rework, Department To Perform Rework, and Root Cause all need to have value other than "Blank"');
        if(DepartmentRequestingRework = 'Other') and (DepartmentToPerformRework = 'Graphic')then begin
            if(FilePrintedBy = '') or (AtFaultUser = '') or (Notes = '') or (Item = '') or (Material = '') or (Size = '') or (Quantity1 = '') or (ValueForOther = '') or (FilePrintedBy = 'Blank') or (AtFaultUser = 'Blank') or (Notes = 'Blank') or (Item = 'Blank') or (Material = 'Blank') or (Size = 'Blank') or (Quantity1 = 'Blank') or (ValueForOther = 'Blank')then Error('All global variables need to have a value other than "Blank" in order for report to run successfully');
        end;
        if(DepartmentRequestingRework <> 'Other') and (DepartmentToPerformRework = 'Graphic')then begin
            if(FilePrintedBy = '') or (AtFaultUser = '') or (Notes = '') or (Item = '') or (Material = '') or (Size = '') or (Quantity1 = '') or (FilePrintedBy = 'Blank') or (AtFaultUser = 'Blank') or (Notes = 'Blank') or (Item = 'Blank') or (Material = 'Blank') or (Size = 'Blank') or (Quantity1 = 'Blank')then Error('All global variables need to have a value other than "Blank" in order for report to run successfully');
        end;
        if(DepartmentRequestingRework <> 'Other') and (DepartmentToPerformRework <> 'Graphic')then begin
            if(Notes = '') or (Item = '') or (Material = '') or (Size = '') or (Quantity1 = '') or (Notes = 'Blank') or (Item = 'Blank') or (Material = 'Blank') or (Size = 'Blank') or (Quantity1 = 'Blank')then Error('All global variables need to have a value other than "Blank" in order for report to run successfully');
        end;
        if(DepartmentRequestingRework = 'Other') and (DepartmentToPerformRework <> 'Graphic')then begin
            if(Notes = '') or (Item = '') or (Material = '') or (Size = '') or (Quantity1 = '') or (ValueForOther = '') or (Notes = 'Blank') or (Item = 'Blank') or (Material = 'Blank') or (Size = 'Blank') or (Quantity1 = 'Blank') or (ValueForOther = 'Blank')then Error('All global variables need to have a value other than "Blank" in order for report to run successfully');
        end;
        //if
        //DepartmentToPerformRework = 'Graphic'
        //then
        //begin
        //if
        //(Notes = '') or (Item = '') or (Material = '') or (Size = '') or (Quantity = '') or (Notes = 'Blank') or (Item = 'Blank') or (Material = 'Blank') or (Size = 'Blank') or (Quantity = 'Blank')
        //then
        //Error('All global variables need to have a value other than "Blank" in order for report to run successfully');
        //end;
        InternalReprint.Reset();
        if InternalReprint.FindLast()then var1:=InternalReprint."Entry No." + 1
        else
            var1:=1;
        InternalReprint.Init();
        InternalReprint."Entry No.":=var1;
        InternalReprint."User ID":=UserId();
        InternalReprint."Date/Time Inserted":=CurrentDateTime();
        InternalReprint."Date Inserted":=Today();
        InternalReprint."Sales Header Record":=SourceNo;
        InternalReprint."Sell-to Customer No.":=ClientName;
        InternalReprint."Ship Date":=ShipDate;
        InternalReprint."Shipping Agent Code":=ShippingAgentCode;
        InternalReprint."Shipping Agent Service":=ShippingAgentService;
        InternalReprint."Production Order No.":=ProductionOrderRecord;
        InternalReprint."Submitted By":=SubmittedBy;
        InternalReprint."Date Issued":=DateIssued;
        InternalReprint."Art Coordinator":=ArtCoordinator;
        InternalReprint."Reason For Reprint":=ReasonForReprint;
        InternalReprint."FIle Printed By":=FilePrintedBy;
        InternalReprint."At Fault User":=AtFaultUser;
        InternalReprint.Reprint:=Reprint;
        InternalReprint.Rerip:=Rerip;
        InternalReprint.Notes:=Notes;
        InternalReprint.Item:=Item;
        InternalReprint.Material:=Material;
        InternalReprint.Size:=Size;
        InternalReprint.Quantity:=Quantity1;
        InternalReprint."Graphic Finished":=GraphicFinished;
        InternalReprint."Location Code":=LocationCode;
        InternalReprint."Project Manager":=ProjectManager;
        InternalReprint."Design No":=DesignNo;
        InternalReprint.Other:=ValueForOther;
        InternalReprint."Detailing Metal":=DetailingMetal;
        InternalReprint."Detailing Wood":=DetailingWood;
        InternalReprint."Instruction Detailing":=InstructionDetailing;
        InternalReprint."Department Requesting Rework":=DepartmentRequestingRework;
        InternalReprint."Department Performing Rework":=DepartmentToPerformRework;
        InternalReprint."Root Cause For Rework":=RootCauseForRework;
        InternalReprint."Root Cause Department":=RootCauseDepartment;
        InternalReprint.Insert();
    end;
    var Material: Text[100];
    Quantity1: Text;
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
    EncodedSalesHeaderNoBarcode: Text;
    EncodedProductionOrderNoBarcode: Text;
    ShipDateText: Text;
    DateIssuedText: Text;
    ReripText: Text;
    ReprintText: Text;
    GraphicsFinishedText: Text;
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
    DetailingMetalText: Text;
    DetailingWoodText: Text;
    InstructionDetailingText: Text;
    RootCauseDepartment: Text;
    ReripCaption: Text;
    ReprintCaption: Text;
    FinishedCaption: Text;
    OtherReasonCaption: Text;
    procedure GetValues(SourceNoVar: Text; ClientNameVar: Text; ShipDateVar: Date; ShippingAgentCodeVar: Text; ShippingAgentServiceVar: Text; ProductionOrderNoVar: Text; ArtCoordinatorVar: Text; LocationCodeVar: Text)
    var
    begin
        SourceNo:=SourceNoVar;
        ClientName:=ClientNameVar;
        ShipDate:=ShipDateVar;
        ShippingAgentCode:=ShippingAgentCodeVar;
        ShippingAgentService:=ShippingAgentServiceVar;
        ProductionOrderRecord:=ProductionOrderNoVar;
        ArtCoordinator:=ArtCoordinatorVar;
        LocationCode:=LocationCodeVar;
    end;
    procedure GetBarcodeValues()
    var
        BarcodeSymbology: Enum "Barcode Font Provider";
        BarcodeInterface: Interface "Barcode Font Provider";
        EncodedSalesOrderNoBarcode: Text;
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        //SalesHeader.Reset();
        //SalesHeader.SetRange("No.", SourceNo);
        //if
        //SalesHeader.FindFirst()
        //then
        //begin
        BarcodeInterface:=BarcodeSymbology::IDAutomation1D;
        BarcodeInterface.ValidateInput(SourceNo, Enum::"Barcode Symbology"::Code128);
        EncodedSalesHeaderNoBarcode:=BarcodeInterface.EncodeFont(SourceNo, Enum::"Barcode Symbology"::Code128);
        BarcodeInterface.ValidateInput(ProductionOrderRecord, Enum::"Barcode Symbology"::Code128);
        EncodedProductionOrderNoBarcode:=BarcodeInterface.EncodeFont(ProductionOrderRecord, Enum::"Barcode Symbology"::Code128);
    //end
    //else
    //begin
    //SalesInvoiceHeader.Reset();
    //SalesInvoiceHeader.SetRange("Order No.", SourceNo);
    //if
    //SalesInvoiceHeader.FindFirst()
    //then
    //begin
    //BarcodeInterface := BarcodeSymbology::IDAutomation1D;
    //BarcodeInterface.ValidateInput(SalesInvoiceHeader."Order No.", Enum::"Barcode Symbology"::Code128);
    //BarcodeInterface.ValidateInput(ProductionOrderRecord, Enum::"Barcode Symbology"::Code128);
    //EncodedSalesHeaderNoBarcode := BarcodeInterface.EncodeFont(SourceNo, Enum::"Barcode Symbology"::Code128);
    //EncodedProductionOrderNoBarcode := BarcodeInterface.EncodeFont(ProductionOrderRecord, Enum::"Barcode Symbology"::Code128);
    //end;
    //end;
    end;
    procedure GetYesNoForBooleanValues()
    var
    begin
        if Rerip = true then ReripText:='Yes'
        else
            ReripText:='No';
        if Reprint = true then ReprintText:='Yes'
        else
            ReprintText:='No';
        if GraphicFinished = true then GraphicsFinishedText:='Yes'
        else
            GraphicsFinishedText:='No';
        if DetailingMetal = true then DetailingMetalText:='Yes'
        else
            DetailingMetalText:='No';
        if DetailingWood = true then DetailingWoodText:='Yes'
        else
            DetailingWoodText:='No';
        if InstructionDetailing = true then InstructionDetailingText:='Yes'
        else
            InstructionDetailingText:='No';
    end;
    procedure ReripReprintFinishedVisible()
    var
    begin
        if DepartmentToPerformRework = 'Graphics' then begin
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
        if RootCauseForRework = 'Other' then OtherReasonCaption:='Other Reason'
        else
        begin
            OtherReasonCaption:='';
            ValueForOther:='';
        end;
    end;
}
