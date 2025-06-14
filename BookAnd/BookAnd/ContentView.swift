//
//  ContentView.swift
//  BookAnd
//
//  Created by Delma Song on 6/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    BookSearchView()
                } label: {
                    Text("도서 검색하기")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
