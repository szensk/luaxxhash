--luaxxhash.lua
local ffi = require('ffi')
local bit = require('bit')
local rol, band, bor, rshft, bxor, lshft = bit.rol, bit.band, bit.bor, bit.rshift, bit.bxor, bit.lshift

local u32t = ffi.typeof("uint32_t")
local P1 = (2654435761)
local P2 = (2246822519)
local P3 = (3266489917)
local P4 = (668265263)
local P5 = (374761393)
local U1 = u32t(2654435761)
local U2 = u32t(2246822519)

local function load_le32(x, i)
	
	return x[i] + lshft(x[i+1], 8) + lshft(x[i+2], 16) + lshft(x[i+3], 24)
end

local function mmul(x1, x2) --multiplication with modulo2 semantics
	return tonumber(ffi.cast('uint32_t', ffi.cast('uint32_t', x1) * ffi.cast('uint32_t', x2)))
end

local function fmmul(x1, x2) --uint32_t * uint32_t only
	return ffi.cast('uint32_t',  x1 * x2)
end

local function frol(x, n)
	return ffi.cast('uint32_t', rol(tonumber(x), n)) --cast isnt necessary
end

local function xxhash32(data, seed, len)
	seed = seed or 0
	len = len or #data
	local p = ffi.cast("uint8_t*", data) --data ptr
	local h32 = 0
	local i = 0 --ptr offset
	if len >= 16 then
		local limit = len - 16
		local v1 = u32t(seed + U1 + U2)
		local v2 = u32t(seed + U2)
		local v3 = u32t(seed)
		local v4 = u32t(seed - U1)
		while i <= limit do
			v1 = v1 + fmmul(load_le32(p, i), U2); v1 = frol(v1, 13); v1 = fmmul(v1, U1); i = i + 4
			v2 = v2 + fmmul(load_le32(p, i), U2); v2 = frol(v2, 13); v2 = fmmul(v2, U1); i = i + 4
			v3 = v3 + fmmul(load_le32(p, i), U2); v3 = frol(v3, 13); v3 = fmmul(v3, U1); i = i + 4
			v4 = v4 + fmmul(load_le32(p, i), U2); v4 = frol(v4, 13); v4 = fmmul(v4, U1); i = i + 4
		end --until i >= limit
		h32 = tonumber(frol(v1, 1) + frol(v2, 7) + frol(v3, 12) + frol(v4, 18))
	else
		h32 = seed + P5
	end
	h32 = h32 + len

	while i <= len - 4 do
		h32 = h32 + mmul(load_le32(p, i), P3)
		h32 = mmul(rol(h32, 17), P4)
		i = i + 4
	end

	while i < len do
		h32 = h32 + mmul(p[i], P5)
		h32 = mmul(rol(h32, 11), P1)
		i = i + 1
	end

	h32 = bxor(h32, rshft(h32, 15))
	h32 = mmul(h32, P2)
	h32 = bxor(h32, rshft(h32, 13))
	h32 = mmul(h32, P3)
	h32 = bxor(h32, rshft(h32, 16))
	return h32
end

return xxhash32
