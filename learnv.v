import math
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
    more advanced features will be covered shortly
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
    Function declarations follow many other languages' form:
    
    fn function_name(param_list) return_type {
        function_body
    }
    
    A function can be used before their declaration to alleviate the need for header files
*/

//You can declare parameters individually
fn test_address(street string, city string, state string, zip int) Address {
    return Address{street : street, city : city, state : state, zip : zip}
}

// or they can be grouped by type
fn test_address2(street, city, state string, zip int) Address{
    return Address{street : street, city : city, state : state, zip : zip}
}
    
    
const (
    Address1 = test_address('2718 Tau Dr', 'Turing', 'Leibniz', 54366)
    Address2 = test_address2('3142 Uat Rd', 'Einstein', 'Maxwell', 62840)
)    

/*
    Structs have special functions called methods. They are like regular functions with the addition of having a special receiver argument.
    
    Conventionally, the parameter name for the receiver should be short (preferably single letter)
*/

fn (a Address) str() string {
    return 'Address.str(): $a.street, $a.city, $a.state $a.zip'
}


struct Point {
    x_coor int
    y_coor int
}

fn (p Point) dist(p1, p2 Point) string {
    // unlike most languages, variables can only be defined in a function scope
    x_diff_immutable := p2.x_coor - p1.x_coor
    // Variable are immutable by default
    // x_diff_immutable = 2 would cause a compile error (test it, I'll wait ;] )
    
    mut y_diff_mutable := p2.y_coor - p1.y_coor
    y_diff_mutable = 3 //should work fine
    // as you've realized now, the mut keyword denotes that a variable should be mutable
    
   // y_diff_mutable = math.pow(y_diff_mutable, 2)
    return '$x_diff_immutable, $y_diff_mutable'
}

println('$Hello $World, you are $AgeOfWorld days old.')

println(Streets)
println('$TestAddress.street, $TestAddress.city, $TestAddress.state $TestAddress.zip')
println('$TestAddress2.street, $TestAddress2.city, $TestAddress2.state')
println(Address1.str())
println(Address2.str())




