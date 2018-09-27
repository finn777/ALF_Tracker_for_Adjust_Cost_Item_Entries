table 50128 ALF_Tracker_for_Adjust_Log
{
    DataClassification = CustomerContent;
    DrillDownPageId = "ALF_Tracker_for_Adjust_LogList";
    LookupPageId = "ALF_Tracker_for_Adjust_LogList";    
    fields
    {
        field(1;ID; BigInteger)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;            
        }
        field(2; "Start Time"; DateTime)
        {
            DataClassification = CustomerContent;            
        }
        field(3; "End Time"; DateTime)
        {
            DataClassification = CustomerContent;            
        }
        field(4; "Elapsed Time (msec)"; BigInteger)
        {
            DataClassification = CustomerContent;            
        }
        field(5; "Elapsed Time (text)"; Duration)
        {
            DataClassification = CustomerContent;            
        }
        field(6; "ItemNoFilter"; Text[250])
        {
            DataClassification = CustomerContent;            
        }        
        field(7; "ItemCategoryFilter"; Text[250])
        {
            DataClassification = CustomerContent;            
        }       
        field(8; "PostToGL"; Boolean)
        {
            DataClassification = CustomerContent;            
        }


    }
    
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    
   
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}