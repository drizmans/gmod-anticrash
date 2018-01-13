net.Receive("aprint", function()
	local packet = util.JSONToTable(net.ReadString())
	chat.AddText(packet[1] or Color(50,255,255), packet[2], Color(255,255,255), packet[3])
end)
