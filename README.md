# HelloSwift


代码分段

```
#pragma mark --> //MARK:
```
类型转换: float-->int: Int(3.14)  
类型别名：typealias Volume = Int  

普通变量在使用前必须初始化
可选类型包括可选类型(?)和隐式可选类型(!)

--
区间运算符：全闭区间 a...b, 左闭右开 a..<b  
空合运算符：??，对可选类型进行解析，如果可选类型值为nil，则返回默认值。a ?? b 相当于 a != nil ? a! : b  

字符串(String), 集合（Array, Set, Dcitionary）是值类型  

do-while --> repeat-while
switch 不会自动贯穿，贯穿需使用fallthrough关键字。匹配时，多个值可以写在一行，也可以使用区间。针对tuple类型，可以使用 _ 匹配任意值，同时在case中还可以使用值绑定。

where语句可用于switch和if语句中判断额外的条件

guard和if类似，不同支持在于其必须有else分支，同时else分支必须退出guard出现的代码段

函数参数默认为常量。若需要函数参数为变量，则添加var关键字，如果使函数参数为输入输出变量，需要使用inout关键字，调用时在参数前加&符号

闭包
--
闭包是引用类型。 闭包参数和返回值类型可隐式推断时，可省略；单表达式闭包隐式返回（可以不写return）；参数名称也可缩写，用$[0...]替换。  
尾随闭包：如果闭包是函数的最后一个参数时，则可将闭包写在函数之后，如果函数只有1个参数，还可省略（） 

``` (swift)
func tailClosure(closure: () -> Void )

// non trailing closure
tailClosure( {
// closure body
})

// trailing closure
tailClosure {
// closure body
}
``` 
非逃逸闭包: 函数参数使用@noescape修饰  
自动闭包：@autoclosure, 暗含@noescape特性，如果闭包可逃逸，则应使用@autoclosure(escaping)


枚举、结构体和类
-
枚举和结构体是值类型  
结构体有逐一成员初始化构造器，三者都可定义属性和方法

###枚举
关联值，和union类似  
原始值 .rawValue。当枚举类型的原始值为字符串时，默认原始值为枚举成员的名称  
递归枚举类型

###属性  
存储属性  延迟存储属性(lazy，必须声明为变量)  
计算属性  必须定义为变量并提供一个getter，不提供setter为只读计算属性  
属性观察器  通过willSet, didSet方法为存储属性(不包括延迟属性)添加属性观察器  
全局变量和局部变量  全局变量是延迟计算(不标记lazy)  
类型属性  类似C中的静态变量或常量，使用static定义，class重写，必须指定默认值，线程安全，延迟计算  

###方法
实例方法  值类型的属性不能在其实例方法中修改，可添加mutating关键字，然后就可以在方法中改变属性值和self  
类型方法  使用static，用class重写