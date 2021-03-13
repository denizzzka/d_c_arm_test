module martian;

/*
     ---a0---- ----b0---
    |\        |        /|
    | \       |       / |
    |  \      g0     /  |
    |   g1    |    a1   |
    f0   \    |    /    c0
    |     \   |   /     |
    |      ---|---      |
    |(f1)     |     (b1)|
    |      ---|---      |
    |     /   |   \     |
    |    /    |    \    |
    |   e1    |     c1  |
    |  /      d1     \  |
    | /       |       \ |
    |/        |        \|
     ---e0---- ----d0---
(p1)                     (p0)

p1 purpose depens on its position: it used as a clock delimiter, minus,
plus sections or as first left "period" dot
*/

enum IELFont : ushort {
// (Little endian)

// Cyrillic:
//          cat0     cat1
//        pabcdefg pabcdefg
//        |||||||| ||||||||
    А = 0b01110010_01110111,
    Б = 0b01101110_00010111,
    В = 0b01101110_01010111,
    Г = 0b01100010_00000000,
    Д = 0b10111101_10000100,
    Е = 0b01101110_00000111,
    Ё = Е,
    Ж = 0b00000001_01011101,
    З = 0b01101100_01010000,
    И = 0b00010010_01000100,
    Й = 0b01010010_01000100,
    К = 0b00000010_01010111,
    Л = 0b00110001_00000100,
    М = 0b00010010_01000001,
    Н = 0b00010010_01110111,
    О = 0b01111110_00000000,
//          cat0     cat1
//        pabcdefg pabcdefg
//        |||||||| ||||||||
    П = 0b01110010_00000000,
    Р = 0b01100010_01000111,
    С = 0b01101110_00000000,
    Т = 0b01100001_00001000,
    У = 0b00011100_00110001,
    Ф = 0b01100001_01001001,
    Х = 0b00000000_01010101,
    Ц = 0b10011110_00000000,
    Ч = 0b00010000_01110001,
    Ш = 0b00011111_00001000,
    Щ = 0b10011111_00001000,
    Ъ = 0b01001001_00011000,
    Ы = 0b00011110_00010111,
    Ь = 0b00001110_00010111,
    Э = 0b01111100_01110000,
    Ю = 0b00111011_00001111,
    Я = 0b01110000_01110101,

//           cat0     cat1
//         pabcdefg pabcdefg
//         |||||||| ||||||||
    _0 = 0b01111110_00000000,
    _1 = 0b01001101_00001000,
    _2 = 0b01101100_01000100,
    _3 = 0b01101100_01010000,
    _4 = 0b00000000_01110001,
    _5 = 0b01101100_00010001,
    _6 = 0b01101100_00010111,
    _7 = 0b01100000_01000100,
    _8 = 0b01101100_01010101,
    _9 = 0b01101100_01110001,

    decimal = 0b10000000_00000000,
    space = 0b0,
    dash = 0b00000000_00100010,
}
