import UIKit

//ドリンクの種類と金額
enum DrinkType {
    case coffee
    case water
    case energyDrink
    
    var price: Int {
        switch self {
        case .coffee: return 150
        case .water: return 100
        case .energyDrink: return 200
        }
    }
}


struct DrinkModel {
    var type: DrinkType
    var stock: Int
}

struct calculateMoney {
    var inputedYen: Int = 0
    var change:Int = 0
    
    enum Money: Int {
        case oneYen = 1
        case fiveYen = 5
        case tenYen = 10
        case fiftyYen = 50
        case onehundredYen = 100
        case fivehundredYen = 500
        case onethousandYen = 1000
    }
    
    func MoneyCount(moneyType: Money,count: Int) -> Int {
        switch moneyType {
        case .oneYen:
            return Money.oneYen.rawValue * count
        case .fiveYen:
            return Money.fiveYen.rawValue * count
        case .tenYen:
            return Money.tenYen.rawValue * count
        case .fiftyYen:
            return Money.fiftyYen.rawValue * count
        case .onehundredYen:
            return Money.onehundredYen.rawValue * count
        case .fivehundredYen:
            return Money.fivehundredYen.rawValue * count
        case .onethousandYen:
            return Money.onethousandYen.rawValue * count
        }
        
    }
    //使用不可のお金が入力されているか判別
    func selectDisabledMoney() -> Bool {
        guard oneYenCalculate > 0 || fiveYenCalculate > 0 else {
            return false
        }
        return true
    }
    //使用不可のお金は出力して、使用可能なお金はinputedYenとして代入する
    mutating func checkInputedYen() {
        if selectDisabledMoney() {
            inputedYen = tenYenCalculate + fiftyYenCalculate + onehundredYenCalculate + fivehundredYenCalculate + onethousandYenCalculate
            print("1円と5円は使用できません。\(oneYenCalculate + fiveYenCalculate)円お返しします。")
        }else{
            inputedYen = tenYenCalculate + fiftyYenCalculate + onehundredYenCalculate + fivehundredYenCalculate + onethousandYenCalculate
        }
    }
    
    mutating func calculateChange(money: Int,price: Int) {
        change = money - price
    }
    
}
var calculate = calculateMoney()
//何円を何枚使用するか入力
let oneYenCalculate = calculate.MoneyCount(moneyType: .oneYen, count: 0)
let fiveYenCalculate = calculate.MoneyCount(moneyType: .fiveYen, count: 0)
let tenYenCalculate = calculate.MoneyCount(moneyType: .tenYen, count: 0)
let fiftyYenCalculate = calculate.MoneyCount(moneyType: .fiftyYen, count: 0)
let onehundredYenCalculate = calculate.MoneyCount(moneyType: .onehundredYen, count: 0)
let fivehundredYenCalculate = calculate.MoneyCount(moneyType: .fivehundredYen, count: 0)
let onethousandYenCalculate = calculate.MoneyCount(moneyType: .onethousandYen, count: 1)






protocol BuyDrinkValidatable {}
extension BuyDrinkValidatable {
    func validateDrinkBuyable(with drink: DrinkModel,inputYen: Int,change: Int) -> Bool {
        if drink.stock > .zero && drink.type.price <= inputYen && change >= 0 {
            return true
        }else{
            return false
        }
    }
}

class VendingMachine: BuyDrinkValidatable {
    
    
    
    var coffee = DrinkModel(type: .coffee, stock: 1)
    var water = DrinkModel(type: .water, stock: 5)
    var energyDrink = DrinkModel(type: .energyDrink, stock: 5)
    
    
    func buyDrink(type: DrinkType, inputedYen: Int) -> Bool {
        calculate.checkInputedYen()
        
        switch type {
        case .coffee:
            let isBuyable = validateDrinkBuyable(with: coffee, inputYen: calculate.inputedYen, change: calculate.change)
            if isBuyable {
                reduceStock(type: type)
                calculate.calculateChange(money: calculate.inputedYen, price: DrinkType.coffee.price)
                print("\(type)をどうぞ！\(calculate.change)円のお返しです！")
            }else if coffee.stock == .zero{
                print("すみません在庫切れです！\(calculate.inputedYen)円お返しします")
            }else{
                print("お金が足りません！\(calculate.inputedYen)円お返しします")
            }
            return isBuyable
            
        case .water:
            let isBuyable = validateDrinkBuyable(with: water, inputYen: inputedYen, change: calculate.change)
            if isBuyable {
                reduceStock(type: type)
                calculate.calculateChange(money: calculate.inputedYen, price: DrinkType.water.price)
                print("\(type)をどうぞ！\(calculate.change)円のお返しです！")
            }else if water.stock == .zero{
                print("すみません在庫切れです！\(calculate.inputedYen)円お返しします")
            }else{
                print("お金が足りません！\(calculate.inputedYen)円お返しします")
            }
            return isBuyable
        case .energyDrink:
            let isBuyable = validateDrinkBuyable(with: energyDrink, inputYen: inputedYen, change: calculate.change)
            if isBuyable {
                reduceStock(type: type)
                calculate.calculateChange(money: calculate.inputedYen, price: DrinkType.energyDrink.price)
                print("\(type)をどうぞ！\(calculate.change)円のお返しです！")
            }else if energyDrink.stock == .zero{
                print("すみません在庫切れです！\(calculate.inputedYen)円お返しします")
            }else{
                print("お金が足りません！\(calculate.inputedYen)円お返しします")
            }
            return isBuyable
        }
    }
    
    func reduceStock(type: DrinkType) {
        switch type {
        case .coffee: coffee.stock -= 1
        case .water: water.stock -= 1
        case .energyDrink: energyDrink.stock -= 1
        }
    }
}

let activateVendingMachine = VendingMachine()
activateVendingMachine.buyDrink(type: .coffee, inputedYen: calculate.inputedYen)


