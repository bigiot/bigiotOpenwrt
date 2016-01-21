-----------------------------------------------------------------------------
-- Openwrt与贝壳物联平台通讯示例
-- http://www.bigiot.net/help/5.html
-- Author: 贝壳物联
-- Time: 2016/1/10
-----------------------------------------------------------------------------
local socket = require("socket")--引入Luasocket
local json = require("json")--引入Json4lua
local util = require "luci.util"--引入luci,调用cup负载
------------此处需修改-------------
DEVICEID = "2" --设备ID
APIKEY = "2353d24ce" --设备APIKEY
INPUTID = "2" --数据接口ID
-----------------------------------
host = host or "www.bigiot.net"
port = port or 8181
lastTime = 0
lastUpdateTime = 0
if arg then
	host = arg[1] or host
	port = arg[2] or port
end
print("Attempting connection to host '" ..host.. "' and port " ..port.. "...")
c = assert(socket.connect(host, port))
c:settimeout(0)
print("Connected! Please type stuff (empty line to stop):")
while true do
	if ((os.time() - lastTime) > 40) then
		print( os.time() )
		s = json.encode({M='checkin',ID=DEVICEID,K=APIKEY})
		assert(c:send( s.."\n" ))
		lastTime=os.time()
	end
	if ((os.time() - lastUpdateTime) > 5) then
	    local sysinfo = luci.util.ubus("system", "info") or { }
	    local load = sysinfo.load or { 0, 0, 0 } --获取Openwrt系统负载
	    local v = {[INPUTID]=load[1]} --多个接口数据可用v = {[INPUTID1]=load[1],[INPUTID2]=load[2]}
	    local update = json.encode({['M']='update', ['ID']=DEVICEID, ['V']=v})
	    assert(c:send( update.."\n" ))
	    lastUpdateTime = os.time()
	end
	recvt, sendt, status = socket.select({c}, nil, 1)
	--#获取table长度，即元素数
	while #recvt > 0 do
		local response, receive_status = c:receive()
		if receive_status ~= "closed" then
			if response then
				print(response)
				r = json.decode(response)
				table.foreach(r, print)
				if r.client_list then
				    table.foreach(r.client_list, print)
				end
				recvt, sendt, status = socket.select({c}, nil, 1)
			end
		else
			break
		end
	end
end
