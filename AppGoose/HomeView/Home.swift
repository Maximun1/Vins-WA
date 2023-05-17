//
//  ContentView.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/9/23.
// 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

import SwiftUI

struct HomeView: View {
    let persistenceController = PersistenceController.shared
    @State var titles: [String] = ["QR Scanner", "Favorites", "Help", "Companies", "Settings", "About"]
    @State var icons: [String] = ["qrcode", "star.fill", "questionmark.square.fill", "building.2.fill", "gearshape.fill", "info.square.fill"]
    @State var views: [AnyView] = [AnyView(QRScannerView()), AnyView(FavoritesView()), AnyView(HelpView()), AnyView(CompaniesView()), AnyView(SettingsView()), AnyView(AboutView())]
    @State var presentView: Bool = false
    @StateObject var indexGr = IndexGrabber()
    var body: some View {
        NavigationStack {
            ZStack {
                Colors(colors: .yellow.opacity(0.8))
                homeViewContent
            }
        }.fullScreenCover(isPresented: $presentView) {
            views[indexGr.index]
                .environmentObject(indexGr)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
    @ViewBuilder
    var homeViewContent: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Text("Home")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0..<3) { i in
                        HStack {
                            RectangleViews(title: "\(titles[i])", icon: icons[i], description: "", presentView: $presentView, index: i)
                                .frame(width: geo.size.width/2, height: 100)
                                .environmentObject(indexGr)
                            RectangleViews(title: "\(titles[i+3])", icon: icons[i+3], description: "", presentView: $presentView, index: i+3)
                                .frame(width: geo.size.width/2, height: 100)
                                .environmentObject(indexGr)
                        }.padding(.top)
                    }
                    .foregroundColor(.white)
                }
            }
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
