codeunit 55181 GetCreatedByForReleasedProd
{
    Permissions = tabledata "Production Order"=RIMD;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        ProdOrder: Record "Production Order";
        User: Record User;
        var1: GUID;
    begin
        ProdOrder.Reset();
        if ProdOrder.FindSet()then repeat if(ProdOrder.Status = ProdOrder.Status::Finished) or (ProdOrder.Status = ProdOrder.Status::Released)then begin
                    if ProdOrder."Created By" = '' then begin
                        var1:=ProdOrder.SystemCreatedBy;
                        User.Reset();
                        User.SetRange("User Security ID", var1);
                        if User.FindFirst()then begin
                            ProdOrder."Created By":=User."User Name";
                            ProdOrder.Modify();
                        end;
                    end;
                end;
            until ProdOrder.Next() = 0 end;
}
