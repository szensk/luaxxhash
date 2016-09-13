local xxh32 = require("luaxxhash")

local f = io.open("sherlock.txt")
local text = f:read("*all")
local str = "Cats are interesting."
local str1 = "a"
local strt = { 
	str1:rep(4),
 	str1:rep(16),
 	str1:rep(32),
 	str1:rep(32) .. str1 .. str1:rep(4),
	str:rep(256),
	"",
	"dupa",
	str,
	str1,
	text
}

local answer = {
	-631806169,
 	1571609996,
	-1557966914,
	1065833563,
	-237286296,
	46947589,
	0x1A47C09D,
	1710037756,
	1426945110,
	-88756490
}

for i=1, #strt do
	local x = xxh32(strt[i])
	assert(x == answer[i], "Hash produces incorrect values: " .. i .. " Hash: " .. x)
end

local testIndex   = 10
local testRepeat  = 10
local hashRepeat  = 1000

function test(f)
	local times       = {}
	local throughputs = {}

	for i=1,testRepeat do
		local start = os.clock()
		for i=1,hashRepeat do f(strt[testIndex]) end
		local time = os.clock() - start
		local throughput = #strt[testIndex]*hashRepeat/time/(1024*1024)
		table.insert(times, time)
		table.insert(throughputs, throughput)
	end

	print( ("min: %.3fs %.2f MB/s"):format( math.min(table.unpack(times)), math.min(table.unpack(throughputs))) )
	print( ("max: %.3fs %.2f MB/s"):format( math.max(table.unpack(times)), math.max(table.unpack(throughputs))) )
end

test(xxh32)
local ok, murmur = pcall(require, 'murmurhash3')
if ok then test(murmur) end
