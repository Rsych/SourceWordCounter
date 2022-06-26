//
//  HomeView.swift
//  SourceWordCounter
//
//  Created by Ryan J. W. Kim on 2022/06/26.
//

import SwiftUI

enum CurrentTab: String, CaseIterable {
    case home = "house"
    case chart = "chart.bar.xaxis"
    case history = "doc.on.doc"
    case settings = "gear.badge.xmark"
}

struct HomeView: View {
    @State var currentTab: CurrentTab = .home
    
    @Namespace var animation
    
    let numOfCases = CurrentTab.allCases.count
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(CurrentTab.allCases, id: \.self) { tab in
                    MenuButton(image: tab.rawValue)
                    if tab == .history {
                        Spacer()
                    }
                }
            }
            .padding(.top, 60)
            .frame(width: 85)
            .frame(maxHeight: .infinity, alignment: .top)
            .background {
                ZStack {
                    Color.black
                        .padding(.trailing, 30)
                    Color.black
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.04), radius: 5, x: 5, y: 0)
                }
                .ignoresSafeArea()
            }
        }
        .frame(minWidth: getRect().width / 2, idealWidth: getRect().width / 1.75, maxWidth: getRect().width, minHeight: getRect().height / 2, idealHeight: getRect().height / 1.75, maxHeight: getRect().height, alignment: .leading)
        .background(.thinMaterial)
        .buttonStyle(.borderless)
    }
    @ViewBuilder
    func MenuButton(image: String) -> some View {
        Button {
            withAnimation(.interactiveSpring()) {
                self.currentTab = CurrentTab(rawValue: image) ?? .home
            }
            
            print(currentTab)
        } label: {
            Image(systemName: image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(currentTab.rawValue == image ? .white : .gray)
                .frame(width: 22, height: 22)
                .frame(width: 80, height: 50)
                .overlay(alignment: .trailing) {
                    HStack {
                        if currentTab.rawValue == image {
                            Capsule()
                                .fill(.white)
                                .matchedGeometryEffect(id: "tab", in: animation)
                                .frame(width: 2, height: 40)
                        }
                    }
                }
                .contentShape(Rectangle())
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        return NSScreen.main!.frame
    }
}
