//
//  ContentView.swift
//  Example
//
//  Created by Koji Murata on 2020/01/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                PostRequest().run(progress: { print($0) }, success: { print($0) }, failure: { print($0) } )
            }, label: { Text("Post") })

            Button(action: {
                DeleteRequest().run(progress: { print($0) }, success: { print($0) }, failure: { print($0) } )
            }, label: { Text("Delete") })

            Button(action: {
                GetRequest().run(progress: { print($0) }, success: { print($0) }, failure: { print($0) } )
            }, label: { Text("Get") })

            Button(action: {
                PatchRequest().run(progress: { print($0) }, success: { print($0) }, failure: { print($0) } )
            }, label: { Text("Patch") })

            Button(action: {
                PutRequest().run(progress: { print($0) }, success: { print($0) }, failure: { print($0) } )
            }, label: { Text("Put") })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
