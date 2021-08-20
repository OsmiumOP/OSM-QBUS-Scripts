## COMMAND SETUPS FOR CLEARING INGAME CHAT
If your server members are annoyed due to the large batch of CHAT MESSAGES on the left top of the screen, this is for you. Clear ingame chats with ease using simple commands.

### [DISCORD SERVER](https://discord.gg/jrNxkpVaJU)

### Command to Clear Chat for Individual Players. Ex. If you enter `/clearooc`, it will clear only your chat. - To be PASTED in any Client File. 
```
-- Paste this in any Client sided file 

RegisterCommand('clearooc', function(source, args)
    TriggerEvent('chat:clear')
end, false)
```

### Command to Clear Chat for ENTIRE SERVER. Ex. Admin sends `/clearallchat` thus wiping chat for everyone at once. 
```
-- Paste this in any Server Sided File

QBCore.Commands.Add("clearallchat", "Full Server Chat Clear", {}, false, function(source, args)
		
	TriggerClientEvent('chat:clear', -1)
	TriggerClientEvent('QBCore:Notify', source, "Cleared Server Chat", "error")
	
end, "admin")
```
