page 50128 ALF_Tracker_for_Adjust_LogList
{
    PageType = List;
    SourceTable = "ALF_Tracker_for_Adjust_Log";
    UsageCategory = Lists; //Add this for search
    ApplicationArea = All; //Always add this!
    Caption='ALF_Tracker_for_Adjust_LogList';
    Editable = false;   
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(ID; ID)
                {
                  ApplicationArea = All;  
                }
                field("Start Time"; "Start Time")
                {
                  ApplicationArea = All;  
                }
                field("End Time"; "End Time")
                {
                  ApplicationArea = All;  
                }
                field("Elapsed Time (msec)"; "Elapsed Time (msec)")
                {
                  ApplicationArea = All;  
                }
                field("Elapsed Time (text)"; "Elapsed Time (text)")
                {
                  ApplicationArea = All;  
                }
                field("ItemNoFilter"; "ItemNoFilter")
                {
                  ApplicationArea = All;  
                }
                field("ItemCategoryFilter"; "ItemCategoryFilter")
                {
                  ApplicationArea = All;  
                }
                field("PostToGL"; "PostToGL")
                {
                  ApplicationArea = All;  
                }
            }
        }
        area(factboxes)
        {
            
        }
    }
    
    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction();
                begin
                    
                end;
            }
        }
    }
}