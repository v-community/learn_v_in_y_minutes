// single-line comments start with a //

/*
    multi-line comments start with a /*    
    and they can be nested */
*/

/*
    V's basic data types include:
        bool                            - true/false
        string                          - 'hello' *utf-8 encoded*
        i8 i16 int i64 i128[WIP]        - signed integers of 8, 16, 32, 64, and 128 bits
        byte u16 u32 u64 u128[WIP]      - unsigned integers of 8, 16, 32, 64, and 128 bits
        f32 f64                         - floating point numbers of 32 and 64 bits
        rune                            - unicode code point (unicode equivalent of an ascii char)
        byteptr
        voidptr    

        Note from the Developer: Unlike C and Go, int is always 32 bits
*/

// packages from the standard library and any packages installed through vpm 
// are loaded at the start of a program
import math // don't worry about this for now
    
// program constants are defined at the module level (External to any functions) and are denoted by the 'const' structure
const (
    hello = 'hello'
    world = 'world'
    age_of_world = 42
)

/* 
    PascalCase is the preferred typing method for constants
    const's are more lenient and flexible than in other languages
    To promote the lack of global variables, complex data types can be created in the consts structure
*/

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

/* 
    There can be multiple constant declarations throughout source code; 
    although it is recommended to declare as many as possible in the same area 
*/
const (
    streets = ['1234 Alpha Avenue', '9876 Test Lane'] 
    address = Address {street : streets[0], city: 'Beta', state : 'Gamma', zip : 31416}
    address2 = Address {street : streets[1], city: 'Exam', state : 'Quiz', zip : 62832}
)


/*
    Function declarations follow many other languages' form:    
        fn function_name(param_list) return_type_list {
            function_body
        }
*/

// You can declare parameters individually
fn test_address(street string, city string, state string, zip int) Address {
    return Address{street : street, city : city, state : state, zip : zip}
}

// or they can be grouped by type
fn test_address2(street, city, state string, zip int) Address {
    return Address{street : street, city : city, state : state, zip : zip}
}
    
const (
    address3 = test_address('2718 Tau Dr', 'Turing', 'Leibniz', 54366)
    address4 = test_address2('3142 Uat Rd', 'Einstein', 'Maxwell', 62840)
)

/*
    Structs have special functions called methods. 
    They are like any regular function with the addition of having a special receiver argument.    
    Conventionally, the parameter name for the receiver should be short (typically a single letter)
*/

fn (a Address) str() string {
    return 'Address.str(): $a.street, $a.city, $a.state $a.zip'
}

struct Point {
    x_coor int
    y_coor int
}

fn test_out_of_order_calls() {
    // unlike most languages, variables can only be defined in a function scope
    point := Point{x_coor : 2, y_coor : 2}
    
    // Variables are immutable by default
    mut point1 := Point{}
    
    // := is used for initialization, = is an assignment
    point1 = Point{x_coor : 1, y_coor : 1}    
    
    x_diff, y_diff, distance := point.dist(point1)
    
    // A function can be used before their declaration to alleviate the need for header files
    println('difference in:\nx_coors = $x_diff, y_coors = $y_diff\nthe distance between them is ${distance:.2f}')
}

fn (p Point) dist(p2 Point) (f64, f64, f64)  {  
    // you can perform type conversion with the T(v) form
    // the following is int => f64 using the form f64(int)
    x_diff_immutable := f64(p2.x_coor - p.x_coor)    
    
    // x_diff_immutable = 2 would cause a compile error (test it, I'll wait ;] )    
    mut y_diff_mutable := f64(p2.y_coor - p.y_coor)
    
    // as you've realized now, the mut keyword denotes that a variable should be mutable    
    mut distance := math.pow(x_diff_immutable, 2)    
    y_diff_mutable = math.pow(y_diff_mutable, 2)   
    
    // that allows us to assign a new value to a variable after it's initialized
    distance = distance + y_diff_mutable    
    distance = math.sqrt(distance)
    
    // you could obviously do : distance = math.sqrt(distance + y_diff_mutable)
    return x_diff_immutable, y_diff_mutable, distance
}

fn string_example() {
    // a char is denoted by a set of backticks ( ` )  (on many PCs this is the key under escape)
    a_char := `a`
    
    // you've seen examples, but interpolated strings are readily available 
    println('The ascii value of this char is: $a_char')
    
    // basic values can be interpolated directly,
    // more advanced interpolations require ${to_be_interpolated}
    println('The char is: ${a_char.str()}')
    
    // if you prefer, concatenation is always available
    mut concat := 'b' + a_char.str() + 'dnews be' + a_char.str() + 'rs'
    print(concat)
    
    // use += to append to a string
    concat += '_appended'
    println(', $concat')
}

fn arrays_example() {
    // arrays are collections of a SINGLE data type
    mut fruits := ['apple', 'banana', 'cherry']
    
    // the data type is determined by the type of the first element that it contains
    println(fruits)
    
    // use << to append to the end 
    fruits << 'kiwi'
    println(fruits)
    
    // arrays can be pre-allocated
    ben_10 := ['ben'].repeat(10)
    
    // use .len to get the number of elements in an array
    // use array_name[desired_index] to get the element at a specific index (indices start at 0)
    println('There are ${ben_10.len} occurrences of ${ben_10[0]} in \n'+ben_10.str())
}

fn maps_example() {
    // maps function like dictionaries from many other languages
    mut my_dict := map[string]f64 // Currently, they only accept strings as keys
    my_dict['pi'] = 3.14
    my_dict['tau'] = 6.28 // but any type can be used as a value
    my_dict['e'] = 2.72    
    
    // if you know some/all of the key-value pairs, this alternative initialization form may come in hand
    // alt_dict := {'a' : 1.1, 'b' : 2.2, 'c' : 3.3}
    // println(alt_dict.str())
    
    println(my_dict.str())
}

/*
    Conditionals are extremely useful when needing to check values or the state of your program.
    The standard if-else suite functions like many other languages:
    if some_condition {
        statements to perform when some_condition is true
    }
    else if some_other_condition {
        statements to execute when some_condition is false
        and some_other_condition is true
    }
    else {
        statements to perform if neither condition is valid
    }
*/
fn conditional_example() {
    a := 15
    b := 35  
    
    // parentheses around the condition can be useful for longer expressions
    if (b == 2*a) {
        println('b ($b) is twice the value of a ($a)')
    }  
    else if a > b { // however they are not required
        println('a ($a) is greater than b ($b)')
    }      
    else { // the curly braces are though
        println('a ($a) is less than or equal to b ($b)')
    }
    
    // if-else suites can be used as an expression and the result stored in a variable
    mult_of_3 := if a % 3 == 0 {
        'a ($a) is a multiple of 3'
    }
    else {
        'a ($a) is NOT a multiple of 3'
    }    
    println(mult_of_3)    
    
    c := `c` // cchange this to see other results
    mut x := ''    
    
    // a shorthand to if c == `a` is v's match statement
    // it is similar to many other languages' switch statement
    match c {
        `a` {
            println('${c.str()} is for Apple')
            x += 'Apple'
        }
        `b` {
            println('${c.str()} is for Banana')
            x += 'Banana'
        }
        `c` {
            println('${c.str()} is for Cherry')
            x += 'Cherry'   
        }
        else {
            println('NOPE')
        }
    }
    println(x)
}

/*
    The in operator is used to check if an element is a member in an array or map
*/
fn in_example() {
    arr := [1,2,3,5]
    
    // for arrays, 'in' checks if a specified element is a value stored in it
    x := if 4 in arr {
            'There was a 4 in the array'
        }
        else {
            'There was not a 4 in the array'
        }
    println(x)
    
    m := {'ford' : 'mustang', 'chevrolet' : 'camaro', 'dodge' : 'challenger'}
    
    // for maps, 'in' checks if a specified element is a key of the map
    y := if 'chevrolet' in m {
            'The chevrolet in the list is a '+m['chevrolet']
        }
        else {
            'There were no chevrolets in the list :('
        }
    println(y)
}

fn (m map[string]f64 ) str() string {
    mut result := ''
    // V has no while loop, for loops have several forms that can be utilized
    
    mut count := 0
    num_keys := m.size
    println('Number of keys in the map $num_keys')
    
    // the basic for loop will run indefinitely
    for {
        count += 2            
        println(num_keys.str())
        
        if count == num_keys - 1 {
            // until it reaches a break statement...or the comp runs out of resources :]
            break 
        }
        else if (count == 6){
            // continue statements skip to the next iteration of the loop
            continue
        }   
        
        result += 'Count is $count'            
    }
    
    // the more standard for loop is available as well    
    for i := 1; i <= 10; i++ {
        if i % 2 == 0 {
            println('i ($i) is even')
        }
    }
    
    // the for...in... acts like the foreach of most languages
    for val in [1,2,3] {
        result += '$val '
    }
    
    result += '\n'
    
    // the for key, val in... is a specialized version of the 'foreach' loop
    for key, val in m {
        result += 'key: $key -> value: $val '
    }
    
    // the last one is very handy for maps or when the index in arrays is needed
    
    return result
}

/*
    Defer statements permit you to declare code that will run after the surrounding code has finished
*/
fn defer_example() {
    mut a := f64(3)
    mut b := f64(4)
    
    // anything within this block won't run until the code after it has completed
    defer {
        c := math.sqrt(a+b)
        println('The hypotenuse of the triangle is $c')
    }
    
    // this should be executed before the statements above
    a = math.pow(a, 2)
    b = math.pow(b, 2)
    print('square of the length of side A is $a')
    println(', square of the length of side B is $b')
}

struct DivisionResult {
    result f64
}

/*
    Option Type is the standard error handling mechanism in v
    They are denoted with a ? on the return type
*/
fn divide(a, b f64) ?DivisionResult {
    if (b != 0) {
        return DivisionResult {result : a/b }
    }
    return error('Can\'t divide by zero!')
}

fn error_handling_example() {
    x := f64(10.0)
    y := f64(0)
    z := f64(2.5)
    
    fail := divide(x, y) or {
        // err is a special value for the 'or' clause that corresponds to the text in the error statement
        println(err)
        return 
        
        // or blocks must end with a return, break, or continue statements.
        // the last two (break and continue) must be in a for loop of some kind
    }
    
    /*
    // comment the fail block and uncomment this block if you want to see the division succeed
    succeed := divide(x, z) or {
        println(err)
        return
    }
    println(succeed.result)*/
}


/* 
    Single File programs can do without a main function as an entry point
    This is extremely useful for making cross-platform scripts
*/
println('$hello $world, you are $age_of_world days old.')
println(streets)
println('$address.street, $address.city, $address.state $address.zip')
println('$address2.street, $address2.city, $address2.state')
println(address3.str())
println(address4.str())
test_out_of_order_calls()
string_example()
arrays_example()
maps_example()
conditional_example()
in_example()
defer_example()
error_handling_example()
    
/* 
    fn main(){
        /* 
            You can uncomment the main function and
            Copy-paste the lines above it to test that they run the same
        */
    }
*/
