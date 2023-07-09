//
//  WeSplistForm.swift
//  Day18
//
//  Created by Praveenraj T on 08/07/23.
//

import SwiftUI

struct WeSplistForm: View {
    
    @State private var amountEnterred:Double = 0.0
    @State private var peopleRowSelected:Int = 0
    @State private var tipPercentage = 10
    
    @FocusState private var isAmountFocused:Bool

    
    private let locale = Locale.current // Users's current locale

    private var currencyCode:String{
        locale.currencyCode ?? "USD"
    }
    
    var currencyFormatter = FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD")

    private var numberOfPeople:Int{
        return peopleRowSelected + 2
    }
    
    var tipAmount:Double{
        let tipPercentage = Double(tipPercentage)
        let tipAmount = amountEnterred * tipPercentage/100
        return tipAmount
    }
    
    var totalAmount:Double{
        amountEnterred + tipAmount
    }
    
    var amountPerPerson:Double{
        totalAmount / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        Text("Bill amount")
                        Spacer()
                        TextField("Enter Bill Amount", value: $amountEnterred,format: currencyFormatter)
                            .keyboardType(.decimalPad)
                            .focused($isAmountFocused)
                            .fixedSize()
                            .multilineTextAlignment(.trailing)
                    }
                    Picker("Number of People", selection: $peopleRowSelected, content: {
                        ForEach(2..<100, content: {
                            Text("\($0) people")
                        })
                    })
                    .navigationLinkPicker()
                }
                
                Section("Tip deatail", content: {
                    Picker("Tip percentage", selection: $tipPercentage, content: {
                        ForEach(0..<101, content: {
                            Text("\($0) %")
                        })
                    })
                    .navigationLinkPicker()
                    
                    HStack{
                        Text("Tip amount")
                        Spacer()
                        Text(convertToCurrency(for:tipAmount))
                    }
                })
                
                Section("Amount per Person"){
                    HStack{
                        Text("Share amount")
                        Spacer()
                        Text(convertToCurrency(for:amountPerPerson))
                    }
                }
                
                Section("Total amount"){
                    HStack{
                        Text("Bill amount")
                        Spacer()
                        Text(convertToCurrency(for: totalAmount))
                    }
                    HStack{
                        Text("Tip amount")
                        Spacer()
                        Text(convertToCurrency(for: tipAmount))
                    }
                    HStack{
                        Text("Total amount")
                        Spacer()
                        Text(convertToCurrency(for: totalAmount))
                    }
                    .font(.bold(Font.system(size: 20))())
                }
            }
            .navigationTitle("WeSplit")
            .toolbar(content: {
                ToolbarItemGroup(placement:.keyboard){
                    Spacer()
                    Button("Done"){
                        isAmountFocused = false
                    }
                }
            })
            .immediateScrollDismissesKeyboard()
        }
    }
    
    func convertToCurrency(for value:Double)->String{
        return currencyFormatter.format(value)
    }
}

struct WeSplitPreview:PreviewProvider{
    static var previews: some View{
        WeSplistForm()
    }
}
