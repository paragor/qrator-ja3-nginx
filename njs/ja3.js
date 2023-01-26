const crypto = require('crypto')

const JA3_HEADER_NAME = "X-Qrator-Cl-Ssl-Params"
const GREASE_TABLE = {
    "0a0a": true, "1a1a": true, "2a2a": true, "3a3a": true,
    "4a4a": true, "5a5a": true, "6a6a": true, "7a7a": true,
    "8a8a": true, "9a9a": true, "aaaa": true, "baba": true,
    "caca": true, "dada": true, "eaea": true, "fafa": true
}

function hex2decimal(hex) {
    let result = parseInt(hex, 16).toString()
    if (result === "NaN") {
        throw new Error("hex2decimal return Nan for value: '" + hex + "'")
    }
    return result
}

function transform_segment(segment) {
    if (segment === "") {
        return ""
    }
    let hex_chunks = segment.split(":")
    let dec_chunks = []

    for (let i in hex_chunks) {
        let hex = hex_chunks[i]
        if (GREASE_TABLE[hex]) {
            continue
        }
        dec_chunks.push(hex2decimal(hex))
    }
    return dec_chunks.join("-")
}

function ja3_curator2sailforce(curator_str) {
    let segments = curator_str.split(",")
    if (segments.length !== 5) {
        throw new Error("ja3 should have 5 segments")
    }
    if (segments[0].length !== 4) {
        throw new Error("ja3 first segment should have 4 digest, but value: " + segments[0])
    }
    let result = []
    for (let i in segments) {
        result.push(transform_segment(segments[i]))
    }

    return result.join(",")
}


function ja3_njs(r, is_digest) {
    let header = r.headersIn[JA3_HEADER_NAME]
    if (!header) {
        return ""
    }
    let ja3_long = ja3_curator2sailforce(header)
    if (!is_digest) {
        return ja3_long
    }
    return crypto.createHash("md5").update(ja3_long).digest("hex")
}

function ja3_njs_digest(r) {
    return ja3_njs(r, true)
}

function ja3_njs_str(r) {
    return ja3_njs(r, false)
}

export default {ja3_curator2sailforce, ja3_njs_digest, ja3_njs_str}

// let _str = "0304,6a6a:1301:1302:1303:c02c:c02b:cca9:c030:c02f:cca8:c00a:c009:c014:c013,0000:0017:ff01:000a:000b:0010:0005:000d:0012:0033:002d:002b:001b:0015,dada:001d:0017:0018:0019,"
// console.log(ja3_curator2sailforce(_str))
