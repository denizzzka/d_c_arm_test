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
//           cat1     cat0
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

}
