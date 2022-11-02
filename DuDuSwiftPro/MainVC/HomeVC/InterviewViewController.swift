//
//  InterviewViewController.swift
//  DuDuSwiftPro
//
//  Created by Fangjl_Pro on 5/24/22.
//

import UIKit

class InterviewViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var nickName : String?
   
    let titleArr = ["Swift关键字","swift和OC比较","Swift中的常量和OC中的常量有啥区别?"]
    let detailInfoArr = [
        ["\ndefer:\ndefer中的代码将延迟至当前作用域结束之前执行\n注意：必须有执行到defer，才会触发defer。如果提前return、抛异常或通过判断过滤了导致没有走defer这一行，就不会触发。","\nAny：用于表示任意类型的实例，包括函数类型。","\nAnyObject 可以代表任何 class 类型的实例。"," \noverride：指明子类会提供自定义实现，覆盖父类的实例方法、类型方法、实例属性、类型属性、下标。如果没有实现，则会直接继承自父类。","\n?和!，Swift语言中对一种可选类型（ Optional) 操作的语法糖。\n一句话：确定有值直接使用!，不确定有值使用？\n?: 先判断在拆包的语法糖。Swift中是可以声明一个没有初始值的属性，类型后加加一个 ? 操作符完成的\n!：表示强解包，不管有没有值直接拆包。如果没有值往往会崩溃crash，所有使用的时候一定要确定有值。","\nas：类型转换运算符，用于尝试将值转成其它类型。 as、as!、as?三种","\nis：类型检查运算符，用于确定实例是否为某个子类类型。","\n_：用于匹配或省略任意值的通配符。","\ninout：将一个值传入函数，并可以被函数修改，然后将值传回到调用处，来替换初始值。适用于引用类型和值类型。 其实就是声明参数为指针","\ndo：用于表示处理错误代码段的开始。","\n final：防止方法、属性、下标被重写。","\n get：返回成员的值。还可以用在计算型属性上，间接获取其它属性的值。","\ndefault：用于涵盖在 switch 语句中，所有未明确列出的枚举成员。","\n optional：用于指明协议中的可选方法。遵守该协议的实体类可以不实现这个方法。","\n #if：条件编译控制语句，用于控制程序在不同条件下编译代码。通过判断条件，决定是否执行代码。","\n #elseif：条件编译控制语句，用于控制程序在不同条件下执行代码。与 #if 语句结合使用。当条件为 true，执行对应代码。","\n #endif：条件编译控制语句，用于控制程序在不同条件下执行代码。用于表明条件编译代码的结尾。","\n willSet：属性观察者，在值存储到属性之前调用。","\n didSet：属性观察者，当值存储到属性后马上调用。","\ndeinit: 当一个类的实例即将被销毁时，会调用这个方法。","\nrequired：确保编译器会检查该类的所有子类，全部实现了指定的构造器方法。**\nrequired关键字\n对于某些我们希望子类中一定实现的designated初始化方法，我们可以通过添加required关键字进行限制，强制子类对这个方法重写。\nrequired修饰符的使用规则:\nrequired修饰符只能用于修饰类初始化方法。\n当子类含有异于父类的初始化方法时（初始化方法参数类型和数量异于父类），子类必须要实现父类的required初始化方法，并且也要使用required修饰符而不是override。\n当子类没有初始化方法时，可以不用实现父类的required初始化方法。","\nnil：在 Swift 中表示任意类型的无状态值。\nSwift的nil和OC中的nil不一样.在OC中,nil是一个指向不存在对象的指针。\n而在Swift中,nil不是指针,它是一个不确定的值。用来表示值缺失.任何类型的optional都可以被设置为nil.。而在OC中,基本数据类型和结构体是不能被设置为nil的. 给optional的常量或者变量赋值为nil.来表示他们的值缺失情况.一个optional常量或者变量如果在初始化的时候没有被赋值,他们自动会设置成nil.","\nguard：当有一个以上的条件不满足要求时，将离开当前作用域。同时还提供解包可选类型的功能。\n1.guard关键字必须使用在函数中。\n2.guard关键字必须和else同时出现。\n3.guard关键字只有条件为false的时候才能走else语句 相反执行后边语句。","\nindirect:指明在枚举类型中，存在成员使用相同枚举类型的实例作为关联值的情况。","\nlazy:指明属性的初始值，直到第一次被使用时，才进行初始化。"],
        ["\n1.swift支持默认参数","\n2.swift容易阅读，语法和文件结构简易化。","\n3.swift更易于维护，文件分离后结构更清晰。","\n4.swift更加安全，它是类型安全的语言","\n5.swift代码更少，简洁的语法，可以省去大量冗余代码。","\n6.swift速度更快，运算性能更高。"],[]]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Swift 面试题总结"
        self.view.addSubview(self.tableview)
    }
    
    lazy var tableview : UITableView = {
        let tableview = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        return tableview
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailInfoArr[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleArr[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "interViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if !(cell != nil) {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = self.detailInfoArr[indexPath.section][indexPath.row]
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print(indexPath.row)
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.defertest1()
            }
            if indexPath.row == 4 {
                self.loadData()
            }
            if indexPath.row == 4 {
                self.strTest()
            }
            
            if indexPath.row == 5 {
                self.asTest()
            }
            
            if indexPath.row == 6 {
                self.isTest()
            }
            if indexPath.row == 7 {
                self.lineTest()
            }
            if indexPath.row == 8 {
                print(potentialError)
                dangerousOp(&potentialError)
                print(potentialError)
                //代码运行到这里，potentialError 不再是 nil，而是已经被初始化
            }
            if indexPath.row == 18 {
                age = 11
            }
            if indexPath.row == 20 {
                // 编译错误
                MySubClass(i: 123)
            }
            
            if indexPath.row == 21 {
                //任何 Swift 类型或实例可以为 nil
                var statelessPerson:Person? = nil
                var statelessPlace:MyClass? = nil
                var statelessInt:Int? = nil
                var statelessString:String? = nil
            }
            
            if indexPath.row == 22 {
                let x = indexPath.row
                guard x > 0 else {
                    // 变量不符合条件判断时，执行下面代码
                    print(x)
                    return
                }
            }
            
            if indexPath.row == 23 {
                let dinner = Entertainment.eventType("Dinner")
                let movie = Entertainment.eventType("Movie")
                let dateNight = Entertainment.twoEvents(dinner, movie)
            }
            if indexPath.row == 24 {
                let aPerson = Person("lala")
                aPerson.personalityTraits //当 personalityTraits 首次被访问时，数据库才开始工作
            }
        }
    }
    
    indirect enum Entertainment
    {
       case eventType(String)
       case oneEvent(Entertainment)
       case twoEvents(Entertainment, Entertainment)
    }
    
    class MyClass {
        var str:String
        required init(str:String) {
            self.str = str
        }
    }
          
    class MySubClass:MyClass{
        init(i:Int) {
            super.init(str:String(i))
        }
        
        required init(str: String) {
            fatalError("init(str:) has not been implemented")
        }
    }
           
    
    deinit{
        //从堆中释放，并释放的资源
    }
    
    //带属性监视器的普通属性
    var age:Int = 0 {
        //我们需要在age属性变化前做点什么
        willSet {
            print("Will set an new value \(newValue) to age")
        }
        //我们需要在age属性发生变后，更新一下nickName这个属性
        didSet {
            print("age filed changed form \(oldValue) to \(age)")
                if age < 10 {
                    nickName = "Little"
                }else{
                    nickName = "Big"
                }
        }
    }
    
    
    
    var potentialError:NSError?
    func dangerousOp(_ error:inout NSError?)
    {
        error = NSError(domain: "", code: 0, userInfo: ["":""])
    }

    
    func lineTest() {
        // 1，格式化数字字面量，提高数字字面量的可读性
        let paddedDouble = 123.000_001
        let oneMillion = 1_000_000
        print(paddedDouble,oneMillion)
        
        // 2，忽略元组的元素值。假设有的元素不须要使用，使用下划线将对应的元素进行忽略
        // 仅关心http404Error中第二个元素的值。所以第一个元素能够使用下划线进行忽略
        let http404Error = (404, "Not Found")
        let (_, errorMessage) = http404Error
        print(errorMessage,http404Error)
        
        // 3，忽略区间值
        let base = 3
        let power = 10
        var answer = 1
        for _ in 1...power {
            answer *= base
            print(answer,base)
        }
        
        // call the function.
        let ss = join("hello", "world", "-")
        print(ss)
    }
    
    // 4，忽略外部參数名
    //(1).忽略方法的默认外部參数名
    class Counter {
        var count: Int = 0
        func incrementBy(amount: Int, numberOfTimes: Int) {
            count += amount * numberOfTimes
        }
    }
    /* 在上面的代码中，方法incrementBy()中的numberOfTimes具有默认的外部
    參数名：numberOfTimes，假设不想使用外部參数名能够使用下划线进行
    忽略，代码能够写为（只是为了提高代码的可读性，一般不进行忽略)*/
    class Counter1 {
        var count: Int = 0
        func incrementBy(amount: Int, _ numberOfTimes: Int) {
            count += amount * numberOfTimes
        }
    }
    
    //(2).忽略具有默认值的參数的外部參数名
    //   假设不想使用默认外部參数名，能够进行例如以下改动：
    func join(_ s1: String, _ s2: String, _ joiner: String = " ") -> String {
        return s1 + joiner + s2
    }
    
    
    
    //is：类型检查运算符，用于确定实例是否为某个子类类型。
    func isTest() {
        class Person1 {}
        class Programmer : Person1 {}
        class Nurse : Person1 {}
        
        let people = [Programmer(), Nurse()]
        for aPerson in people
        {
            if aPerson is Programmer
            {
                print("This person is a dev")
            }
            else if aPerson is Nurse
            {
                print("This person is a nurse")
            }
        }
    }
    
    func asTest() {
        //①数值类型转换
        //示例1：
        let age = 28 as Int
        let money = 20 as CGFloat
        let cost = (50 / 2) as Double
        print(age,money,cost)
        
        //②从派生类转换为基类，向上转型：
        // 定义一个学生对象 tom
        var tom = Student("Tom");

        // 定义一个教师对象 kevin
        var kevin = Student("Kevin Jakson");
        // 先把学生对象向上转型为一般的人员对象
        let person1 = tom as Person
        let person2 = kevin as Person
        // 再调用通用的处理人员对象的showPersonName函数
        showPersonName(person1)//这个人的名字是: Tom
        showPersonName(person2)//这个人的名字是: Kevin Jakson
        //③switch 语句中进行模式匹配
        //通过switch语法检测对象的类型，根据对象类型进行处理
        
        switch person1 {
            case let person1 as Student:
                print("是Student类型，打印学生成绩单...")
            case let person1 as Teacher:
                print("是Teacher类型，打印老师工资单...")
            default: break
        }
        
        //as!的使用:
        //as!:向下转型（Downcasting）时使用。由于是强制类型转换，如果转换失败会报 runtime 运行错误。
        let person : Person = Teacher("Jimmy Lee")
        let jimmy = person as! Teacher
        
        //as?的使用:

        //as? : as? 和 as! 操作符的转换规则完全一样。但 as?如果转换不成功的时候便会返回一个nil 对象。成功的话返回可选类型值。由于 as? 在转换失败的时候也不会出现错误，所以对于如果能确保100%会成功的转换则可使用 as!，否则使用 as?

//        let a = 13 as! String
//        print(a)
        //会crash
        
        let a = 13 as? String
        print(a)
        //输出为nil
        
        
    }
    
    
    
    // 1，定义人员基类
    class Person {
        var name : String
        
        init(_ name: String){
            self.name = name
        }
        lazy var personalityTraits = {
            //昂贵的数据库开销
            return ["Nice", "Funny"]
        }()
    }
    
    
    // 2，定义学生类
    class Student : Person {
    }

    // 3，定义教师类
    class Teacher : Person {
    }
    
    // 处理人员对象的函数(或工厂模式处理操作等)
    func showPersonName(_ people : Person){
        let name = people.name
        print("这个人的名字是: \(name)")
    }
    
    func strTest() {
        //举例1
        // 定义一个string的可选类型str，显式赋值
        let str: String? = "Hello"
        if (str != nil){
            let message = "你好" + str!
            print(message)//因为已经给str赋值为hello，所以if判断条件成立，然后给name强解包，得到hello
        }

        //举例2
        // 定义一个string的可选类型str，但是没有显式赋值
        var str1: String?
//        let message = "你好" + str1!
//        print(message)//强解包程序会crash掉。所以在使用！强解包的时候一定要确定解包对象不为nil，否则会引起程序崩溃。

    }
    
    func defertest1() {
        var a = 0
        defer{
            a = 1
            print(a)
        }
        print(a)
        a = 2
        print(a)
    }
    
    // 请求数据
    func loadData(){//
        // 请求的url (实测: 返回结果为json)
        let url = URL(string: "http://www.weather.com.cn/data/sk/101010100.html")
//        let url = URL(string: "http://www.baidu.com")
        
        // guard判断url 是否为nil
        guard let u = url else {
            return
        }
        
        // 实例化request
        let request = URLRequest(url: u)
        
        // 发送请求
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // 错误判断
            if error != nil {
                print(error!)
                return
            }
            // 判断data 是否有值
            guard let d = data else{
                return
            }
            // 出现问题: 正常情况下, 将Json 反序列化为字典, 但是正常写了会报错
            // 报错内容: Call can throw, but it is not marked with 'try' and the error is not handled
            // 报错原因: 调用可能够抛出异常, 因为没有标记try, 也未作错误处理. 系统处理的一种方式而已.
            // 解决方法: 既然说了没有标记try, 那就标记即可.
//            let dict = JSONSerialization.jsonObject(with: d, options: [])
            
            // 解决方式一: 强行try (try!)
            // 存在问题: 当请求结果不是标准的json数据时, 会造成程序崩溃
            // 也就是说: url为天气的链接时, 就会正常使用; 而url为百度的链接时, 就会崩溃.
//            let dict = try! JSONSerialization.jsonObject(with: d, options: [])
            
            
            // 解决方式二: 可选try (try?)
            // 特点: 能反序列化成功, 就给你返回成功的值; 不能成功就给你返回nil
//            let dict = try? JSONSerialization.jsonObject(with: d, options: [])
            
            // 打印结果
//            print(dict)
            
            // 解决方式三: 默认try (try)
            // 注意: 一定要配合 do{}catch{} 使用
            do{
                let dict = try JSONSerialization.jsonObject(with: d, options: [])
                print(dict)
            }catch{
                // catch 中默认提供error信息, 当序列化不成功是, 返回error
                print(error)
            }
        }.resume()
    }

    
    func makeCoffee(coffeeName:String = "雀巢") -> String {
        return "制作了一杯\(coffeeName)咖啡"
    }
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
