(*
  info:
    Written by Shawn Medero <shawn@medero.net> for personal use. Tested with
    BBEdit 10 on OS X 10.7.0 with a custom XML-RPC server that implements a
    subset of the MetaWeblog API. (So, not thoroughly tested.)
    
    Version: 1.0.0    
    Last Updated: July 28th, 2011

  usage:
    You should update the homeURL, xmlrpcAccess, accountUsername, accountPassword and possibly the
    accountNumber settings to match your environment. 
    
  credits:
    - learned and copied quite a bit from this script:
      http://jlpoutre.home.xs4all.nl/BoT/Mac-OSX/post_blog_from_journler.html
    - apparently that site took a script written by Philip Dow, so props
    
  @@TODO:
    - Editing Support (get a list of current entries and populate a text 
      window with the contents)
    - Add draft support    
    - Add category support (I don't use categories in my blog but I'd be happy
      if someone added the feature none-the-less.)
    - Figure out if it works with popular MetaWeblog implementations
*)

-- general settings
property commandCategories : "metaWeblog.getCategories"
property commandPost : "metaWeblog.newPost"
property CR : ASCII character 10 -- line feed, actually...

-- site settings
property homeURL : "http://yoursite.com/"
property xmlrpcAccess : "http://yoursite.com/xml-rpc.php"

-- account settings
property accountUsername : ""
property accountPassword : ""
property accountNumber : "1"

on run
    
    if (length of homeURL is 0) then
        
        display alert Â
            "Settings Error" message Â
            "You must specify your blog's location, usually in the form of http://... You can set this in the Blog posting script." as critical
        return
        
    end if
    
    if (length of xmlrpcAccess is 0) then
        
        display alert Â
            "Settings Error" message Â
            "You must specify an XML-RPC access point with which BBEdit can interract when posting to your blog. You can set this in the Blog posting script." as critical
        return
        
    end if
    
    tell application "BBEdit"
        
        try
            
            set entryContent to contents of text window 1
            
            if (length of entryContent is 0) then
                
                display alert Â
                    "Text Retrieval Error" message Â
                    "The front-most BBEdit text window must contain some text in order to create an entry." as critical
                
            else
                
                set default_title to name of text window 1
                set entryTitle to the text returned of Â
                    (display dialog "What is the title of this entry?" default answer default_title)
                
            end if
            
        on error entryContentErr
            
            display alert Â
                "Text Retrieval Error" message Â
                (entryContentErr as string) as critical
            
        end try
        
    end tell
    
    set entryDate to formatISO8601(current date)
    set paramsPostEntryStruct to {title:entryTitle, |description|:entryContent, link:homeURL}
    set paramsPost to {accountNumber, accountUsername, accountPassword, paramsPostEntryStruct, true}
    
    try
        
        using terms from application "http://plant.blogger.com/api/RPC2"
            
            tell application xmlrpcAccess
                
                set postIDResult to call xmlrpc {method name:commandPost, parameters:paramsPost}
                
            end tell
            
        end using terms from
        
    on error theError
        
        display alert Â
            "Posting error: " & theError
        return
        
    end try
    
    display dialog "Successfully posted " & entryTitle & " to " & homeURL & ". Post ID " & postIDResult
    
end run

on formatISO8601(aDate)
    -- copied from http://www.musselrock.com/bkup_select.html
    copy aDate to b
    set month of b to January
    set x to 1 + ((aDate - b + 1314864) div 2629728)
    --
    if (x < 10) then
        set x to "0" & x
    end if
    set theTime to time of aDate
    set theHour to (theTime div 3600)
    set theMin to (theTime - theHour * 3600) div 60
    --is there an sprintf in applescript? I wish...
    if (theHour < 10) then
        set theHour to "0" & theHour
    end if
    if (theMin < 10) then
        set theMin to "0" & theMin
    end if
    "" & year of aDate & x & day of aDate & "T" & theHour & ":" & theMin & ":00"
end formatISO8601
