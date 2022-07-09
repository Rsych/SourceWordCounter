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
            HStack(alignment: .top) {
                VStack {
                    TextEditor(text: $originalText)
                        .background(.ultraThickMaterial)
                        .frame(maxWidth: .infinity)
                        .onChange(of: originalText) {
                            wordCount = countWords($0)
                        }
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: 150)
                }
                .padding()
                VStack {
                    Rectangle()
                        .foregroundColor(.gray)
                    Rectangle()
                        .frame(height: 150)
                        .foregroundColor(.gray)
                }
                .frame(width: 150)
                .padding()
                
            }
            .frame(minWidth: getRect().width / 1.7, idealWidth: getRect().width / 1.6, maxWidth: getRect().width, minHeight: getRect().height / 1.7 , idealHeight: getRect().height / 1.5, maxHeight: getRect().height, alignment: .leading)
            .padding([.top, .trailing])
            
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
