//
//  HomeView.swift
//  SourceWordCounter
//
//  Created by Ryan J. W. Kim on 2022/06/26.
//

import SwiftUI

struct HomeView: View {
    @State var originalText = ""
    @State var wordCount: Int = 0
    
    let saveKey = "SavedData"

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(wordCount)")
            TextEditor(text: $originalText)
                .frame(height: 400)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom, .trailing])
                .onChange(of: originalText) {
                    wordCount = countWords($0)
                }
            Spacer()
            Button {
                originalText = ""
                UserDefaults.standard.removeTextFromKey()
            } label: {
                Text("Remove all")
            }

        }
        .onAppear {
           originalText = UserDefaults.standard.loadText()
        }
        .onDisappear {
            UserDefaults.standard.saveText(value: originalText)
        }
    }
    func countWords(_ string: String) -> Int {
        let components = string.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter{ !$0.isEmpty }
        return words.count
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
