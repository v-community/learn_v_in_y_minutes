/*
    Vの基本的なデータ型:
        bool                            - true/false
        string                          - 'hello' *utf-8 encoded*
        i8 i16 int i64 i128[WIP]        - signed integers of 8, 16, 32, 64, and 128 bits
        byte u16 u32 u64 u128[WIP]      - unsigned integers of 8, 16, 32, 64, and 128 bits
        f32 f64                         - floating point numbers of 32 and 64 bits
        rune                            - unicode code point (ascii charのUnicode版)
        byteptr
        voidptr    
       開発者メモ:CやGoとは異なり、intは常に32ビットです。
*/

// 標準ライブラリ並びにvpmを使用してインストールされたすべてのパッケージは、プログラムの開始時にロードされます。
import math // don't worry about this for now
    
/* 
プログラムの定数はモジュールレベル(関数の外)で、「const 」構造体として定義します。
	- 定数の型指定にはPascalCaseを使用することを勧めます。
	- constは他の言語よりも（寛大で）柔軟です。
	- グローバル変数に替え、const構造体に複雑なデータ型を作成することができます。
*/
const (
    hello = 'hello'
    world = 'world'
    age_of_world = 42
)


//Cと同じく、構造体により、異なるデータ型のグループを1つの論理型として定義できます。※pubにより公開public
struct Address {
    pub:
        street string
        city string
        state string
        zip int
}

// ソース・コード全体で複数の定数宣言が可能です。が、同じ領域でできるだけ多く宣言することをお勧めします。
const (
    streets = ['1234 Alpha Avenue', '9876 Test Lane'] 
    address = Address {street : streets[0], city: 'Beta', state : 'Gamma', zip : 31416}
    address2 = Address {street : streets[1], city: 'Exam', state : 'Quiz', zip : 62832}
)


/*
   関数宣言は、他言語の近しい形式に従います:    
        fn function_name(param_list) return_type_list {
            function_body
        }
*/

// パラメータを個別に宣言できます。
fn test_address(street string, city string, state string, zip int) Address {
    return Address{street : street, city : city, state : state, zip : zip}
}

// または、タイプ別にグループ化できます。
fn test_address2(street, city, state string, zip int) Address {
    return Address{street : street, city : city, state : state, zip : zip}
}
    
const (
    address3 = test_address('2718 Tau Dr', 'Turing', 'Leibniz', 54366)
    address4 = test_address2('3142 Uat Rd', 'Einstein', 'Maxwell', 62840)
)

/*
構造体は、Golangと同じく、メソッドと呼ばれる特殊な関数を持つことができます。
メソッドは通常の関数と同様ですが、（構造体を示す）特別なreceiver引数を持ちます。
receiver引数のパラメーター名は短くしましょう(通常は1文字、以下ではa)。
*/

fn (a Address) str() string {
    return 'Address.str(): $a.street, $a.city, $a.state $a.zip'
}

struct Point {
    x_coor int
    y_coor int
}

fn test_out_of_order_calls() {
    // 他の多くの言語とは異なり、変数は関数スコープでのみ定義できます。
    point := Point{x_coor : 2, y_coor : 2}
    
    // 変数はデフォルトで不変で、mutをつけると可変になります。
    mut point1 := Point{}
    
    // = は、代入
    point1 = Point{x_coor : 1, y_coor : 1}    
    // := は、変数を初期化
    x_diff, y_diff, distance := point.dist(point1)
    
    // 関数を宣言の前に使用できます（ヘッダファイルの必要性を軽減）。
    println('difference in:\nx_coors = $x_diff, y_coors = $y_diff\nthe distance between them is ${distance:.2f}')
}

fn (p Point) dist(p2 Point) (f64, f64, f64)  {  
    // T (v) の形式で型変換を実行できます。以下では、f64(int型)で、int=>f64の型変換
    x_diff_immutable := f64(p2.x_coor - p.x_coor)    
    
    // x_diff_immutable = 2 would cause a compile error (test it, I'll wait ;] )    
    mut y_diff_mutable := f64(p2.y_coor - p.y_coor)
    
    // mutキーワードは、変数が可変でなければならないことを示します。    
    mut distance := math.pow(x_diff_immutable, 2)    
    y_diff_mutable = math.pow(y_diff_mutable, 2)   
    
    // 可変な変数には、初期化後に、新しい値を代入することができます。
    distance = distance + y_diff_mutable    
    distance = math.sqrt(distance)
    
    // 当然ながら : distance = math.sqrt(distance + y_diff_mutable)
    return x_diff_immutable, y_diff_mutable, distance
}

fn string_example() {
    // cahr文字はバックティック( ` )で表されます
    a_char := `a`
    
    //既出の通りが、補間文字列(interpolated strings)が、ディフォルトで利用できます（変数のみの場合、直接補間:例 $x）。
    println('The ascii value of this char is: $a_char')
    
    // 高度な補間は、${$補完対象}の形式となります。
    println('The char is: ${a_char.str()}')
    
    // 必要に応じ、+による連結も使用できます。
    mut concat := 'b' + a_char.str() + 'dnews be' + a_char.str() + 'rs'
    print(concat)
    
    // use += 文字列への追加
    concat += '_appended'
    println(', $concat')
}

fn arrays_example() {
    // 配列は、単一のデータ型のコレクションです
    mut fruits := ['apple', 'banana', 'cherry']
    
    // データ型は、最初に含まれる要素の型によって決まります。
    println(fruits)
    
    //  << により、mutな配列の末尾に追加します。 
    fruits << 'kiwi'
    println(fruits)
    
    // 配列の領域は、事前に割り当て可能です。
    ben_10 := ['ben'].repeat(10)
    
    // 配列の長さは .len によって取得します。
    // 配列名[インデックス]の形式で、インデックス番目の要素を取得します(インデックスは0始まり)。
    println('There are ${ben_10.len} occurrences of ${ben_10[0]} in \n'+ben_10.str())
}

fn maps_example() {
    // mapは、他の多くの言語の辞書(pythonでいうdict)のように機能します。
    mut my_dict := map[string]f64 // 現時点の制限: 文字列のみをキーとして受け付けます。
    my_dict['pi'] = 3.14 // 値には、任意の型が使用できます。
    my_dict['tau'] = 6.28
    my_dict['e'] = 2.72    
        
    println(my_dict.str())

    println("alt_dictの例: キーと値のペアを、この代替初期化フォームで定義できます。")
    alt_dict := {'a' : 1.1, 'b' : 2.2, 'c' : 3.3}
    println(alt_dict.str())

}

/*
if-else条件は、値やプログラムの状態をチェックする必要がある場合に非常に便利です。Golangに似ています。:
    if some_condition {												// ※現バージョンでは、条件は括弧では囲みません。
      some_conditionが真である場合に実行される文　 // 文は、中括弧で囲います。
    }
    else if some_other_condition {
			some_conditionが偽かつsome_other_conditionが真である場合に実行される文
    }
    else {
      いずれの条件でもない場合に実行される文
    }
*/
fn conditional_example() {
    a := 15
    b := 35  
    
    
    if b == 2*a {
        println('b ($b) is twice the value of a ($a)')
    }  
    else if a > b { 
        println('a ($a) is greater than b ($b)')
    }      
    else { 
        println('a ($a) is less than or equal to b ($b)')
    }
    
    // if-else節は式として、評価結果を変数に格納できます。
    mult_of_3 := if a % 3 == 0 {
        'a ($a) is a multiple of 3'
    }
    else {
        'a ($a) is NOT a multiple of 3'
    }    
    println(mult_of_3)    
    
    c := `c` // cchange this to see other results
    mut x := ''    
    
    //if c===`a`の省略形として、match文があります（他の言語のswitch文に類似）。
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
    in演算子は、要素が配列またはmapのメンバであるかどうかをチェックするために使用します。
*/
fn in_example() {
    arr := [1,2,3,5]
    
    // 指定した要素(4)が、配列内の要素に存在するかどうかを調べます。
    x := if 4 in arr {
            'There was a 4 in the array'
        }
        else {
            'There was not a 4 in the array'
        }
    println(x)
    
    m := {'ford' : 'mustang', 'chevrolet' : 'camaro', 'dodge' : 'challenger'}
    
    // 指定した要素('chevrolet')が、map内の要素に存在するかどうかを調べます。
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
    // forループには、いくつかの形式が使用可能です　※V には、whileループはない。 
    
    mut count := 0
    num_keys := m.size
    println('Number of keys in the map $num_keys')
    
    // 形式１　forのみを記すと、無限ループとなります。
    for {
        count += 2            
        println(num_keys.str())
        
        if count == num_keys - 1 {
            // break文に到達するまず実行されます（またはcompがリソースを使い果たすまで:]）
            break 
        }
        else if count == 6{
            // continueステートメントはループの次へとスキップします。
            continue
        }   
        
        result += 'Count is $count'            
    }
    
    //形式２　標準的なforループ    
    for i := 1; i <= 10; i++ {
        if i % 2 == 0 {
            println('i ($i) is even')
        }
    }
    
    //形式３-１　（pythonと同様の）for...in...　※他言語のforeachのようにふるまいます
    for val in [1,2,3] {
        result += '$val '
    }
    
    result += '\n'
    
    //形式３-２　（pythonと同様の）for key, val in... ※foreachの特別版
    for key, val in m {
        result += 'key: $key -> value: $val '
    }
    
    // the last one is very handy for maps or when the index in arrays is needed
    
    return result
}

/*
    Defer文を使用して、周囲のコードが終了した後に実行されるコードを宣言できます。
*/
fn defer_example() {
    mut a := f64(3)
    mut b := f64(4)
    
    // このブロック内のすべてのものは、スコープ内のコードの実行が完了するまで実行されません。
    defer {
        c := math.sqrt(a+b)
        println('コードが完了したので最後に実行: The hypotenuse of the triangle is $c')
    }
    
    // これらは上記の文より前に実行されます。
    a = math.pow(a, 2)
    b = math.pow(b, 2)
    print('square of the length of side A is $a')
    println(', square of the length of side B is $b')
}

struct DivisionResult {
    result f64
}

/*
  戻りの型指定の前に?を付けるとOption型となります(vでの標準的なエラー処理の仕組み)
*/
fn divide(a, b f64) ?DivisionResult {
    if b != 0 {
        return DivisionResult {result : a/b }
    }
    return error('Can\'t divide by zero!')
}

fn error_handling_example() {
    x := f64(10.0)
    y := f64(0)
    z := f64(2.5)
    
    fail := divide(x, y) or {
				// 「or 」句において、エラー発生時の状況を特別値errはを介して取得できます:
        // (err is a special value for the 'or' clause that corresponds to the text in the error statement)
        println(err)
        return 
        
        // 「or 」句はreturn、break、または、continue文で終わる必要があります。
				//　　※break、continueはforループ内で、と中断、続行として使用
				
    }
    
    // succeedには成功時の値が入る
    succeed := divide(x, z) or {
        println(err)
        return
    }
    println(succeed.result)
}


/* 
シングルファイルプログラムは、mainなしで実行できます。
これは、クロスプラットフォームのスクリプトを作成する場合に非常に便利です。
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
*/
    
    fn main(){
        /* 
				main関数のコメントを解除し、
				上の行をコピー&ペーストして、同じ行が実行されることを確認できます。
        */
				defer_example()
				maps_example()
				error_handling_example()
    }
