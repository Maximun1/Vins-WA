//
//  SettingsVIew.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/10/23.
//

import SwiftUI
import CoreData
import ProgressHUD

struct CustomButton: View {
    let title: String
    let systemImage: String
    let darkMode: Bool
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: systemImage)
                    .foregroundColor(darkMode ? .white : .black)
                    .font(.system(size: 20))
                Text(title)
                    .foregroundColor(darkMode ? .white : .black)
                    .font(.system(size: 18))
            }
        }
    }
}

struct SettingsView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Settings.darkMode, ascending: true)],
        animation: .default)
    var settings: FetchedResults<Settings>
    @Environment(\.presentationMode) var presentationMode
    
    @State var darkMode: Bool = false {
        didSet {
            settings.first?.darkMode = darkMode
            saveContext("Dark Mode")
        }
    }
    
    @State var pushNotifications: Bool = false {
        didSet {
            settings.first?.pushNotifications = pushNotifications
            saveContext("Push Notifications")
        }
    }
    
    var currentSettings: Settings {
        settings.first ?? createDefaultSettings()
    }
    
    @State var termsOfService: Bool = false
    @State var privacyPolicy: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // MARK: BUG LATER
                        /*
                        Group {
                            Text("General")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(currentSettings.darkMode ? .white : .black)
                            
                            Toggle(isOn: Binding(get: {
                                currentSettings.darkMode
                            }, set: { newValue in
                                currentSettings.darkMode = newValue
                                saveContext("Dark Mode")
                            })) {
                                Text("Dark Mode")
                                    .font(.system(size: 18))
                                    .foregroundColor(currentSettings.darkMode ? .white : .black)
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Color.green))
                            
                            Divider()
                            
                            Toggle(isOn: Binding(get: {
                                currentSettings.pushNotifications
                            }, set: { newValue in
                                currentSettings.pushNotifications = newValue
                                saveContext("Push Notifications")
                            })) {
                                Text("Push Notifications")
                                    .font(.system(size: 18))
                                    .foregroundColor(currentSettings.darkMode ? .white : .black)
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Color.green))
                            
                            Divider()
                        }
                         */
                        // MARK: NO ACCOUNT, LATER WILL BE ADDED
                        /*
                        Group {
                            Text("Account")
                                .foregroundColor(currentSettings.darkMode ? .white : .black)
                                .font(.system(size: 24, weight: .bold))
                            
                            CustomButton(title: "Edit Profile", systemImage: "person.circle", darkMode: currentSettings.darkMode, action: {
                                
                            })
                            
                            Divider()
                            
                            CustomButton(title: "Change Password", systemImage: "lock", darkMode: currentSettings.darkMode, action: {
                                
                            })
                            
                            Divider()
                            
                            CustomButton(title: "Log Out", systemImage: "arrow.left.square", darkMode: currentSettings.darkMode, action: {
                                
                            })
                            
                            Divider()
                        }
                        */
                        Group {
                            Text("App")
                                .foregroundColor(currentSettings.darkMode ? .white : .black)
                                .font(.system(size: 24, weight: .bold))
                            
                            CustomButton(title: "Rate App", systemImage: "star.fill", darkMode: currentSettings.darkMode, action: {
                                
                            })
                            
                            Divider()
                            
                            CustomButton(title: "Share App", systemImage: "square.and.arrow.up", darkMode: currentSettings.darkMode, action: {
                                
                            })
                            
                            Divider()
                        }
                        
                        Group {
                            Text("Legal")
                                .foregroundColor(currentSettings.darkMode ? .white : .black)
                                .font(.system(size: 24, weight: .bold))
                            
                            CustomButton(title: "Terms of Service", systemImage: "doc.text", darkMode: currentSettings.darkMode, action: {
                                termsOfService.toggle()
                            })
                            
                            Divider()
                            
                            CustomButton(title: "Privacy Policy", systemImage: "shield", darkMode: currentSettings.darkMode, action: {
                                privacyPolicy.toggle()
                            })
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                }.background(Colors(colors: .yellow.opacity(currentSettings.darkMode ? 0.5 : 0.8)))
                    .colorScheme(currentSettings.darkMode ? .dark : .light)
                    .navigationBarTitle("Settings", displayMode: .inline)
                    .navigationBarItems(leading:
                                            Button(action: {
                        presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Home")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                )
            }
            .foregroundColor(currentSettings.darkMode ? .black : .white)
            .accentColor(currentSettings.darkMode ? .white : .black)
        }
        .fullScreenCover(isPresented: $termsOfService) {
            TermsOfServiceView()
        }.fullScreenCover(isPresented: $privacyPolicy) {
            PrivacyInformationView()
        }
    }
    
    private func createDefaultSettings() -> Settings {
        let newSettings = Settings(context: viewContext)
        newSettings.darkMode = true
        newSettings.pushNotifications = true
        DispatchQueue.main.async {
            saveContext("Dark Mode, Push Notifications")
        }
        
        return newSettings
    }
    
    func saveContext(_ item: String) {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
            ProgressHUD.showError("Error Saving Settings {\(item)|: \(error).")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
