import UIKit

//入れるお金
var inputedYen:Int = 200
//飲み物を選択　※Drink.water,Drink.coffee or Drink.energyDrinkで選択する
var wantedDrink:Drink? = nil

//飲み物の種類
enum Drink{
case water
case coffee
case energyDrink
}

//飲み物の値段
var drinkPrice = 0
//お釣り
var change = 0

//各飲み物の初期在庫数
var stockOfWater = 5
var stockOfCoffee = 5
var stockOfEnergyDrink = 5

//飲み物の在庫を減らす関数
func reduceStock () {
    switch wantedDrink {
    case .water:
        stockOfWater = stockOfWater - 1
    case .coffee:
        stockOfCoffee = stockOfCoffee - 1
    case .energyDrink:
        stockOfEnergyDrink = stockOfEnergyDrink - 1
    case .none: break
    }
}

//飲み物の在庫数を確認する関数
func checkStock() {
    print("waterの在庫は\(stockOfWater)個です")
    print("coffeeの在庫は\(stockOfCoffee)個です")
    print("energyDrinkの在庫は\(stockOfEnergyDrink)個です")
}

//飲み物を選択した時に、その値段を決める関数。選択しなければ選ぶよう出力する
switch wantedDrink {
case .water:
    drinkPrice = 100
case .coffee:
    drinkPrice = 150
case .energyDrink:
    drinkPrice = 200
case nil:
    print("飲み物を選んでね")
    checkStock()
    print("在庫変動はありません")
}

//お釣りを計算する関数
func calculatedChange () {
    change = inputedYen - drinkPrice
}

//入れたお金が0円以上かつ、飲み物を選択した場合、お釣りと飲み物を出力
if inputedYen >= 0 && wantedDrink != nil{
    calculatedChange()
//お釣りが0円以上であれば飲み物とお釣りを出し、お金が足りなければエラーメッセージを出力
    if change >= 0 {
        print(wantedDrink!)
        print("お釣りは\(change)です")
        reduceStock()
        checkStock()
    }else{
        print("お金が足りません")
        checkStock()
        print("在庫変動はありません")
    }
}
