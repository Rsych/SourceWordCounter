//
//  HomeView.swift
//  SourceWordCounter
//
//  Created by Ryan J. W. Kim on 2022/06/26.
//

import SwiftUI
import Foundation

struct HomeView: View {
    @State var originalText = ""
    @State var wordCount: Int = 0
    
    let saveKey = "SavedData"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(wordCount)")
            HStack(alignment: .top) {
                textInputField
                VStack {
                    sideTopMenu
                    sideBottomMenu
                }  //: SideMenu + SaveMenu VStack
                .frame(width: 150)
                .padding()
            }
            .frame(minWidth: getRect().width / 1.8, idealWidth: getRect().width / 1.8, maxWidth: getRect().width, minHeight: getRect().height / 1.7 , idealHeight: getRect().height / 1.5, maxHeight: getRect().height, alignment: .leading)
            .padding([.top, .trailing])
            
            Spacer()

            Button {
                removeTextField()
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

    func removeTextField() {
        originalText = ""
        UserDefaults.standard.removeTextFromKey()
    }

    func pasteText() -> String? {
        let pasteBoard = NSPasteboard.general
        if let read = pasteBoard.string(forType: .string) {
            return read
        }
        return nil
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    private var textInputField: some View {
        VStack {
            TextEditor(text: $originalText)
                .background(.ultraThickMaterial)
                .frame(maxWidth: .infinity)
                .onChange(of: originalText) {
                    wordCount = countWords($0)
                }
            bottomMenu
        }
        .padding()
    }
    // MARK: - SideTop Menu
    private var sideTopMenu: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
            VStack {
                Text("Side Setting Menu 1")
                Button {
                    originalText.append(pasteText() ?? "")
                } label: {
                    Label {
                        Text("Paste")
                    } icon: {
                        Image(systemName: "doc.on.clipboard")
                    }
                }
            }
        }
    } //: sideTopMenu
    // MARK: - SideBottom Menu
    private var sideBottomMenu: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
            Text("Save")
        }
        .frame(height: 150)
    }

    // MARK: - Bottom Menu
    private var bottomMenu: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
            Text("Bottom Setting Menu 2")
        }
        .frame(height: 150)
    }
}
