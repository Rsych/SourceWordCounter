//
//  ContentView.swift
//  SourceWordCounter
//
//  Created by Ryan J. W. Kim on 2022/06/26.
//

import SwiftUI
import CoreData
enum CurrentTab: String, CaseIterable {
    case home = "house"
    case chart = "chart.bar.xaxis"
    case history = "doc.on.doc"
    case settings = "gear.badge.xmark"
}

struct ContentView: View {
    @State var currentTab: CurrentTab = .home
    
    @Namespace var animation
    
    let numOfCases = CurrentTab.allCases.count
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
        HStack(alignment: .top, spacing: 0) {
            sideMenu
            switch currentTab {
            case .home:
                HomeView()
            default:
                Color.red
            }
        }
        #if os(macOS)
        .frame(minWidth: getRect().width / 1.5, idealWidth: getRect().width / 1.4, maxWidth: getRect().width, minHeight: getRect().height / 1.5 , idealHeight: getRect().height / 1.4, maxHeight: getRect().height, alignment: .leading)
        #else
        .frame(alignment: .leading)
        #endif
        .background(.thinMaterial)
        .buttonStyle(.borderless)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension ContentView {
    private var sideMenu: some View {
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
            #if os(macOS)
            .ignoresSafeArea()
            #else
            .ignoresSafeArea(.all, edges: .bottom)
            #endif
        }
    }
}

extension View {
#if os(macOS)
    func getRect() -> CGRect {
        return NSScreen.main!.frame
    }
#endif
    
#if os(macOS)
    func getCurrentScreenRect() -> CGRect {
        return NSScreen.main!.visibleFrame
    }
#endif
}
