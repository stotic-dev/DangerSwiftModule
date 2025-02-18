//
//  ContentView.swift
//  DangerSample
//
//  Created by 佐藤汰一 on 2025/02/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe").imageScale(.large).foregroundStyle(.tint).padding(.vertical, 20).frame(maxWidth: .infinity)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
