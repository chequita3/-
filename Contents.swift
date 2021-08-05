import UIKit

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
}

let calculate = calculateMoney()
//何円を何枚使用するか入力
let oneYenCalculate = calculate.MoneyCount(moneyType: .oneYen, count: 2)
let fiveYenCalculate = calculate.MoneyCount(moneyType: .fiveYen, count: 2)
let tenYenCalculate = calculate.MoneyCount(moneyType: .tenYen, count: 2)
let fiftyYenCalculate = calculate.MoneyCount(moneyType: .fiftyYen, count: 2)
let onehundredYenCalculate = calculate.MoneyCount(moneyType: .onehundredYen, count: 2)
let fivehundredYenCalculate = calculate.MoneyCount(moneyType: .fivehundredYen, count: 2)
let onethousandYenCalculate = calculate.MoneyCount(moneyType: .onethousandYen, count: 2)


protocol BuyDrinkValidatable {}
extension BuyDrinkValidatable {
    func validateDrinkBuyable(with drink: DrinkModel,
                              inputYen: Int) -> Bool {
        guard drink.stock > .zero else { return false }
        return drink.type.price < inputYen
    }
}

class VendingMachine: BuyDrinkValidatable {
    private var inputedYen: Int = 0
    private var coffee = DrinkModel(type: .coffee, stock: 5)
    private var water = DrinkModel(type: .water, stock: 5)
    private var energyDrink = DrinkModel(type: .energyDrink, stock: 5)
    
    var change: Int = 0
    
    //使用不可のお金が入力されているか判別
    func selectDisabledMoney() -> Bool {
        guard oneYenCalculate > 0 || fiveYenCalculate > 0 else {
            return false
        }
        return true
    }
    
//使用不可のお金は出力して、使用可能なお金はinputedYenとして代入する
    func checkInputedYen() {
        if selectDisabledMoney() {
            inputedYen = tenYenCalculate + fiftyYenCalculate + onehundredYenCalculate + fivehundredYenCalculate + onethousandYenCalculate
            print("1円と5円は使用できません。\(oneYenCalculate + fiveYenCalculate)円お返しします。")
        }else{
            inputedYen = tenYenCalculate + fiftyYenCalculate + onehundredYenCalculate + fivehundredYenCalculate + onethousandYenCalculate
        }
    }




    func buyDrink(type: DrinkType, inputedYen: Int) -> Bool {
        checkInputedYen()
        switch type {
        case .coffee:
            let isBuyable = validateDrinkBuyable(with: coffee, inputYen: inputedYen)
            if isBuyable {
                reduceStock(type: type)
            }
            return isBuyable
        case .water:
            let isBuyable = validateDrinkBuyable(with: water, inputYen: inputedYen)
            if isBuyable {
                reduceStock(type: type)
            }
            return isBuyable
        case .energyDrink:
            let isBuyable = validateDrinkBuyable(with: energyDrink, inputYen: inputedYen)
            if isBuyable {
                reduceStock(type: type)
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

//let activateVendingMachine = VendingMachine()
//let isSuccessToBuy = activateVendingMachine.buyDrink(type: .coffee, inputedYen: tenYenCalculate + fiftyYenCalculate + onehundredYenCalculate + fivehundredYenCalculate + onethousandYenCalculate)
//
//print(isSuccessToBuy)


































////何のお金を何枚入れる？
//var countOf1yen = 0
//var countOf5yen = 0
//var countOf10yen = 0
//var countOf50yen = 1
//var countOf100yen = 1
//var countOf500yen = 0
//var countOf1000yen = 0
////お金の種類
//func calculateMoney(moneyType:Int,count:Int) {
//
//
//
//}
//let moneyType:[String:Int] = ["1yen":1,"5yen":5,"10yen":10,"50yen":50,"100yen":100,"500yen":500,"1000yen":1000]
//
////飲み物を選択してください　※Drink.water,Drink.coffee or Drink.energyDrinkで選択する
//var wantedDrink:Drink? = Drink.water
//
////飲み物の種類
//enum Drink{
//    case water
//    case coffee
//    case energyDrink
//
//    var price: Int {
//        switch self {
//        case .coffee: return 150
//        case .water: return 100
//        case .energyDrink: return 200
//        }
//    }
//}
//
//
////各飲み物の初期在庫数
//var stockOfWater = 0
//var stockOfCoffee = 0
//var stockOfEnergyDrink = 0
//
////初期釣り銭
//var settingChange = 50
//
//
//
//
////使えるお金の種類をフィルター
//let usableMoneyType = moneyType.filter { key, value in
//    return value >= 10
//}
////使えないお金の種類をフィルター
//let disabledMoneyType = moneyType.filter { key, value in
//    return value < 10
//}
//
////使えないお金と使えるお金が入れられたかどうか判別
//var selectedUsableMoneyType = false
//var selectedDisabledMoney = false
//if countOf1yen > 0 || countOf5yen > 0 {
//    selectedDisabledMoney = true
//}else{
//    selectedDisabledMoney = false
//}
//if countOf10yen > 0 || countOf50yen > 0 || countOf100yen > 0 || countOf500yen > 0 || countOf1000yen > 0{
//    selectedUsableMoneyType = true
//}else{
//    selectedUsableMoneyType = false
//}
//
////それぞれのお金の合計を計算
//var totalOf1yen = moneyType["1yen"]! * countOf1yen
//var totalOf5yen = moneyType["5yen"]! * countOf5yen
//var totalOf10yen = moneyType["10yen"]! * countOf10yen
//var totalOf50yen = moneyType["50yen"]! * countOf50yen
//var totalOf100yen = moneyType["100yen"]! * countOf100yen
//var totalOf500yen = moneyType["500yen"]! * countOf500yen
//var totalOf1000yen = moneyType["1000yen"]! * countOf1000yen
//
//
//var totalMoney = 0
//var changeMoney = 0
//
////使えるお金だけ入れた場合と、両方入れられた場合、使えないお金だけの時の挙動
//if selectedUsableMoneyType == true && selectedDisabledMoney == false {
//    totalMoney = usableMoneyType["10yen"]! * countOf10yen + usableMoneyType["50yen"]! * countOf50yen + usableMoneyType["100yen"]! * countOf100yen + usableMoneyType["500yen"]! * countOf500yen + usableMoneyType["1000yen"]! * countOf1000yen
//}else if selectedUsableMoneyType == true && selectedDisabledMoney == true{
//    totalMoney = usableMoneyType["10yen"]! * countOf10yen + usableMoneyType["50yen"]! * countOf50yen + usableMoneyType["100yen"]! * countOf100yen + usableMoneyType["500yen"]! * countOf500yen + usableMoneyType["1000yen"]! * countOf1000yen
//    changeMoney = disabledMoneyType["1yen"]! * countOf1yen + disabledMoneyType["5yen"]! * countOf5yen
//    print("使用できないお金がありました\(changeMoney)円お返しします")
//}else if selectedUsableMoneyType == false && selectedDisabledMoney == true{
//    changeMoney = disabledMoneyType["1yen"]! * countOf1yen + disabledMoneyType["5yen"]! * countOf5yen
//    print("使用できないお金がありました\(changeMoney)円お返しします")
//}else{
//    print("お金入れてください")
//}
//
//
////飲み物の値段
//var drinkPrice = 0
////お釣り
//var change = 0
//
//
//
//var wantedDrinkStock = false
//
////飲み物の在庫を減らす関数
//func reduceStock () {
//    switch wantedDrink {
//    case .water:
//        if stockOfWater > 0 {
//            wantedDrinkStock = true
//            stockOfWater = stockOfWater - 1
//        }else{
//            wantedDrinkStock = false
//            print("\(Drink.water)の在庫がありません！")
//            print("\(totalMoney)円お返しします")
//        }
//    case .coffee:
//        if stockOfCoffee > 0{
//            wantedDrinkStock = true
//            stockOfCoffee = stockOfCoffee - 1
//        }else{
//            wantedDrinkStock = false
//            print("\(Drink.coffee)の在庫がありません！")
//            print("\(totalMoney)円お返しします")
//        }
//    case .energyDrink:
//        if stockOfEnergyDrink > 0 {
//            wantedDrinkStock = true
//            stockOfEnergyDrink = stockOfEnergyDrink - 1
//        }else{
//            wantedDrinkStock = false
//            print("\(Drink.energyDrink)の在庫がありません！")
//            print("\(totalMoney)円お返しします")
//        }
//    case .none: break
//    }
//}
//
////飲み物の在庫数を確認する関数
//func checkStock() {
//    print("waterの在庫は\(stockOfWater)個です")
//    print("coffeeの在庫は\(stockOfCoffee)個です")
//    print("energyDrinkの在庫は\(stockOfEnergyDrink)個です")
//}
//
////飲み物を選択した時に、その値段を決める関数。選択しなければ選ぶよう出力する
//switch wantedDrink {
//case .water:
//    drinkPrice = 100
//case .coffee:
//    drinkPrice = 150
//case .energyDrink:
//    drinkPrice = 200
//case nil:
//    print("飲み物を選んでね")
//    checkStock()
//    print("在庫変動はありません")
//}
//
////お釣りを計算する関数
//func calculatedChange () {
//    change = totalMoney - drinkPrice
//}
//
//var remaingChangeOK = false
//func checkChange () {
//    calculatedChange()
//    let remaingChange = settingChange - change
//    if remaingChange >= 0 {
//        remaingChangeOK = true
//    }else{
//        remaingChangeOK = false
//    }
//}
//
//checkChange()
//
////入れたお金が0円以上かつ、飲み物を選択した場合、お釣りと飲み物を出力
//if totalMoney >= 0 && wantedDrink != nil && wantedDrinkStock == true {
//    calculatedChange()
//    //お釣りが0円以上であれば飲み物とお釣りを出し、お金が足りなければエラーメッセージを出力
//    if change >= 0 && remaingChangeOK == true{
//        print("\(wantedDrink!)をどうぞ！")
//        print("お釣りは\(change)です")
//        reduceStock()
//        checkStock()
//    }else if change < 0 && remaingChangeOK == true{
//            print("お金が足りません")
//            checkStock()
//            print("在庫変動はありません")
//    }else if change >= 0 && remaingChangeOK == false{
//        print("すみません！釣り銭切れです！")
//        }
//    }else if wantedDrinkStock == false{
//    reduceStock()
//}
