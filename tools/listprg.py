import sys
import struct
import argparse

class UnexpectedEndOfFileError(Exception):
    pass

class UnexpectedValueError(Exception):
    pass

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

SpecialChars = {
    29: '}',
    176: 'ą',
    187: 'ć',
    172: 'ę',
    182: 'ł',
    180: 'ń',
    161: 'ó',
    174: 'ś',
    165: 'ż',
    181: 'ź',
    171: 'Ą',
    178: 'Ć',
    177: 'Ę',
    162: 'Ł',
    183: 'Ń',
    162: 'Ó',
    179: 'Ś',
    163: 'Ż',
    184: 'Ź'
}

def list_one_line(f, outfile, length):
    global BASICTokens
    chunk = f.read(2)
    if len(chunk) != 2: raise UnexpectedEndOfFileError
    linenumber, = struct.unpack("<H",chunk)
    outfile.write("{} ".format(linenumber))
    cytat = None                                    # may be None, 34 or 0
    for i in range(length-3):
        chunk = f.read(1)
        if len(chunk) != 1: raise UnexpectedEndOfFileError
        if chunk[0] >= 32 and chunk[0] <= 64:
            outfile.write("{:c}".format(chunk[0]))
            if cytat is None and chunk[0] == 34: cytat = chunk[0]
            elif cytat is not None and chunk[0] == cytat: cytat = None
        elif chunk[0] >= 65 and chunk[0] <= 127:
            outfile.write("{:c}".format(chunk[0]+32))
        elif cytat is not None and chunk[0] in SpecialChars.keys():
            outfile.write(SpecialChars[chunk[0]])
        elif cytat is None and chunk[0] in BASICTokens.keys():
            outfile.write(BASICTokens[chunk[0]])
            if chunk[0] == 0x8F: cytat == 0                         # REM token
        elif chunk[0] >= 193 and chunk[0] <= 223:
            outfile.write("{:c}".format(chunk[0]-128))
        else:
            outfile.write("{}".format(chunk))
    chunk = f.read(1)
    if len(chunk) != 1: raise UnexpectedEndOfFileError
    if chunk[0] != 0: raise UnexpectedValueError
    outfile.write("\n")

def list_program(f, outfile):
    chunk = f.read(2)
    if len(chunk) != 2: raise UnexpectedEndOfFileError
    startaddr, = struct.unpack("<H",chunk)
    sys.stderr.write("load address: {}\n".format(startaddr))
    chunk = f.read(2)
    if len(chunk) != 2: raise UnexpectedEndOfFileError
    nextlineaddr, = struct.unpack("<H",chunk)
    while nextlineaddr != 0:
        list_one_line(f, outfile, nextlineaddr-startaddr-2)
        startaddr = nextlineaddr
        chunk = f.read(2)
        if len(chunk) != 2: raise UnexpectedEndOfFileError
        nextlineaddr, = struct.unpack("<H",chunk)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-o", "--outfile", help="output file name")
    parser.add_argument("infile", help="name of BASIC tokenized file")
    args = parser.parse_args()

    if args.outfile is None:
        outfile = sys.stdout
    else:
        outfile = open(args.outfile, "wt")

    with open(args.infile, "rb") as f:
        try:
            list_program(f, outfile)
            sys.stdout.flush
        except UnexpectedEndOfFileError:
            sys.stdout.flush
            sys.stderr.write("Unexpected end of file {}\n".format(args.infile))
        except UnexpectedValueError:
            sys.stdout.flush
            sys.stderr.write("Unexpected value in file {}\n".format(args.infile))

    sys.stderr.flush

