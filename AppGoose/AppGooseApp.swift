//
//  AppGooseApp.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/9/23.
//

import SwiftUI
import CoreData
import CloudKit
import AppKit

extension Notification.Name {
    static let increaseWindowSize = Notification.Name("increaseWindowSize")
    static let decreaseWindowSize = Notification.Name("decreaseWindowSize")
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let contentView = HomeView()
        
        // Create a window and set its content view
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        
        // Set the minimum and maximum size restrictions for the window
        window.windowScene?.sizeRestrictions?.minimumSize = CGSize(width: 200, height: 200)
        window.windowScene?.sizeRestrictions?.maximumSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        // Create a new window
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        newWindow.rootViewController = UIHostingController(rootView: contentView)
        
        // Set the minimum and maximum size restrictions for the new window
        newWindow.windowScene?.sizeRestrictions?.minimumSize = CGSize(width: 200, height: 200)
        newWindow.windowScene?.sizeRestrictions?.maximumSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        // Show the windows
        window.makeKeyAndVisible()
        newWindow.makeKeyAndVisible()
        
        return true
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let contentView = HomeView()
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        
        windowScene.sizeRestrictions?.minimumSize = CGSize(width: 200, height: 200)
        windowScene.sizeRestrictions?.maximumSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        
        window.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(increaseWindowSize), name: .increaseWindowSize, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(decreaseWindowSize), name: .decreaseWindowSize, object: nil)
    }
    
    @objc private func increaseWindowSize() {
        resizeWindow(dx: 20, dy: 20)
    }
    
    @objc private func decreaseWindowSize() {
        resizeWindow(dx: -20, dy: -20)
    }
    
    private func resizeWindow(dx: CGFloat, dy: CGFloat) {
        guard let windowScene = window?.windowScene else { return }
        var newSize = windowScene.sizeRestrictions?.minimumSize ?? CGSize.zero
        newSize.width += dx
        newSize.height += dy
        windowScene.sizeRestrictions?.minimumSize = newSize
    }
}

@main
struct AppGooseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, self.managedObjectContext)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
