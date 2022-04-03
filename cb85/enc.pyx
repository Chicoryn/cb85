cdef unsigned char *ENCODE_B85 = [
    b'0', b'1', b'2', b'3', b'4', b'5', b'6', b'7', b'8', b'9',
    b'A', b'B', b'C', b'D', b'E', b'F', b'G', b'H', b'I', b'J',
    b'K', b'L', b'M', b'N', b'O', b'P', b'Q', b'R', b'S', b'T',
    b'U', b'V', b'W', b'X', b'Y', b'Z',
    b'a', b'b', b'c', b'd', b'e', b'f', b'g', b'h', b'i', b'j',
    b'k', b'l', b'm', b'n', b'o', b'p', b'q', b'r', b's', b't',
    b'u', b'v', b'w', b'x', b'y', b'z',
    b'!', b'#', b'$', b'%', b'&', b'(', b')', b'*', b'+', b'-',
    b';', b'<', b'=', b'>', b'?', b'@', b'^', b'_',	b'`', b'{',
    b'|', b'}', b'~'
]

cpdef bytes b85encode(bytes x):
    cdef int sz = len(x)
    cdef int padding = (-sz) % 4
    cdef bytearray out = bytearray(5 * (sz + padding) // 4)
    cdef unsigned int acc
    cdef int j = 0
    cdef int i

    for i in range(0, len(x), 4):
        acc = (x[i+0] << 24) \
            | ((x[i+1] if i+1 < sz else 0) << 16) \
            | ((x[i+2] if i+2 < sz else 0) << 8) \
            | (x[i+3] if i+3 < sz else 0);

        out[j+0] = ENCODE_B85[acc // 52200625]
        out[j+1] = ENCODE_B85[(acc // 614125) % 85]
        out[j+2] = ENCODE_B85[(acc // 7225) % 85]
        out[j+3] = ENCODE_B85[(acc // 85) % 85]
        out[j+4] = ENCODE_B85[acc % 85]
        j += 5

    return bytes(out)
