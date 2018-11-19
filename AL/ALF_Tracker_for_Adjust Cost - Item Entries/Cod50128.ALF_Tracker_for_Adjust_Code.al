codeunit 50128 ALF_Tracker_for_Adjust_Code
{
    [EventSubscriber(ObjectType::Report, Report::"Adjust Cost - Item Entries", 'OnBeforePreReport', '', true, true)] 
    local procedure OnBeforePreReportProcedure(ItemNoFilter:Text[250];ItemCategoryFilter:Text[250];PostToGL:Boolean)
    // GlobalVarAccess = yes, ItemNoFilter (Global variable),... picking from report 795
    begin        
        InvSetup.FindFirst();
        IF NOT InvSetup."ALF Tracker for Adjust Cost" THEN EXIT;
        Log.Init();
        Log."Start Time" := CurrentDateTime();
        Log.ItemNoFilter := ItemNoFilter;
        Log.ItemCategoryFilter := ItemCategoryFilter;
        Log.PostToGL := PostToGL;
        Log.Insert();
        Commit();
    end;
    /*
    [EventSubscriber(ObjectType::Report, Report::"Adjust Cost - Item Entries", 'OnAfterPreReport', '', true, true)] 
    local procedure OnAfterPreReportProcedure()    
    begin
        InvSetup.FindFirst();
        IF NOT InvSetup."ALF Tracker for Adjust Cost" THEN EXIT;
        IF Log.FindLast() THEN BEGIN
            Log."End Time" := CurrentDateTime();
            Log."Elapsed Time (msec)" := Log."End Time" - Log."Start Time";
            Log."Elapsed Time (text)" := Log."Elapsed Time (msec)";
            // Log."Elapsed Time (text) - Duration type
            Log.Modify();
            Commit();
        END;
    end;
    */
    procedure ClearALFTrackerLog()
    begin
        Log.DeleteAll();
        Commit();    
    end;

    var
    Log: record ALF_Tracker_for_Adjust_Log;
    InvSetup: record "Inventory Setup";
}

