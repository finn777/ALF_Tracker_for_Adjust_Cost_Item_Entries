codeunit 50129 ALF_Tracker_for_Adjust_AddData
{

    trigger OnRun()
    begin
        AddData(5);
    end;

    var
        VendorNoArray: array [5] of Code[20];
        CustomerNoArray: array [5] of Code[20];
        ItemNoArray: array [20] of Code[20];
        LocationCodeArray: array [3] of Code[10];
        I_DOC: Integer;
        PermissionManager: Codeunit "Permission Manager";

    local procedure GetNextVendorNo() NextNo: Code[20]
    var
        N: Integer;
    begin
        RANDOMIZE;
        N := RANDOM(5);
        exit(VendorNoArray[N]);
    end;

    local procedure GetNextCustomerNo() NextNo: Code[20]
    var
        N: Integer;
    begin
        RANDOMIZE;
        N := RANDOM(5);
        exit(CustomerNoArray[N]);
    end;

    local procedure GetNextItemNo() NextNo: Code[20]
    var
        N: Integer;
    begin
        RANDOMIZE;
        N := RANDOM(20);
        exit(ItemNoArray[N]);
    end;

    local procedure GetNextLocationCode() NextCode: Code[10]
    var
        N: Integer;
    begin
        RANDOMIZE;
        N := RANDOM(3);
        exit(LocationCodeArray[N]);
    end;

    local procedure CreatePurchaseDoc()
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        I_LINE: Integer;
        NextLineNo: Integer;
        PurchasePost: Codeunit "Purch.-Post";
        N: Integer;
    begin
          // Create Purchase Header
          with PurchaseHeader do begin
            RESET;
            INIT;
            "Document Type" := "Document Type"::Order;
            INSERT(true);
            COMMIT;
            VALIDATE("Buy-from Vendor No.",GetNextVendorNo);
            VALIDATE("Order Date",WORKDATE);
            VALIDATE("Posting Date",WORKDATE);
            VALIDATE("Expected Receipt Date",WORKDATE);
            "Vendor Order No." := "No.";
            "Vendor Shipment No." := "No.";
            "Vendor Invoice No." := "No."+'_'+FORMAT(RANDOM(1000));
            MODIFY(true);
            COMMIT;
          end;

          // Create Purchase Lines
          NextLineNo := 0;
          with PurchaseLine do begin
            for I_LINE := 1 to 10 do begin
              RESET;
              INIT;
              "Document Type" := "Document Type"::Order;
              "Document No." := PurchaseHeader."No.";
              NextLineNo := NextLineNo + 10000;
              "Line No." := NextLineNo;
              INSERT(true);
              COMMIT;
              Type := Type::Item;
              VALIDATE("No.",GetNextItemNo);
              RANDOMIZE;
              N := RANDOM(100);
              VALIDATE(Quantity,N);
              RANDOMIZE;
              N := RANDOM(1000);
              VALIDATE("Direct Unit Cost",N);
              MODIFY(true);
              COMMIT;
            end;
          end;

          CODEUNIT.RUN(CODEUNIT::"Release Purchase Document",PurchaseHeader);

          // Post Purchase document (Order)
          with PurchaseHeader do begin
            Receive := true;
            Invoice := true;
          end;
          PurchasePost.RUN(PurchaseHeader);
    end;

    local procedure CreateSalesDoc()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        I_LINE: Integer;
        NextLineNo: Integer;
        SalesPost: Codeunit "Sales-Post";
        N: Integer;
    begin
          // Create Sales Header
          with SalesHeader do begin
            RESET;
            INIT;
            "Document Type" := "Document Type"::Order;
            INSERT(true);
            COMMIT;
            VALIDATE("Sell-to Customer No.",GetNextCustomerNo);
            VALIDATE("Order Date",WORKDATE);
            VALIDATE("Posting Date",WORKDATE);
            VALIDATE("Shipment Date",WORKDATE);
            MODIFY(true);
            COMMIT;
          end;

          // Create Sales Lines
          NextLineNo := 0;
          with SalesLine do begin
            for I_LINE := 1 to 10 do begin
              RESET;
              INIT;
              "Document Type" := "Document Type"::Order;
              "Document No." := SalesHeader."No.";
              NextLineNo := NextLineNo + 10000;
              "Line No." := NextLineNo;
              INSERT(true);
              COMMIT;
              Type := Type::Item;
              VALIDATE("No.",GetNextItemNo);
              RANDOMIZE;
              N := RANDOM(100);
              VALIDATE(Quantity,N);
              MODIFY(true);
              COMMIT;
            end;
          end;

          CODEUNIT.RUN(CODEUNIT::"Release Sales Document",SalesHeader);

          // Post Sales document (Order)
          with SalesHeader do begin
            Ship := true;
            Invoice := true;
          end;
          SalesPost.RUN(SalesHeader);
    end;

    [Scope('Personalization')]
    procedure AddData(DOCNUMBER: Integer)
    begin
        if not PermissionManager.IsSandboxConfiguration then begin
          MESSAGE('This feature (add data) for sandbox only.');
          exit;
        end;

        // Used such master records, based on CRONUS US demo data
        VendorNoArray[1] := '10000';
        VendorNoArray[2] := '20000';
        VendorNoArray[3] := '30000';
        VendorNoArray[4] := '40000';
        VendorNoArray[5] := '50000';

        CustomerNoArray[1] := '10000';
        CustomerNoArray[2] := '20000';
        CustomerNoArray[3] := '30000';
        CustomerNoArray[4] := '40000';
        CustomerNoArray[5] := '50000';

        ItemNoArray[1] := '1896-S';
        ItemNoArray[2] := '1900-S';
        ItemNoArray[3] := '1906-S';
        ItemNoArray[4] := '1908-S';
        ItemNoArray[5] := '1920-S';
        ItemNoArray[6] := '1925-W';
        ItemNoArray[7] := '1928-S';
        ItemNoArray[8] := '1929-W';
        ItemNoArray[9] := '1936-S';
        ItemNoArray[10] := '1953-W';
        ItemNoArray[11] := '1960-S';
        ItemNoArray[12] := '1964-S';
        ItemNoArray[13] := '1965-W';
        ItemNoArray[14] := '1968-S';
        ItemNoArray[15] := '1969-W';
        ItemNoArray[16] := '1972-S';
        ItemNoArray[17] := '1980-S';
        ItemNoArray[18] := '1988-S';
        ItemNoArray[19] := '1996-S';

        ItemNoArray[20] := '2000-S';

        LocationCodeArray[1] := 'EAST';
        LocationCodeArray[2] := 'MAIN';
        LocationCodeArray[3] := 'WEST';

        for I_DOC := 1 to DOCNUMBER do begin
          CreateSalesDoc;
        end;

        for I_DOC := 1 to DOCNUMBER do begin
          CreatePurchaseDoc;
        end;
        MESSAGE('Created and Posted %1 Sales Orders and %1 Purchase Orders.',DOCNUMBER);
    end;
}

