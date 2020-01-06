//
//  ContentView.swift
//  Example
//
//  Created by Koji Murata on 2020/01/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            HttpBinRequest().run()
        }, label: { Text("Request") })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
