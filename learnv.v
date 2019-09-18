module main
// single-line comments start with a //

/*
    multi-line comments start with a /*
    
    and they can be nested */
*/

/*
V's basic data types include:
    bool                            - true/false
    string                          - 'hello'
    
    i8 i16 int i64 i128[WIP]        - signed integers of 8, 16, 32, 64, and 128 bits
    byte u16 u32 u64 u128[WIP]      - unsigned integers of 8, 16, 32, 64, and 128 bits

    f32 f64                         - floating point numbers of 32 and 64 bits
    
    rune                            - unicode code point (unicode equivalent of an ascii char)
    byteptr
    voidptr    
    
    Note from the Developer: Unlike C and Go, int is always 32 bits
*/

// program constants are defined at the module level (External to any functions) and are denoted by the 'const' structure
const (
    Hello = 'hello'
    World = 'world'
    AgeOfWorld = 42
)

// PascalCase is the preferred typing method for constants
// const's are more lenient and flexible than in other languages
// To promote the lack of global variables, complex data types can be created in the consts structure

/*
    structs, like in C, allow you define a group of different data-types together in a single, logical type
*/

struct Address {
    pub:
        street string
        city string
        state string
        zip int
}

const (
    Streets = ['1234 Alpha Avenue', '9876 Test Lane'] 
    TestAddress = Address {street : Streets[0], city: 'Beta', state : 'Gamma', zip : 31416}
    TestAddress2 = Address {street : Streets[1], city: 'Exam', state : 'Quiz', zip : 62832}
)

/* 
    There can be multiple constant declarations throughout source code; 
    although it is recommended to declare as many as possible in the same area 
*/
    
    

    
/* 
    Function declarations follow many other 

*/
    
println('$Hello $World, you are $AgeOfWorld days old.')

println(Streets)
println('$TestAddress.street, $TestAddress.city, $TestAddress.state $TestAddress.zip')
println('$TestAddress2.street, $TestAddress2.city, $TestAddress2.state')



