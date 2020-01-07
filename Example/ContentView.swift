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
            PostRequest().run(progress: { (p) in
                print(p)
            }, success: { (response) in
                print(response)
            }, failure: { (error) in
                print(error)
                if let responseData = error.rawResponse, let text = String(bytes: responseData, encoding: .utf8) {
                    print(text)
                }
            })
        }, label: { Text("Request") })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
