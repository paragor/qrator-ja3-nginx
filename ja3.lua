local function split(separator, str)
    local cur, result
    result = {}
    cur = 0
    if (#str == 1) then
        return { str }
    end
    while true do
        next = string.find(str, separator, cur, true)
        if next ~= nil then
            table.insert(result, string.sub(str, cur, next - 1))
            cur = next + 1
        else
            table.insert(result, string.sub(str, cur))
            break
        end
    end
    return result
end

local function hex_to_decimal(hex)
    if #hex ~= 4
    then
        error("hex value '" .. hex .. "' should have 4 letters but have " .. #hex)
    end
    return tostring(tonumber(hex, 16))
end

local grace_codes = {}
grace_codes["0a0a"] = true
grace_codes["1a1a"] = true
grace_codes["2a2a"] = true
grace_codes["3a3a"] = true
grace_codes["4a4a"] = true
grace_codes["5a5a"] = true
grace_codes["6a6a"] = true
grace_codes["7a7a"] = true
grace_codes["8a8a"] = true
grace_codes["9a9a"] = true
grace_codes["aaaa"] = true
grace_codes["baba"] = true
grace_codes["caca"] = true
grace_codes["dada"] = true
grace_codes["eaea"] = true
grace_codes["fafa"] = true


function ja3_concat_decimals(decimals_array)
    local count, result_str
    count = #decimals_array
    result_str = ""
    for k, cipher in pairs(decimals_array) do
        if cipher ~= "" and not grace_codes[cipher] then
            result_str = result_str .. hex_to_decimal(cipher)
            if k ~= count then
                result_str = result_str .. "-"
            end
        end
    end
    return result_str
end

function ja3_curator2sailforce(curator_str)
    local parts, result_str, ciphers

    parts = split(",", curator_str)
    if #parts ~= 5 then
        error("ja3 should have 5 parts")
    end

    if #parts[1] ~= 4 then
        error("ja3 first part should have 4 numbers")
    end

    result_str = hex_to_decimal(parts[1]) .. ","
    result_str = result_str .. ja3_concat_decimals(split(":", parts[2])) .. ","
    result_str = result_str .. ja3_concat_decimals(split(":", parts[3])) .. ","
    result_str = result_str .. ja3_concat_decimals(split(":", parts[4])) .. ","
    result_str = result_str .. ja3_concat_decimals(split(":", parts[5]))

    if have_changes then
        result_str = text:sub(1, -2)
    end

    return result_str
end

--_str = "0304,6a6a:1301:1302:1303:c02c:c02b:cca9:c030:c02f:cca8:c00a:c009:c014:c013,0000:0017:ff01:000a:000b:0010:0005:000d:0012:0033:002d:002b:001b:0015,dada:001d:0017:0018:0019,"
--print(ja3_curator2sailforce(_str))
