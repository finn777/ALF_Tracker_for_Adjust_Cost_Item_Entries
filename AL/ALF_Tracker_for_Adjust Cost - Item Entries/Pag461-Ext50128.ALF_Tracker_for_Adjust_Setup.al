pageextension 50128 ALF_Tracker_for_Adjust_Setup extends "Inventory Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("ALF AddData X of Documents"; "ALF AddData X of Documents")
            {
                ToolTip = 'ALF AddData. System will Create and Post X Sales Orders and X Purchase Orders.';
                ApplicationArea = All; //Always add this!
            }
            field("ALF Tracker for Adjust Cost"; "ALF Tracker for Adjust Cost")
            {
                ToolTip = 'ALF Tracker for Adjust Cost - Item Entries batch job.';
                ApplicationArea = All; //Always add this!
            }
        }        
    }
    
    actions
    {
        // Add changes to page actions here
            addlast("Posting")
            {
                action("ALF AddData")
                {
                    Image = CreateDocuments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'This feature (add data) for sandbox only. System will Create and Post Sales Orders and Purchase Orders. Use "ALF AddData X of Documents".';
                    trigger OnAction()
                    var AddData: codeunit ALF_Tracker_for_Adjust_AddData;
                    begin
                        IF Confirm('This feature (add data) for sandbox only. System will Create and Post %1 Sales Orders and %1 Purchase Orders. OK?',TRUE,rec."ALF AddData X of Documents") THEN BEGIN
                            AddData.AddData(rec."ALF AddData X of Documents");
                        END;    
                    end;
                }
                action("ALF ClearTrackerLog")
                {
                    Image = ClearLog;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Clear ALF_Tracker_for_Adjust_Log table.';
                    trigger OnAction()
                    var Code: codeunit ALF_Tracker_for_Adjust_Code;
                    begin
                        IF Confirm('Clear ALF_Tracker_for_Adjust_Log table. OK?',TRUE) THEN
                            Code.ClearALFTrackerLog();
                    end;
                }
                action("ALF OpenTrackerLog")
                {
                    Image = Log;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    ToolTip = 'Open ALF_Tracker_for_Adjust_LogList page.';
                    trigger OnAction()
                    var LogList: page ALF_Tracker_for_Adjust_LogList;
                    begin
                        LogList.Run();                        
                    end;
                }

            }    
    }        
    
}