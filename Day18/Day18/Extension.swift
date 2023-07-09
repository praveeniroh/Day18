//
//  Extension.swift
//  Day18
//
//  Created by Praveenraj T on 08/07/23.
//

import Foundation
import SwiftUI

public extension View{
    func navigationLinkPicker()->some View{
        if #available(iOS 16, *){
            return pickerStyle(.navigationLink)
        }else{
            return self
        }
    }
    
    func immediateScrollDismissesKeyboard()-> some View{
        if #available(iOS 16, *){
            return scrollDismissesKeyboard(.immediately)
        }else{
            return self
        }
    }
}
