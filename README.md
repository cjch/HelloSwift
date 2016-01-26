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
switch 不会自动贯穿，贯穿需使用**fallthrough**关键字。匹配时，多个值可以写在一行，也可以使用区间。针对tuple类型，可以使用 _ 匹配任意值，同时在case中还可以使用值绑定。

where语句可用于switch和if语句中判断额外的条件

**guard**和if类似，不同支持在于其必须有else分支，同时else分支必须退出guard出现的代码段

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


##枚举、结构体和类
枚举和结构体是值类型  
结构体有逐一成员初始化构造器，三者都可定义属性和方法  

下标脚本语法，使用subscript关键字
	
	subscript(index: Int) -> Int {
		get {
			// return a Int value
		}
		set {
			// use 'newValue'
		}
	}

###枚举
关联值，和union类似  
原始值 .rawValue。当枚举类型的原始值为字符串时，默认原始值为枚举成员的名称  
递归枚举类型

###属性  
存储属性  延迟存储属性(**lazy**，必须声明为变量)  
计算属性  必须定义为变量并提供一个getter，不提供setter为只读计算属性  
属性观察器  通过**willSet, didSet**方法为存储属性(不包括延迟属性)添加属性观察器  
全局变量和局部变量  全局变量是延迟计算(不标记lazy)  
类型属性  类似C中的静态变量或常量，使用static定义，class重写，必须指定默认值，线程安全，延迟计算  

###方法
实例方法  值类型的属性不能在其实例方法中修改，可添加**mutating**关键字，然后就可以在方法中改变属性值和self  
类型方法  使用**static**，用**class**重写  

###重写
重写属性，方法等需要添加**override**关键字，防止重写使用**final**关键字

###构造过程 Initialization
属性值初始化: 默认值，构造器  

默认构造器：结构体和类的所有存储属性都有默认值，同时没有自定义的构造器，则swift自动生成默认构造器: `ClassType()`；结构体还能自动获得一个逐一成员构造器

指定构造器 designated， 便利构造器 **convenience** init...  

####类的构造器代理规则  

- 指定构造器必须调用直接父类的指定构造器  
- 便利构造器必须调用同一类的其他构造器  
- 便利构造器必须最终以调用一个指定构造器结束  

也就是说：指定构造器总是向上代理，便利构造器总是横向代理。

####两段式构造过程
1. 每个存储型属性通过引入它们的类的构造器来设置初始值。
2. 当每一个存储型属性值被确定后，第二阶段开始，它给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性。

####构造器继承
构造器不会自动继承，但在为自己引入的属性提供默认值时，如果还满足如下任意条件时，则可以自动继承构造器：

1. 子类没有定义任何指定构造器，则自动继承所有父类的指定构造器
2. 子类提供了所有父类的指定构造器的实现(继承or自定义)，则继承所有父类的便利构造器

####可失败构造器init? or init!

枚举：带原始值的枚举类自带一个可失败构造器`init?(rawValue:)` 

值类型的可失败构造器，可在任一时刻出发构造失败，而类的可失败构造器只能在所有类属性初始化后且类的构造器代理完成后才能触发失败行为。可以用非可失败构造器重写可失败构造器

####必要构造器
**required** init... 表明所有该类的子类都必须实现该构造器

##引用计数
弱引用**weak**和无主引用**unowned**：生命周期中会变为nil的实例使用弱引用，否则使用无主引用

在循环引用中，存在两个属性值都必须有值，并且初始化后都不会为nil，这是需要一个无主属性，另一个为隐式可选类型

闭包引起的循环强引用：使用闭包捕获列表

```
var someClusure: Void -> String = {
	[unowned self, weak ovar = self.varible!] in 
	// closure body
}
```

##可空链式调用 optional chaining

##错误处理
**ErrorType**协议  
最好使用枚举定义一组相关的错误，在代码中使用**throws**抛出错误

	enum CustomError:ErrorType {
		case InvalidInput
		case OutofStack
	}
	throws CustomError.InvalidInput

throwing函数，将错误传递给调用该函数的代码。  
只有throwing函数能传递错误，其他函数内部抛出的错误只能在此函数内部处理  
在调用throwing函数的代码处，要么直接处理错误，要么继续传递错误

	func canThrowErrors() throws -> String

do-catch， try语句抛出错误，然后跳转到匹配的catch语句执行。如果没有匹配上任一catch，错误会继续传播到周围的作用域：要么是外围的do-catch，要么是一个throwing函数的内部

	do {
		try expression
	} catch pattern1 {
		//error handing
	} catch pattern2 where condition {
		//error handing
	} catch {
		//匹配其他所有的错误
	}

使用**try?**将错误转换成可选值

使用**try!**使错误失效，然后包含到断言中，将错误转换为运行时错误

####指定清理操作  
使用**defer**在代码执行到要离开当前代码段之前去执行一段语句，也就是说defer将代码的执行延迟到退出当前作用域之前。  
defer代码按照它们被指定的相反顺序执行。

```
func deferSent() {
	defer { print("defer 1") }
	defer { print("defer 2") } //该句先执行
}

deferSent()
// 执行结果:
// defer 2
// defer 1
```
##类型转换
使用 **is** 检查一个实例是否属于特定子类型  

向下转换 **as?** 或 **as！**。条件转换返回一个可选值，强制转换失败时会出发运行时错误。

**AnyObject**可以代表任何Class类型的实例  
**Any**表示任何类型，包括方法类型(function types)

##Extension
通过扩展添加额外的功能，或提供协议的实现

	extension SomeType: aProtocol, bProtocol {
		
	}

- 添加计算属性，但不能添加存储属性，也不可以向已有属性添加属性观测器

- 添加构造器，不能添加指定构造器和析构器

- 方法，可变实例方法；在结构体和枚举中修改self或其属性的方法必须标注为**mutating**。

- 下标subscrpt

- 嵌套类型

##协议 protocol

	protocol someProtocol: superProtocol {
		var readwriteVarible: Int { get set }
		var readonlyVarible: Int { get } //只读属性，但其遵循者中的该属性也可以是可写的
		static var classVarible: Int { get set } //用static或class关键字声明类属性
		
		func someInstanceMethod() -> Int
	 	static func someTypeMethod() -> Int
	 	mutating func Toggle()
	 	
	 	init(a: Int)
	 	init?(a: Int, str: String)
	}
	
	class SomeClass: SomeSuperClass, someProtocol, bProtocol {
		
		required init(a: Int) {
			//
		}
		required init?(a: Int, str: String) {
			//
		}
	}

####属性
规定协议的遵循者提供特定名称和类型的实例属性或类属性，不指定是否是存储型还是计算型属性，另外还需要指出读写属性

####方法
协议中的方法不写出方法体，不支持默认参数值

mutating方法：类实现时不写mutating关键字，结构体、枚举实现时则必须写mutating。

####构造器
和方法类似。在实现协议时，可以指定协议中的构造器为指定构造器或便利构造器，在这两种情况下，都必须在实现中标记 **required** 修饰符。  

如果子类重写父类的指定构造器，且该指定构造器遵循某个协议，那么该构造器的实现需要同时标记 **required** 和 **override**

在协议中定义可失败构造器。如果协议中定义了可失败构造器，则实现中必须添加同样的可失败构造器或非可失败构造器；如果协议中定义了非可失败构造器，则实现中必须添加同样的非可失败构造器或隐式解析的可失败构造器（**init!**）

####协议类型
协议可以当做类型使用

####代理

####协议扩展
* 在扩展中添加协议成员  
* 通过扩展补充协议声明：当一个类型已经实现了协议的所有要求，却没有声明为遵循该协议，可通过空的扩展补充协议声明（类型不会自动转换，必须显示声明）

	```
	protocol SomeProtocol {
		func someFunc() -> Int
	}
	// 添加协议成员
	extension SomeClass: SomeProtocol {
		func someFunc() -> Int {
			return 1
		}
	}
	//补充协议声明
	extension SomeClass: SomeProtocol {}
	```

* 扩展协议可以为遵循者提供方法或属性的实现；还可以提供协议的默认实现，如果遵循者提供了自己的实现，则遵循者自己的实现会被使用。

	```
	extension SomeProtocol {
		func someFunc() -> Int {
			return 1
		}
	}
	```

* 在扩展协议时，通过 **where** 指定一些限制，直邮满足这些限制的遵循者才能获得协议扩展提供的属性和方法。

####协议的类属性
协议可以继承，和类的继承相似

添加**class**关键字，限制协议只能适配到类类型

	protocol someClassProtocol: class, SomeSuperProtocol {
		// protocol body
	}

####协议合成
利用`protocol<aProtocol, bProtocol...>`对协议进行组合。协议合成不会生成新的协议类型，只是一个临时协议。

####协议的一致性
**is** 检查实例是否遵循某个协议

**as?** 返回可选值，实例遵循协议时，返回协议类型，否则返回nil；**as** 用于强制向下装换。

####可选协议
使用关键字**optional**，则类型自动变成可选的，比如方法 `(void) -> String` 变成 `((void) -> String)?`，方法调用使用可选链。  
可选协议只能在含有 **@obj** 前缀的协议中生效，**@obj**表示协议将暴露给OC代码。 
