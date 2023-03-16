#!/usr/bin/env python
'''Script to emulate the 192-bit password generation of Lockbit 3.0'''

__author__ = 'INCIBE-CERT'
__version__ = '1.0'

import sys

# Bit manupulation functions derived from the code at
# https://www.geeksforgeeks.org/rotate-bits-of-an-integer/

INT_BITS = 32

def left_rotate(n, d):
    '''Rotate left the value n d bits'''

    # In n<<d, last d bits are 0.
    # To put first 3 bits of n at
    # last, do bitwise or of n<<d
    # with n >>(INT_BITS - d)
    return ((n << d)|(n >> (INT_BITS - d))) & 0x00FFFFFFFF

def right_rotate(n, d):
    '''Rotate right the value n d bits'''

    # In n>>d, first d bits are 0.
    # To put last 3 bits of at
    # first, do bitwise or of n>>d
    # with n <<(INT_BITS - d)
    return (n >> d)|(n << (INT_BITS - d)) & 0x00FFFFFFFF

def negate(n):
    '''Negate the bits of value n'''
    return 0x00FFFFFFFF ^ n

def swap32(n):
    '''Perform a bit rotation of value n'''
    return (((n << 24) & 0xFF000000) |
            ((n <<  8) & 0x00FF0000) |
            ((n >>  8) & 0x0000FF00) |
            ((n >> 24) & 0x000000FF))


KEY = "db66023ab2abcb9957fb01ed50cdfa6a" if len(sys.argv) < 2 else sys.argv[1]

WORDS = [swap32(int(KEY[i:i+8], 16)) for i in range(0, 32, 8)]
FINAL = []

for N in range(6):
    DECRYPTED = []
    EAX = WORDS[0]
    EAX = swap32(EAX)
    EAX = right_rotate(EAX, 0x0d)
    EDX = negate(EAX)

    EAX = WORDS[1]
    EAX = left_rotate(EAX, 0xb)
    EAX = swap32(EAX)
    DECRYPTED.append(swap32(EAX ^ EDX))

    EAX = WORDS[2]
    EAX = left_rotate(EAX, 0x9)
    EAX = swap32(EAX)
    EDX = EAX
    EDX = negate(EDX)
    DECRYPTED.append(swap32(EAX))

    EAX = WORDS[3]
    EAX = left_rotate(EAX, 0x7)
    EAX = swap32(EAX)
    EAX = EAX ^ EDX
    EDX = negate(EAX)
    DECRYPTED.append(swap32(EAX))

    EAX = left_rotate(EAX, 0x5)
    EAX = EAX ^ EDX
    DECRYPTED.append(swap32(EAX))

    FINAL += DECRYPTED

    for i in range(4):
        WORDS[i] = swap32(DECRYPTED[i])


for w in FINAL:
    print("%08x" % w)
