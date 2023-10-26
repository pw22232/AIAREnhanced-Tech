//
//  ContentView.swift
//  AIAR
//
//  Created by 陈若鑫 on 24/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      ARViewRepresentable()
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
