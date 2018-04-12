import sys
import struct
import argparse

class BasicSyntaxError(Exception):
    def __init__(self, line):
        self.line = line

BASICTokens = {
    0x80: "end",
    0x81: "for",
    0x82: "next",
    0x83: "data",
    0x84: "input#",
    0x85: "input",
    0x86: "dim",
    0x87: "read",
    0x88: "let",
    0x89: "goto",
    0x8A: "run",
    0x8B: "if",
    0x8C: "restore",
    0x8D: "gosub",
    0x8E: "return",
    0x8F: "rem",
    0x90: "stop",
    0x91: "on",
    0x92: "wait",

    0x93: "load",
    0x94: "save",
    0x95: "verify",
    0x96: "def",
    0x97: "poke",
    0x98: "print#",
    0x99: "print",
    0x9A: "cont",
    0x9B: "list",
    0x9C: "clr",
    0x9D: "cmd",
    0x9E: "sys",
    0x9F: "open",
    0xA0: "close",
    0xA1: "get",
    0xA2: "new",
    0xA3: "tab(",
    0xA4: "to",
    0xA5: "fn",

    0xA6: "spc(",
    0xA7: "then",
    0xA8: "not",
    0xA9: "step",
    0xAA: "+",
    0xAB: "-",
    0xAC: "*",
    0xAD: "/",
    0xAE: "^",
    0xAF: "and",
    0xB0: "or",
    0xB1: ">",
    0xB2: "=",
    0xB3: "<",
    0xB4: "sgn",
    0xB5: "int",
    0xB6: "abs",
    0xB7: "usr",
    0xB8: "fre",

    0xB9: "pos",
    0xBA: "sqr",
    0xBB: "rnd",
    0xBC: "log",
    0xBD: "exp",
    0xBE: "cos",
    0xBF: "sin",
    0xC0: "tan",
    0xC1: "atn",
    0xC2: "peek",
    0xC3: "len",
    0xC4: "str$",
    0xC5: "val",
    0xC6: "asc",
    0xC7: "chr$",
    0xC8: "left$",
    0xC9: "right$",
    0xCA: "mid$",
    0xCB: "go",

    0xCD: "up",
    0xCE: "pause",
    0xCF: "colour",
    0xD0: "hgr",
    0xD1: "cls",
    0xD2: "ink",
    0xD3: "nrm",
    0xD4: "plot",
    0xD5: "line",
    0xD6: "draw",
    0xD7: "shift",
    0xD8: "move",
    0xD9: "music",
    0xDA: "voice",
    0xDB: "volume",
    0xDC: "cli",
    0xDD: "shape",
    0xDE: "path",
    0xDF: "sei",
    0xE0: "basic",
    0xE1: "fill",
    0xE2: "text",
    0xE3: "sprite",
    0xE4: "scroll",
    0xE5: "play"
}

def find_token(line, sptr):
    global BASICTokens
    for token, verb in BASICTokens.items():
        tlen = len(verb)
        if len(line)-sptr >= tlen:
            if line[sptr:sptr+tlen] == verb:
                return token
    return None

def tokenize_one_line(line):
    global BASICTokens
    cytat = None                 # None = no, 34 = wait for ", 0 = wait for line end
    pcode = bytearray(88)        # original size of line buffer in C64
    sptr = 0                     # position in source
    dptr = 0                     # position in code

    llen = len(line)
    if line[llen-1] == '\n':
        llen -= 1
        line = line[:llen]
    if llen < 3: raise BasicSyntaxError(line)                                           # one digit and one space - so this line is empty
    if llen > 80: sys.stderr.write("suspicious line length: line:{}\n".format(line))    # only warning

    # parse line number
    linenumber = 0
    while sptr < llen and line[sptr] >= '0' and line[sptr] <= '9' and linenumber < 64000:
        linenumber *= 10
        linenumber += ord(line[sptr]) - 48
        sptr += 1
    if linenumber < 1 or linenumber >= 64000: raise BasicSyntaxError(line)      # wrong line number
    if line[sptr] != ' ': raise BasicSyntaxError(line)                          # must be at least 1 space after line number
    sptr += 1
    struct.pack_into("<H", pcode, dptr, linenumber)
    dptr += 2

    # parse BASIC text
    while sptr < llen:
        if not cytat is None:
            c = ord(line[sptr])
            if c == cytat: cytat = None
            elif c >= 97 and c <= 127: c -= 32
            elif c >= 65 and c <= 95: c += 128
            pcode[dptr] = c
            dptr += 1
            sptr += 1
        elif line[sptr] == ' ':
            pcode[dptr] = ord(line[sptr])
            dptr += 1
            sptr += 1
        elif line[sptr] == '"':
            cytat = 34                          # till " or end of line, no need to close
            pcode[dptr] = ord(line[sptr])
            dptr += 1
            sptr += 1
        elif line[sptr] == '?':                 # abreviation of PRINT token
            pcode[dptr] = 0x99
            dptr += 1
            sptr += 1
        elif line[sptr] == '\xff':              #pi character is a token of function PI
            pcode[dptr] = ord(line[sptr])
            dptr += 1
            sptr += 1
        elif line[sptr] >= '0' and line[sptr] <= ';':
            pcode[dptr] = ord(line[sptr])
            dptr += 1
            sptr += 1
        else:
            token = find_token(line, sptr)
            if token is None:
                c = ord(line[sptr])
                if c >= 97 and c <= 127: c -= 32
                elif c >= 65 and c <= 95: c += 128
                pcode[dptr] = c
                dptr += 1
                sptr += 1
            else:
                pcode[dptr] = token
                dptr += 1
                sptr += len(BASICTokens[token])
                if token == 0x8F: cytat = 0             # till end of line

        if dptr >= 80: raise BasicSyntaxError(line)     # pcode too long

    if len(pcode) < 3: raise BasicSyntaxError(line)
    pcode[dptr] = 0
    return pcode[0:dptr+1]

def tokenize_program(f, outfile):
    startaddr = 2049
    outfile.write(struct.pack("<H",startaddr))
    for line in f:
        if line != "\n":                                    # skip empty lines
            pcode = tokenize_one_line(line)
            startaddr += len(pcode)+2
            outfile.write(struct.pack("<H",startaddr))      # address of next line
            outfile.write(pcode)
    outfile.write(struct.pack("<H",0))                      # 0 means end of BASIC pcode

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-o", "--outfile", help="output file name")
    parser.add_argument("infile", help="name of BASIC source file")
    args = parser.parse_args()

    if args.outfile is None:
        outfile = sys.stdout
    else:
        outfile = open(args.outfile, "wb")

    with open(args.infile, "r", encoding="utf-8") as f:
        try:
            tokenize_program(f, outfile)
            sys.stdout.flush
        except BasicSyntaxError as e:
            sys.stdout.flush
            sys.stderr.write("Syntax error in line {}\n".format(e.line))

    sys.stderr.flush
