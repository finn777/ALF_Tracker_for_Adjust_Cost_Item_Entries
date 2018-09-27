tableextension 50128 ALF_Tracker_for_Adjust_Setup extends "Inventory Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50128; "ALF AddData X of Documents"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50129; "ALF Tracker for Adjust Cost"; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }    
}