Roblox store: https://create.roblox.com/store/asset/140163641734207/UChatReDist-UChat-Latest-Build

return {} -- dont break if u require me

--[[
README - UChat Chat System
===========================

Current Version: v1.0.0 (Feb 2, 2026)
Contact: @stupid_guy049 (Kitasan_Black)
         mailto:random.nonprivate.email@gmail.com
         github:potato-master369

REPORT AN ISSUE: Don't. I don't really care.

Setup:

    Copy the contents of the folders
    (e.g. Put my contents in
    StarterGui)
    
    Be sure to ensure you did not copy the ENTIRE folder.
    Say, copy UChatUpdate, NOT the "Put my contents in
    ReplicatedStorage" folder.
    
    You can delete this script and the remaining folders
    after setup.
    
Docs:
    
    RemoteEvents:
    	
    	UChatUpdate: FireServer(filterstring, data)
    		- Sends a message to all clients. Supports
    	 	  RichText format.
    			
    		Arguments:
    		- filterstring: string
    			The content. This will be filtered
    			using TextService.
    			
    		- data: string
    			Header. E.g. "[System]", that will be
    			prepended to filterstring
	
	Server Scripts:
		UChat_Server
		
			- contains the server part and:
				- enforcement of roblox content policy;
				  ie kick players from countries that
				  do not allow for user-inputted text
				  
				- management of UChatUpdate;
				  handles filtering, and firing to all
				  clients.
				  
				- Chat Bubbles
	
	Client Scripts:
		UChat_ServerHandler
		
			- handles output from server and:
				- adds it to the buffer
				
				- displays it
			
			- creates an OK token, _G.UChatServerOK
			  which allows for the Input Handler not
			  to blow itself up
			  
		UChat_InputHandler
		
			- handles user input from the TextBox and:
				
				- hands it to server
			
			** CONFIG:
				- _G.UChatBufferSize: number
					
					- number of messages (in items) of
					  buffer to store.
				
	GUIs:
		UChatGui (ServerStorage)
		
			- is the chat bubble basically
		
		UChatGui (StarterGui)
		
			- has:
				
				- TextBox input
				
				- ScrollableFrame for output to not
				  be wrapped
				  
				- Output TextBox
				
]]
