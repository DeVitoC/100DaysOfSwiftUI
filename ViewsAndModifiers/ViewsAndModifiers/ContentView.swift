//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Christopher DeVito on 3/1/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Hello, world") {
            print(type(of: self.body))
        }
        .background(.red)
        .frame(width: 200, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
