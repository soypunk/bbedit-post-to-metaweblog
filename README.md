# Post Entry to blog from BBEdit

This is an AppleScript that will allow you to take the text contents of the
front-most BBEdit window and post them to your MetaWeblog-capable blog server.

To install the script, place the contents of the Blog folder inside your BBEdit
Scripts folder. This can be found by navigating to the 
`Library/Application Support/BBEdit/Scripts` folder under your home directory.
Inside BBEdit you can assign a keyboard shortcut to a script if you like. I 
find that kinda of nifty myself. Use the Script Palette 
(Window>Palettes>Scripts), select your script, and then use the Set Key button.

There's some configuration that needs to be at the top of the script (URLs, 
account info, etc.)

I've only tested this script with BBEdit 10 on OS X 10.7.0 with a personal blog
system I wrote. I have no idea if it works with the popular MetaWeblog 
implementations found in Drupal or Wordpress. If it works, let me know. If it 
doesn't, please fork the script and patch it. I don't use Drupal or Wordpress 
in the context this script was written for so I don't have the motivation to 
make time in order to work on such an endeavor. I'll gladly take a patch, 
review, merge and assign credit where credit is due though.

There are some unmentioned assumptions this script makes. Personally I write my
blog entries in BBEdit using Markdown. Posting Markdown directly to my server 
is ideal because it handles the Markdown->HTML conversion. I assume this script 
will work equally well with hand-coded HTML but I haven't tried it. It is very 
likely there are some edge-case encoding issues that AppleScript doesn't handle
without some hand-holding. AppleScript isn't really my area of expertise.
