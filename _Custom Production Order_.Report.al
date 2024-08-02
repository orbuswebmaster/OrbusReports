report 55105 "Custom Production Order"
{
    // version TCM7.1.1904
    // ************************
    // Copyright Notice
    // This objects content is copyright of Dynamic Manufacturing Solutions Inc 2011.  All rights reserved.
    // Any redistribution or reproduction of part or all of the contents in any form is prohibited.
    // ************************
    // 
    // <IW>
    //   <REVISION author="R.Dmytruk" date="2/21/2014" version="DMS14.02" issue="1121">
    //     SetRange on Status to only run on Released Production Orders
    //   </REVISION>
    //  <REVISION author="R.Letts" date="5/14/2014" version="DMS14.05" issue="TFS1314">
    //    Adding Operation comments to the report
    //  </REVISION>
    //  <REVISION author="M.Hamblin" date="6/10/2014" version="DMS14.06" issue="TFS1368">
    //   Fixes for family orders with different routings, additional multi-line support
    //  </REVISION>
    //  <REVISION author="R.Letts" date="9/5/2014" version="DMS14.09" issue="TFS1477">
    //   Changed date format to use the default NAV format for user.
    //  </REVISION>
    //  <REVISION author="t.d" date="08/27/2018" version="IW18.07" issue="TFS4165">
    //   Removed legacy checkboxes in RDLC
    //  </REVISION>
    //  <REVISION author="t.d" date="10/31/2018" version="IW18.10" issue="TFS4302">
    //    Changes to support extensions.
    //    Fixed indentation on data items.
    //  </REVISION>
    //  <REVISION author="ws" date="05/17/2019" version="IW19.05" issue="TFS4558">
    //   Use azure barcode API instead of 3 of 9 font for AL Cloud compatibility.
    //  </REVISION>
    // </IW>
    DefaultLayout = RDLC;
    RDLCLayout = './ReportLayouts/CustomProdOrderOrbus.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Custom Production Order';

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.")ORDER(Ascending);
            RequestFilterFields = Status, "No.", "Source No.";

            column(Sales_Order_No_; "Sales Order No.")
            {
            }
            column(Orbus_CustomerName; Orbus_CustomerName)
            {
            }
            column(Source_No_; "Source No.")
            {
            }
            column(HeaderDescription; Description)
            {
            }
            column(User; User)
            {
            }
            column(AssemblyNos; AssemblyNos)
            {
            }
            column(EncodedBarcodeValues; EncodedBarcodeValues)
            {
            }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = Status=FIELD(Status), "Prod. Order No."=FIELD("No.");
                DataItemLinkReference = "Production Order";
                RequestFilterFields = "Line No.";

                column(fldProdOrderNo; "Production Order"."No.")
                {
                }
                column(xSection1;1)
                {
                }
                column(fldSectionator; iSection)
                {
                }
                column(Prod_Order_Source_No; "Production Order"."Source No.")
                {
                }
                column(Prod_Order_Shelf_No; recItem."Shelf No.")
                {
                }
                column(Prod_Order_Quantity; Quantity)
                {
                }
                column(Prod_Order_Est_Weight; recItem."Net Weight")
                {
                }
                column(Prod_Order_Start_Date; FORMAT("Starting Date"))
                {
                }
                column(Prod_Order_End_Date; FORMAT("Ending Date"))
                {
                }
                column(Prod_Order_Description; Description)
                {
                }
                column(Prod_Order_Description2; "Description 2")
                {
                }
                column(Production_Order_Status; Status)
                {
                }
                column(Prod_Order_Line_Line_No; "Line No.")
                {
                }
                column(Orbus_Subcomponent1; Orbus_Subcomponent1)
                {
                }
                column(Orbus_Subcomponent2; Orbus_Subcomponent2)
                {
                }
                column(ProdOrderLine_ItemNo; "Item No.")
                {
                }
                column(ItemNo; ItemNo)
                {
                }
                column(Description; CompDescription)
                {
                }
                column(QTY; QTY)
                {
                }
                column(UOM; UOM)
                {
                }
                dataitem("Prod. Order Comment Line"; "Prod. Order Comment Line")
                {
                    DataItemLink = Status=FIELD(Status), "Prod. Order No."=FIELD("Prod. Order No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Line No.")ORDER(Ascending);

                    column(fldCOmment; Comment)
                    {
                    }
                    column(xSection2;2)
                    {
                    }
                    column(Prod__Order_Comment_Line_Status; Status)
                    {
                    }
                    column(Prod__Order_Comment_Line_Prod__Order_No_; "Prod. Order No.")
                    {
                    }
                    column(Prod__Order_Comment_Line_Line_No_; "Line No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        iSection:=2;
                    end;
                    trigger OnPreDataItem()
                    begin
                        iSection:=2;
                    end;
                }
                dataitem("Prod. Order Rtng Comment Line"; "Prod. Order Rtng Comment Line")
                {
                    DataItemLink = Status=FIELD(Status), "Prod. Order No."=FIELD("Prod. Order No."), "Routing Reference No."=FIELD("Routing Reference No."), "Routing No."=FIELD("Routing No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.", "Line No.")ORDER(Ascending);

                    column(fldRtngComment; Comment)
                    {
                    }
                    column(Prod__Order_Rtng_Comment_Line_Status; Status)
                    {
                    }
                    column(Prod__Order_Rtng_Comment_Line_Prod__Order_No_; "Prod. Order No.")
                    {
                    }
                    column(Prod__Order_Rtng_Comment_Line_Line_No_; "Line No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        iSection:=2;
                    end;
                    trigger OnPreDataItem()
                    begin
                        iSection:=2;
                    end;
                }
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    DataItemLink = Status=FIELD(Status), "Prod. Order No."=FIELD("Prod. Order No."), "Prod. Order Line No."=FIELD("Line No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.")ORDER(Ascending);

                    column(Prod_Comp_Item_Number; "Item No.")
                    {
                    }
                    column(xSection3;3)
                    {
                    }
                    column(Prod_Comp_Description; Description)
                    {
                    }
                    column(Prod_Comp_Quantity; Quantity)
                    {
                    }
                    column(Prod_Comp_Shelf; getShelfNo("Item No."))
                    {
                    }
                    column(Prod__Order_Component_Status; Status)
                    {
                    }
                    column(Prod__Order_Component_Prod__Order_No_; "Prod. Order No.")
                    {
                    }
                    column(Prod__Order_Component_Prod__Order_Line_No_; "Prod. Order Line No.")
                    {
                    }
                    column(Prod__Order_Component_Line_No_; "Line No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        iSection:=3;
                    end;
                    trigger OnPreDataItem()
                    begin
                        iSection:=3;
                    end;
                }
                dataitem("Prod. Order Routing Line"; "Prod. Order Routing Line")
                {
                    DataItemLink = "Prod. Order No."=FIELD("Prod. Order No."), Status=FIELD(Status), "Routing No."=FIELD("Routing No."), "Routing Reference No."=FIELD("Routing Reference No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Routing Reference No.", "Routing No.", "Operation No.")ORDER(Ascending);
                    RequestFilterFields = "Operation No.", "Work Center No.", "Routing Reference No.", Type, "No.", "Routing Status", "Routing No.";

                    column(xSection4;4)
                    {
                    }
                    column(Prod__Order_Routing_Line__Operation_No__; "Operation No.")
                    {
                    }
                    column(Prod_Routing_Work_Center; "No.")
                    {
                    }
                    column(Prod_Routing_Description; Description)
                    {
                    }
                    column(Prod_Routing_Est_Time; "Setup Time" + ("Run Time" * "Production Order".Quantity) + ("Wait Time" * "Production Order".Quantity))
                    {
                    DecimalPlaces = 2: 2;
                    }
                    column(Prod_Routing_Barcode; trecRoutingBarcode.Blob)
                    {
                    }
                    column(Prod_Routing_SetupBarcode; trecRoutingSetupBarcode.Blob)
                    {
                    }
                    column(Prod__Order_Routing_Line_Status; Status)
                    {
                    }
                    column(Prod__Order_Routing_Line_Prod__Order_No_; "Prod. Order No.")
                    {
                    }
                    column(Prod__Order_Routing_Line_Routing_Reference_No_; "Routing Reference No.")
                    {
                    }
                    column(Prod__Order_Routing_Line_Routing_No_; "Routing No.")
                    {
                    }
                    column(Orbus_Run_Time; "Run Time")
                    {
                    }
                    column(Orbus_Setup_Time; "Setup Time")
                    {
                    }
                    column(Comment_1; "Comment 1")
                    {
                    }
                    column(Comment_2; "Comment 2")
                    {
                    }
                    column(Comment_3; "Comment 3")
                    {
                    }
                    column(Comment_4; "Comment 4")
                    {
                    }
                    column(Comment_5; "Comment 5")
                    {
                    }
                    column(Routing_Line_Comment_1; "Routing Line Comment 1")
                    {
                    }
                    column(Routing_Line_Comment_2; "Routing Line Comment 2")
                    {
                    }
                    column(Routing_Line_Comment_3; "Routing Line Comment 3")
                    {
                    }
                    column(Routing_Line_Comment_4; "Routing Line Comment 4")
                    {
                    }
                    column(Routing_Line_Comment_5; "Routing Line Comment 5")
                    {
                    }
                    column(Routing_Line_Comment_6; "Routing Line Comment 6")
                    {
                    }
                    column(Routing_Line_Comment_7; "Routing Line Comment 7")
                    {
                    }
                    column(Routing_Line_Comment_8; "Routing Line Comment 8")
                    {
                    }
                    column(Routing_Line_Comment_9; "Routing Line Comment 9")
                    {
                    }
                    column(Routing_Line_Comment_10; "Routing Line Comment 10")
                    {
                    }
                    column(Routing_Line_Comment_11; "Routing Line Comment 11")
                    {
                    }
                    column(Routing_Line_Comment_12; "Routing Line Comment 12")
                    {
                    }
                    column(Routing_Line_Comment_13; "Routing Line Comment 13")
                    {
                    }
                    column(Routing_Line_Comment_14; "Routing Line Comment 14")
                    {
                    }
                    column(Routing_Line_Comment_15; "Routing Line Comment 15")
                    {
                    }
                    column(Routing_Line_Comment_16; "Routing Line Comment 16")
                    {
                    }
                    column(Routing_Line_Comment_17; "Routing Line Comment 17")
                    {
                    }
                    column(Routing_Line_Comment_18; "Routing Line Comment 18")
                    {
                    }
                    column(Routing_Line_Comment_19; "Routing Line Comment 19")
                    {
                    }
                    column(Routing_Line_Comment_20; "Routing Line Comment 20")
                    {
                    }
                    column(Machine_Comment_1; "Machine Comment 1")
                    {
                    }
                    column(Machine_Comment_2; "Machine Comment 2")
                    {
                    }
                    column(Machine_Comment_3; "Machine Comment 3")
                    {
                    }
                    column(Machine_Comment_4; "Machine Comment 4")
                    {
                    }
                    column(Machine_Comment_5; "Machine Comment 5")
                    {
                    }
                    column(ComponentItemNoWC; ComponentItemNoWC)
                    {
                    }
                    column(ComponentDescriptionWC; ComponentDescriptionWC)
                    {
                    }
                    column(ComponentQTYWC; ComponentQTYWC)
                    {
                    }
                    column(ComponentUOMWC; ComponentUOMWC)
                    {
                    }
                    column(ComponentItem1; ComponentItem1)
                    {
                    }
                    column(ComponentItem2; ComponentItem2)
                    {
                    }
                    column(ComponentItem3; ComponentItem3)
                    {
                    }
                    column(ComponentItem4; ComponentItem4)
                    {
                    }
                    column(ComponentItem5; ComponentItem5)
                    {
                    }
                    column(ComponentItem6; ComponentItem6)
                    {
                    }
                    column(ComponentItem7; ComponentItem7)
                    {
                    }
                    column(ComponentItem8; ComponentItem8)
                    {
                    }
                    column(ComponentItem9; ComponentItem9)
                    {
                    }
                    column(ComponentItem10; ComponentItem10)
                    {
                    }
                    column(ComponentItem11; ComponentItem11)
                    {
                    }
                    column(ComponentItem12; ComponentItem12)
                    {
                    }
                    column(ComponentItem13; ComponentItem13)
                    {
                    }
                    column(ComponentItem14; ComponentItem14)
                    {
                    }
                    column(ComponentItem15; ComponentItem15)
                    {
                    }
                    column(ComponentItem16; ComponentItem16)
                    {
                    }
                    column(ComponentItem17; ComponentItem17)
                    {
                    }
                    column(ComponentItem18; ComponentItem18)
                    {
                    }
                    column(ComponentItem19; ComponentItem19)
                    {
                    }
                    column(ComponentItem20; ComponentItem20)
                    {
                    }
                    column(ComponentItem21; ComponentItem21)
                    {
                    }
                    column(ComponentItem22; ComponentItem22)
                    {
                    }
                    column(ComponentItem23; ComponentItem23)
                    {
                    }
                    column(ComponentItem24; ComponentItem24)
                    {
                    }
                    column(ComponentItem25; ComponentItem25)
                    {
                    }
                    column(ComponentDescription1; ComponentDescription1)
                    {
                    }
                    column(ComponentDescription2; ComponentDescription2)
                    {
                    }
                    column(ComponentDescription3; ComponentDescription3)
                    {
                    }
                    column(ComponentDescription4; ComponentDescription4)
                    {
                    }
                    column(ComponentDescription5; ComponentDescription5)
                    {
                    }
                    column(ComponentDescription6; ComponentDescription6)
                    {
                    }
                    column(ComponentDescription7; ComponentDescription7)
                    {
                    }
                    column(ComponentDescription8; ComponentDescription8)
                    {
                    }
                    column(ComponentDescription9; ComponentDescription9)
                    {
                    }
                    column(ComponentDescription10; ComponentDescription10)
                    {
                    }
                    column(ComponentDescription11; ComponentDescription11)
                    {
                    }
                    column(ComponentDescription12; ComponentDescription12)
                    {
                    }
                    column(ComponentDescription13; ComponentDescription13)
                    {
                    }
                    column(ComponentDescription14; ComponentDescription14)
                    {
                    }
                    column(ComponentDescription15; ComponentDescription15)
                    {
                    }
                    column(ComponentDescription16; ComponentDescription16)
                    {
                    }
                    column(ComponentDescription17; ComponentDescription17)
                    {
                    }
                    column(ComponentDescription18; ComponentDescription18)
                    {
                    }
                    column(ComponentDescription19; ComponentDescription19)
                    {
                    }
                    column(ComponentDescription20; ComponentDescription20)
                    {
                    }
                    column(ComponentDescription21; ComponentDescription21)
                    {
                    }
                    column(ComponentDescription22; ComponentDescription22)
                    {
                    }
                    column(ComponentDescription23; ComponentDescription23)
                    {
                    }
                    column(ComponentDescription24; ComponentDescription24)
                    {
                    }
                    column(ComponentDescription25; ComponentDescription25)
                    {
                    }
                    column(ComponentQuantity1; ComponentQuantity1)
                    {
                    }
                    column(ComponentQuantity2; ComponentQuantity2)
                    {
                    }
                    column(ComponentQuantity3; ComponentQuantity3)
                    {
                    }
                    column(ComponentQuantity4; ComponentQuantity4)
                    {
                    }
                    column(ComponentQuantity5; ComponentQuantity5)
                    {
                    }
                    column(ComponentQuantity6; ComponentQuantity6)
                    {
                    }
                    column(ComponentQuantity7; ComponentQuantity7)
                    {
                    }
                    column(ComponentQuantity8; ComponentQuantity8)
                    {
                    }
                    column(ComponentQuantity9; ComponentQuantity9)
                    {
                    }
                    column(ComponentQuantity10; ComponentQuantity10)
                    {
                    }
                    column(ComponentQuantity11; ComponentQuantity11)
                    {
                    }
                    column(ComponentQuantity12; ComponentQuantity12)
                    {
                    }
                    column(ComponentQuantity13; ComponentQuantity13)
                    {
                    }
                    column(ComponentQuantity14; ComponentQuantity14)
                    {
                    }
                    column(ComponentQuantity15; ComponentQuantity15)
                    {
                    }
                    column(ComponentQuantity16; ComponentQuantity16)
                    {
                    }
                    column(ComponentQuantity17; ComponentQuantity17)
                    {
                    }
                    column(ComponentQuantity18; ComponentQuantity18)
                    {
                    }
                    column(ComponentQuantity19; ComponentQuantity19)
                    {
                    }
                    column(ComponentQuantity20; ComponentQuantity20)
                    {
                    }
                    column(ComponentQuantity21; ComponentQuantity21)
                    {
                    }
                    column(ComponentQuantity22; ComponentQuantity22)
                    {
                    }
                    column(ComponentQuantity23; ComponentQuantity23)
                    {
                    }
                    column(ComponentQuantity24; ComponentQuantity24)
                    {
                    }
                    column(ComponentQuantity25; ComponentQuantity25)
                    {
                    }
                    column(ComponentUOM1; ComponentUOM1)
                    {
                    }
                    column(ComponentUOM2; ComponentUOM2)
                    {
                    }
                    column(ComponentUOM3; ComponentUOM3)
                    {
                    }
                    column(ComponentUOM4; ComponentUOM4)
                    {
                    }
                    column(ComponentUOM5; ComponentUOM5)
                    {
                    }
                    column(ComponentUOM6; ComponentUOM6)
                    {
                    }
                    column(ComponentUOM7; ComponentUOM7)
                    {
                    }
                    column(ComponentUOM8; ComponentUOM8)
                    {
                    }
                    column(ComponentUOM9; ComponentUOM9)
                    {
                    }
                    column(ComponentUOM10; ComponentUOM10)
                    {
                    }
                    column(ComponentUOM11; ComponentUOM11)
                    {
                    }
                    column(ComponentUOM12; ComponentUOM12)
                    {
                    }
                    column(ComponentUOM13; ComponentUOM13)
                    {
                    }
                    column(ComponentUOM14; ComponentUOM14)
                    {
                    }
                    column(ComponentUOM15; ComponentUOM15)
                    {
                    }
                    column(ComponentUOM16; ComponentUOM16)
                    {
                    }
                    column(ComponentUOM17; ComponentUOM17)
                    {
                    }
                    column(ComponentUOM18; ComponentUOM18)
                    {
                    }
                    column(ComponentUOM19; ComponentUOM19)
                    {
                    }
                    column(ComponentUOM20; ComponentUOM20)
                    {
                    }
                    column(ComponentUOM21; ComponentUOM21)
                    {
                    }
                    column(ComponentUOM22; ComponentUOM22)
                    {
                    }
                    column(ComponentUOM23; ComponentUOM23)
                    {
                    }
                    column(ComponentUOM24; ComponentUOM24)
                    {
                    }
                    column(ComponentUOM25; ComponentUOM25)
                    {
                    }
                    dataitem("Integer"; "Integer")
                    {
                        DataItemTableView = SORTING(Number)ORDER(Ascending);

                        column(codToolNo; codToolNo)
                        {
                        }
                        column(sToolDescription; sToolDescription)
                        {
                        }
                        column(codPersonNo; codPersonNo)
                        {
                        }
                        column(sPersonDescription; sPersonDescription)
                        {
                        }
                        column(codQualityMeasure; codQualityMeasure)
                        {
                        }
                        column(sQualityDescription; sQualityDescription)
                        {
                        }
                        column(sQualityText; sQualityText)
                        {
                        }
                        column(Oper2BlackBag; "Prod. Order Routing Line"."Operation No.")
                        {
                        }
                        column(iIndex; iIndex)
                        {
                        }
                        column(Integer_Number; Number)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            CLEAR(codToolNo);
                            CLEAR(sToolDescription);
                            CLEAR(codPersonNo);
                            CLEAR(sPersonDescription);
                            CLEAR(codQualityMeasure);
                            CLEAR(sQualityDescription);
                            CLEAR(sQualityText);
                            if(iIndex <> 0)then begin
                                if(iIndex < recTools.COUNT())then recTools.NEXT();
                                if(iIndex < recPersonnel.COUNT())then recPersonnel.NEXT();
                                if(iIndex < recQualityMeasures.COUNT())then recQualityMeasures.NEXT();
                            end;
                            if(iIndex < recTools.COUNT())then begin
                                sToolDescription:=recTools.Description;
                                codToolNo:=recTools."No.";
                            end;
                            if(iIndex < recPersonnel.COUNT())then begin
                                sPersonDescription:=recPersonnel.Description;
                                codPersonNo:=recPersonnel."No.";
                            end;
                            if(iIndex < recQualityMeasures.COUNT())then begin
                                codQualityMeasure:=recQualityMeasures."Qlty Measure Code";
                                sQualityDescription:=recQualityMeasures.Description;
                                sQualityText:=STRSUBSTNO(tcQualityText, recQualityMeasures."Min. Value", recQualityMeasures."Max. Value", recQualityMeasures."Mean Tolerance");
                            end;
                            iIndex:=iIndex + 1;
                        end;
                        trigger OnPreDataItem()
                        var
                            liMax: Integer;
                        begin
                            iIndex:=0;
                            liMax:=recTools.COUNT();
                            if(recPersonnel.COUNT() > liMax)then liMax:=recPersonnel.COUNT();
                            if(recQualityMeasures.COUNT() > liMax)then liMax:=recQualityMeasures.COUNT();
                            SETRANGE(Number, 1, liMax);
                        end;
                    }
                    trigger OnAfterGetRecord()
                    var
                        lcuTempBlob: Codeunit "Temp Blob";
                    begin
                        GetComponents();
                        GetSalesOrderNo();
                        GetCustomerName();
                        GetComponentInfoIfHasRoutingLine();
                        iSection:=4;
                        CLEAR(sOperBarcode);
                        sOperBarcode:='*' + cuBarcodeMgmt.getRoutingBarcode("Prod. Order No.", "Prod. Order Line"."Line No.", "Operation No.", true) + '*';
                        //<IW author="ws" date="05/17/2019" issue="TFS4558">
                        Clear(trecRoutingBarcode);
                        cuBarcodeManager.Get3of9Barcode(lcuTempBlob, COPYSTR(sOperBarcode, 1, 1024), iBarcodeWidth, iBarcodeHeight);
                        trecRoutingBarcode.WriteToTempBlob(lcuTempBlob);
                        //</IW>
                        //<IW author="t.dimsdale" date="4/22/2015" issue="TFS1727" >
                        sSetupBarcode:='*' + cuBarcodeMgmt.getRoutingSetupBarcode("Prod. Order No.", "Prod. Order Line"."Line No.", "Operation No.", true) + '*';
                        //</IW>
                        //<IW author="ws" date="05/17/2019" issue="TFS4558">
                        Clear(trecRoutingSetupBarcode);
                        cuBarcodeManager.Get3of9Barcode(lcuTempBlob, COPYSTR(sSetupBarcode, 1, 250), iBarcodeWidth, iBarcodeHeight);
                        trecRoutingSetupBarcode.WriteToTempBlob(lcuTempBlob);
                        //</IW>
                        recTools.RESET();
                        recPersonnel.RESET();
                        recQualityMeasures.RESET();
                        recTools.SETRANGE(Status, Status);
                        recTools.SETRANGE("Prod. Order No.", "Prod. Order No.");
                        recTools.SETRANGE("Routing Reference No.", "Routing Reference No.");
                        recTools.SETRANGE("Routing No.", "Routing No.");
                        recTools.SETRANGE("Operation No.", "Operation No.");
                        if recTools.FIND('-')then;
                        recPersonnel.SETRANGE(Status, Status);
                        recPersonnel.SETRANGE("Prod. Order No.", "Prod. Order No.");
                        recPersonnel.SETRANGE("Routing Reference No.", "Routing Reference No.");
                        recPersonnel.SETRANGE("Routing No.", "Routing No.");
                        recPersonnel.SETRANGE("Operation No.", "Operation No.");
                        if recPersonnel.FIND('-')then;
                        recQualityMeasures.SETRANGE(Status, Status);
                        recQualityMeasures.SETRANGE("Prod. Order No.", "Prod. Order No.");
                        recQualityMeasures.SETRANGE("Routing Reference No.", "Routing Reference No.");
                        recQualityMeasures.SETRANGE("Routing No.", "Routing No.");
                        recQualityMeasures.SETRANGE("Operation No.", "Operation No.");
                        if recQualityMeasures.FIND('-')then;
                    end;
                    trigger OnPreDataItem()
                    begin
                        iSection:=4;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    ShipReport: Report "Whse. - Posted Shipment";
                begin
                    GetBlankComponentInfo();
                    GetSubcomponentValue();
                end;
            }
            trigger OnAfterGetRecord()
            var
                PickingListReport: Report "Picking List";
            begin
                iSection:=1;
                recItem.RESET();
                recItem.SETRANGE("No.", "Source No.");
                if not recItem.FIND('-')then recItem.INIT(); //<IW author="MH" date="6/10/2014" issue="TFS1368" />
                CLEAR(trecRoutingBarcode);
                GetComponents();
                GetSalesOrderNo();
                GetCustomerName();
            /*GetAssemblyNos();*/
            end;
            trigger OnPreDataItem()
            begin
                iSection:=1;
                SETRANGE(Status, Status::Released); //<IW author="R.Dmytuk" date="2/21/2014" version="DMS14.02" issue="1121"/>
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        //<IW author="ws" date="05/17/2019" issue="TFS4558">
        //values picked to be as close to 30pt 3of9 font as possible.
        //but size effected by rdlc too.
        iBarcodeWidth:=170;
        iBarcodeHeight:=20;
        //</IW>
        User:=UserId();
    end;
    trigger OnPostReport()
    var
        ProductionOrderHeader: Record "Production Order";
    begin
        ProductionOrderHeader.Reset();
        ProductionOrderHeader.SetRange("No.", "Production Order"."No.");
        if ProductionOrderHeader.FindFirst()then begin
            ProductionOrderHeader."Printed By":=UserId();
            ProductionOrderHeader."Printed At":=CurrentDateTime();
            ProductionOrderHeader.Modify();
        end;
    end;
    var recItem: Record Item;
    iSection: Integer;
    sOperBarcode: Text;
    sSetupBarcode: Text;
    codToolNo: Code[20];
    sToolDescription: Text;
    codPersonNo: Code[20];
    sPersonDescription: Text;
    codQualityMeasure: Code[50];
    sQualityDescription: Text;
    sQualityText: Text;
    Orbus_WorkCenterComment1: Text;
    Orbus_WorkCenterComment2: Text;
    Orbus_WorkCenterComment3: Text;
    Orbus_WorkCenterComment4: Text;
    Orbus_WorkCenterComment5: Text;
    Orbus_Subcomponent1: Text;
    Orbus_Subcomponent2: Text;
    Orbus_RoutingLinkItemNo1: Text;
    Orbus_RoutingLinkItemNo2: Text;
    Orbus_RoutingLinkItemNo3: Text;
    Orbus_RoutingLinkItemNo4: Text;
    Orbus_RoutingLinkItemNo5: Text;
    Orbus_SalesOrderNo: Text;
    Orbus_CustomerName: Text;
    ComponentItem1: Text;
    ComponentItem2: Text;
    ComponentItem3: Text;
    ComponentItem4: Text;
    ComponentItem5: Text;
    ComponentItem6: Text;
    ComponentItem7: Text;
    ComponentItem8: Text;
    ComponentItem9: Text;
    ComponentItem10: Text;
    ComponentItem11: Text;
    ComponentItem12: Text;
    ComponentItem13: Text;
    ComponentItem14: Text;
    ComponentItem15: Text;
    ComponentItem16: Text;
    ComponentItem17: Text;
    ComponentItem18: Text;
    ComponentItem19: Text;
    ComponentItem20: Text;
    ComponentItem21: Text;
    ComponentItem22: Text;
    ComponentItem23: Text;
    ComponentItem24: Text;
    ComponentItem25: Text;
    ComponentDescription1: Text;
    ComponentDescription2: Text;
    ComponentDescription3: Text;
    ComponentDescription4: Text;
    ComponentDescription5: Text;
    ComponentDescription6: Text;
    ComponentDescription7: Text;
    ComponentDescription8: Text;
    ComponentDescription9: Text;
    ComponentDescription10: Text;
    ComponentDescription11: Text;
    ComponentDescription12: Text;
    ComponentDescription13: Text;
    ComponentDescription14: Text;
    ComponentDescription15: Text;
    ComponentDescription16: Text;
    ComponentDescription17: Text;
    ComponentDescription18: Text;
    ComponentDescription19: Text;
    ComponentDescription20: Text;
    ComponentDescription21: Text;
    ComponentDescription22: Text;
    ComponentDescription23: Text;
    ComponentDescription24: Text;
    ComponentDescription25: Text;
    ComponentUOM1: Text;
    ComponentUOM2: Text;
    ComponentUOM3: Text;
    ComponentUOM4: Text;
    ComponentUOM5: Text;
    ComponentUOM6: Text;
    ComponentUOM7: Text;
    ComponentUOM8: Text;
    ComponentUOM9: Text;
    ComponentUOM10: Text;
    ComponentUOM11: Text;
    ComponentUOM12: Text;
    ComponentUOM13: Text;
    ComponentUOM14: Text;
    ComponentUOM15: Text;
    ComponentUOM16: Text;
    ComponentUOM17: Text;
    ComponentUOM18: Text;
    ComponentUOM19: Text;
    ComponentUOM20: Text;
    ComponentUOM21: Text;
    ComponentUOM22: Text;
    ComponentUOM23: Text;
    ComponentUOM24: Text;
    ComponentUOM25: Text;
    User: Text;
    ComponentQuantity1: Decimal;
    ComponentQuantity2: Decimal;
    ComponentQuantity3: Decimal;
    ComponentQuantity4: Decimal;
    ComponentQuantity5: Decimal;
    ComponentQuantity6: Decimal;
    ComponentQuantity7: Decimal;
    ComponentQuantity8: Decimal;
    ComponentQuantity9: Decimal;
    ComponentQuantity10: Decimal;
    ComponentQuantity11: Decimal;
    ComponentQuantity12: Decimal;
    ComponentQuantity13: Decimal;
    ComponentQuantity14: Decimal;
    ComponentQuantity15: Decimal;
    ComponentQuantity16: Decimal;
    ComponentQuantity17: Decimal;
    ComponentQuantity18: Decimal;
    ComponentQuantity19: Decimal;
    ComponentQuantity20: Decimal;
    ComponentQuantity21: Decimal;
    ComponentQuantity22: Decimal;
    ComponentQuantity23: Decimal;
    ComponentQuantity24: Decimal;
    ComponentQuantity25: Decimal;
    ItemNo: Text;
    QTY: Text;
    UOM: Text;
    CompDescription: Text;
    ComponentItemNoWC: Text;
    ComponentQTYWC: Text;
    ComponentUOMWC: Text;
    ComponentDescriptionWC: Text;
    AssemblyNos: Text;
    EncodedBarcodeValues: Text;
    Linebreak: Label '\';
    recTools: Record "Prod. Order Routing Tool";
    recPersonnel: Record "Prod. Order Routing Personnel";
    recQualityMeasures: Record "Prod. Order Rtng Qlty Meas.";
    iIndex: Integer;
    tcQualityText: Label '%1 / %2 / %3';
    cuBarcodeMgmt: Codeunit "SFI Barcode Mgmt";
    trecRoutingBarcode: Record "SFI TempBlob" temporary;
    trecRoutingSetupBarcode: Record "SFI TempBlob" temporary;
    cuBarcodeManager: Codeunit "IWX Barcode Generation";
    iBarcodeWidth: Integer;
    iBarcodeHeight: Integer;
    local procedure getShelfNo(pcodItemNo: Code[20]): Code[40]var
        lrecItem: Record Item;
    begin
        if lrecItem.GET(pcodItemNo)then exit(lrecItem."Shelf No.");
        exit('');
    end;
    local procedure GetWorkCenterComments()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        WorkCenter: Record "Work Center";
        ManufacturingCommentLine: Record "Manufacturing Comment Line";
    begin
        ProdOrderRoutingLine.SetRange("Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
        ProdOrderRoutingLine.SetRange(Type, ProdOrderRoutingLine.Type::"Work Center");
        if ProdOrderRoutingLine.FindFirst()then repeat ProdOrderRoutingLine.Next(1);
                WorkCenter.SetRange("No.", "Prod. Order Routing Line"."Work Center No.");
                if WorkCenter.FindFirst()then ManufacturingCommentLine.SetRange("No.", WorkCenter."No.");
                if ManufacturingCommentLine.FindFirst()then begin
                    Orbus_WorkCenterComment1:=ManufacturingCommentLine.Comment;
                    ManufacturingCommentLine.Next(1);
                    Orbus_WorkCenterComment2:=ManufacturingCommentLine.Comment;
                end;
            until ProdOrderRoutingLine.Next() = 0;
    end;
    local procedure GetWorkCenterComments2()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        WorkCenter: Record "Work Center";
        ManufacturingCommentLine: Record "Manufacturing Comment Line";
    begin
        ProdOrderRoutingLine.SetRange("Prod. Order No.", "Prod. Order Line"."Prod. Order No.");
        ProdOrderRoutingLine.SetRange(Type, ProdOrderRoutingLine.Type::"Work Center");
        if ProdOrderRoutingLine.FindSet()then repeat WorkCenter.SetRange("No.", "Prod. Order Routing Line"."Work Center No.");
                if WorkCenter.FindFirst()then ManufacturingCommentLine.SetRange("No.", WorkCenter."No.");
                if ManufacturingCommentLine.FindFirst()then begin
                    Orbus_WorkCenterComment1:=ManufacturingCommentLine.Comment;
                    ManufacturingCommentLine.Next(1);
                    Orbus_WorkCenterComment2:=ManufacturingCommentLine.Comment;
                    if Orbus_WorkCenterComment2 = Orbus_WorkCenterComment1 then Orbus_WorkCenterComment2:='';
                    ManufacturingCommentLine.Next(1);
                    Orbus_WorkCenterComment3:=ManufacturingCommentLine.Comment;
                    if Orbus_WorkCenterComment3 = Orbus_WorkCenterComment2 then Orbus_WorkCenterComment3:='';
                    if Orbus_WorkCenterComment3 = Orbus_WorkCenterComment1 then Orbus_WorkCenterComment3:='';
                    ManufacturingCommentLine.Next(1);
                    Orbus_WorkCenterComment4:=ManufacturingCommentLine.Comment;
                    if Orbus_WorkCenterComment4 = Orbus_WorkCenterComment3 then Orbus_WorkCenterComment3:='';
                    if Orbus_WorkCenterComment4 = Orbus_WorkCenterComment2 then Orbus_WorkCenterComment3:='';
                    if Orbus_WorkCenterComment4 = Orbus_WorkCenterComment1 then Orbus_WorkCenterComment3:='';
                    ManufacturingCommentLine.Next(1);
                    Orbus_WorkCenterComment5:=ManufacturingCommentLine.Comment;
                    if Orbus_WorkCenterComment5 = Orbus_WorkCenterComment4 then Orbus_WorkCenterComment3:='';
                    if Orbus_WorkCenterComment5 = Orbus_WorkCenterComment3 then Orbus_WorkCenterComment3:='';
                    if Orbus_WorkCenterComment5 = Orbus_WorkCenterComment2 then Orbus_WorkCenterComment3:='';
                    if Orbus_WorkCenterComment5 = Orbus_WorkCenterComment1 then Orbus_WorkCenterComment3:='';
                end;
            until ProdOrderRoutingLine.Next() = 0;
    end;
    local procedure GetSubcomponentValue()
    var
        ProdOrderLines: Record "Prod. Order Line";
    begin
        if "Prod. Order Line"."Line No." > 10000 then Orbus_Subcomponent1:='(Subcomponent)'
        else
            Orbus_Subcomponent1:='' end;
    local procedure GetSalesOrderNo()
    var
        OrderTrackingEntry: Record "Order Tracking Entry";
        ProductionOrderHeader: Record "Production Order";
    begin
        OrderTrackingEntry.SetRange("For ID", "Production Order"."No.");
        if OrderTrackingEntry.FindFirst()then Orbus_SalesOrderNo:=OrderTrackingEntry."From ID";
    end;
    local procedure GetCustomerName()
    var
        Customer: Record Customer;
        ProductionOrderHeader: Record "Production Order";
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange("No.", "Production Order"."Source No.");
        if SalesHeader.FindFirst()then Orbus_CustomerName:=SalesHeader."Bill-to Name";
    end;
    local procedure GetComponents()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        Orbus_RoutingLinkItemNo1:='';
        ProdOrderRoutingLine.SetRange("Prod. Order No.", "Production Order"."No.");
        if ProdOrderRoutingLine.FindSet()then repeat if ProdOrderRoutingLine."Routing Link Code" <> '' then begin
                    ProdOrderComponent.SetRange("Prod. Order No.", "Production Order"."No.");
                    ProdOrderComponent.SetRange("Routing Link Code", ProdOrderRoutingLine."Routing Link Code");
                    if ProdOrderComponent.FindFirst()then if Orbus_RoutingLinkItemNo1 = '' then begin
                            Orbus_RoutingLinkItemNo1:=ProdOrderComponent."Item No.";
                            ProdOrderComponent.Next(1);
                            Orbus_RoutingLinkItemNo2:=ProdOrderComponent."Item No.";
                            ProdOrderComponent.Next(1);
                            Orbus_RoutingLinkItemNo3:=ProdOrderComponent."Item No.";
                            ProdOrderComponent.Next(1);
                            Orbus_RoutingLinkItemNo4:=ProdOrderComponent."Item No.";
                            ProdOrderComponent.Next(1);
                            Orbus_RoutingLinkItemNo5:=ProdOrderComponent."Item No.";
                        end;
                end;
            until ProdOrderRoutingLine.Next() = 0;
    end;
    local procedure GetBlankComponentInfo()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProdOrderComponent: Record "Prod. Order Component";
        ProductionOrderLine: Record "Prod. Order Line";
        CRLF: Text[2];
        TypeHelper: Codeunit "Type Helper";
    begin
        CRLF:=TypeHelper.CRLFSeparator();
        ItemNo:='';
        CompDescription:='';
        QTY:='';
        UOM:='';
        ProdOrderComponent.Reset();
        ProdOrderComponent.SetRange("Prod. Order No.", "Production Order"."No.");
        ProdOrderComponent.SetRange("Prod. Order Line No.", "Prod. Order Line"."Line No.");
        ProdOrderComponent.SetRange("Routing Link Code", '');
        if ProdOrderComponent.FindSet()then repeat ItemNo:=ItemNo + CRLF + CRLF + ProdOrderComponent."Item No.";
                CompDescription:=CompDescription + CRLF + CRLF + ProdOrderComponent."Short Description";
                UOM:=UOM + CRLF + CRLF + ProdOrderComponent."Unit of Measure Code";
                QTY:=Format(QTY) + Format(CRLF) + Format(CRLF) + Format(ProdOrderComponent."Expected Quantity");
            until ProdOrderComponent.Next() = 0;
    end;
    local procedure GetComponentInfoIfHasRoutingLine()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        ProdOrderComponent: Record "Prod. Order Component";
        ProductionOrderLine: Record "Prod. Order Line";
        ProdOrderLine: Record "Prod. Order Line";
        CRLF: Text[2];
        TypeHelper: Codeunit "Type Helper";
        var1: Integer;
        var2: Text;
    begin
        CRLF:=TypeHelper.CRLFSeparator();
        ComponentItemNoWC:='';
        ComponentDescriptionWC:='';
        ComponentQTYWC:='';
        ComponentUOMWC:='';
        var1:=0;
        ProdOrderRoutingLine.Reset();
        ProdOrderRoutingLine.SetRange("Prod. Order No.", "Production Order"."No.");
        ProdOrderRoutingLine.SetRange("Operation No.", "Prod. Order Routing Line"."Operation No.");
        ProdOrderRoutingLine.SetRange("Routing Reference No.", "Prod. Order Line"."Line No.");
        if ProdOrderRoutingLine.FindFirst()then if ProdOrderRoutingLine."Routing Link Code" <> '' then begin
                ProdOrderComponent.SetRange("Prod. Order No.", "Production Order"."No.");
                ProdOrderComponent.SetRange("Routing Link Code", ProdOrderRoutingLine."Routing Link Code");
                ProdOrderComponent.SetRange("Prod. Order Line No.", ProdOrderRoutingLine."Routing Reference No.");
                if ProdOrderComponent.FindSet()then repeat ComponentItemNoWC:=ComponentItemNoWC + CRLF + CRLF + ProdOrderComponent."Item No.";
                        ComponentDescriptionWC:=ComponentDescriptionWC + CRLF + CRLF + ProdOrderComponent."Short Description";
                        ComponentUOMWC:=ComponentUOMWC + CRLF + CRLF + ProdOrderComponent."Unit of Measure Code";
                        ComponentQTYWC:=Format(ComponentQTYWC) + Format(CRLF) + Format(CRLF) + Format(ProdOrderComponent."Expected Quantity");
                    until ProdOrderComponent.Next() = 0;
            end
            else
                ComponentItemNoWC:='';
    end;
    procedure GetAssemblyNos()
    var
        AssemblyHeader: Record "Assembly Header";
        LineBreak: Text;
        TypeHelper: Codeunit "Type Helper";
        BarcodeInterface: Interface "Barcode Font Provider";
        BarcodeValue: Text;
    begin
        BarcodeValue:='';
        LineBreak:=TypeHelper.CRLFSeparator();
        BarcodeInterface:=Enum::"Barcode Font Provider"::IDAutomation1D;
        AssemblyNos:='';
        EncodedBarcodeValues:='';
        AssemblyHeader.Reset();
        AssemblyHeader.SetRange("Sales Header No.", "Production Order"."Source No.");
        if AssemblyHeader.FindSet()then repeat BarcodeValue:='';
                BarcodeValue:=AssemblyHeader."No.";
                AssemblyNos:=AssemblyNos + AssemblyHeader."No." + LineBreak + LineBreak + Linebreak + LineBreak;
                BarcodeInterface.ValidateInput(BarcodeValue, Enum::"Barcode Symbology"::Code39);
                EncodedBarcodeValues:=EncodedBarcodeValues + BarcodeInterface.EncodeFont(BarcodeValue, Enum::"Barcode Symbology"::Code39) + LineBreak + Linebreak;
            until AssemblyHeader.Next() = 0;
        if AssemblyNos <> '' then begin
            AssemblyNos:=DelChr(AssemblyNos, '>', LineBreak + LineBreak + LineBreak + LineBreak);
            EncodedBarcodeValues:=DelChr(EncodedBarcodeValues, '>', LineBreak + LineBreak);
        end;
    end;
}
