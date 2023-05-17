//
//  CompaniesView.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/10/23.
//

import SwiftUI
import CoreData
import CloudKit
import ProgressHUD

struct CompaniesView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Companies.companyName, ascending: true)],
        animation: .default)
     var companies: FetchedResults<Companies>
    @Environment(\.presentationMode) var presentationMode
    
    @State var selectedCompany: Companies?
    @State var newCompanyName: String = ""
    @State var newCompanyEmail: String = ""
    @State var presentAddingCompanyAlert: Bool = false
    @State var presentDeleteCompanyAlert: Bool = false
    @State var presentEditCompanyAlert: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Colors(colors: .yellow.opacity(0.8))
                content
            }.onReceive(timer) { input in
                print(companies)
            }
        }
    }
    
    @ViewBuilder
    var content: some View {
        VStack {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(companies, id: \.uniqueID) { company in
                            CompanyRectangleViews(name: company.companyName ?? "", email: company.emailAddress ?? "")
                                .frame(width: geo.size.width, height: 100)
                                .overlay {
                                    buttons(company: company)
                                }
                        }
                    }
                }.navigationBarTitle("Companies", displayMode: .inline)
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
                    ).navigationBarItems(trailing:
                                            Button(action: {
                        withAnimation {
                            presentAddingCompanyAlert = true
                        }
                    }) {
                        Text("Add")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    )
            }.padding()
        }
        alerts
    }
    
    @ViewBuilder
    var alerts: some View {
        VStack {
            
        }.alert("Add Company", isPresented: $presentAddingCompanyAlert) {
            VStack {
                TextField("Company Name", text: $newCompanyName)
                    .padding()
                
                TextField("Company Email Address", text: $newCompanyEmail)
                    .padding()
                
                HStack {
                    Button("OK", role: .cancel) {
                        addCompany(name: newCompanyName, email: newCompanyEmail)
                        newCompanyName = ""
                        newCompanyEmail = ""
                        presentAddingCompanyAlert.toggle()
                    }
                    
                    Button("Cancel", role: .destructive) {
                        newCompanyName = ""
                        newCompanyEmail = ""
                        presentAddingCompanyAlert.toggle()
                    }
                }
                .padding()
            }
        } message: {
            Text("Please provide the following information to add a new company")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
        .alert("Edit Company", isPresented: $presentEditCompanyAlert) {
            VStack {
                TextField("New Name", text: $newCompanyName)
                    .padding()
                
                TextField("New Email", text: $newCompanyEmail)
                    .padding()
                
                HStack {
                    Button("Save", role: .cancel) {
                        if let company = selectedCompany {
                            editCompany(company, name: newCompanyName, email: newCompanyEmail)
                            newCompanyName = ""
                            newCompanyEmail = ""
                        }
                        presentEditCompanyAlert = false
                    }
                    
                    Button("Cancel", role: .destructive) {
                        presentEditCompanyAlert = false
                    }
                }
                .padding()
            }
        } message: {
            Text("Enter new name and email for the company.")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
        .alert("Delete Company", isPresented: $presentDeleteCompanyAlert) {
            VStack {
                HStack {
                    Button("Delete", role: .destructive) {
                        if let company = selectedCompany {
                            removeCompany(company: company)
                        }
                        presentDeleteCompanyAlert = false
                    }
                    
                    Button("Cancel", role: .cancel) {
                        presentDeleteCompanyAlert = false
                    }
                }
                .padding()
            }
        } message: {
            Text("Are you sure you want to delete this company?")
        }
    }
    
    @ViewBuilder
    func buttons(company: Companies) -> some View {
        VStack {
            Spacer()
            HStack {
                Button {
                    selectedCompany = company
                    presentEditCompanyAlert.toggle()
                } label: {
                    Text("Edit")
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                Spacer()
                
                Button {
                    withAnimation {
                        favoriteCompany(company)
                    }
                } label: {
                    Text(company.favoriteCompany ? "Favorited" : "Favorite")
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                Spacer()
                
                Button {
                    selectedCompany = company
                    presentDeleteCompanyAlert.toggle()
                } label: {
                    Text("Delete")
                        .foregroundColor(.black)
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
        }
        .padding([.leading, .trailing])
        .padding(.bottom, 4)
    }
    
     func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
     func checkTextField(textField: String) -> Bool {
        let text = textField
        return text.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
     func addCompany(name: String, email: String) {
        withAnimation {
            if isValidEmail(email: email) && !checkTextField(textField: name) {
                let company = Companies(context: viewContext)
                company.companyName = name
                company.emailAddress = email
                company.lastUpdated = Date()
                company.favoriteCompany = false
                saveContext()
            } else {
                ProgressHUD.showFailed("Invalid name or email.")
            }
        }
    }
    
     func favoriteCompany(_ company: Companies) {
        withAnimation {
            company.favoriteCompany.toggle()
            saveContext()
        }
    }
    
     func editCompany(_ company: Companies, name: String, email: String) {
        withAnimation {
            if isValidEmail(email: email) && !checkTextField(textField: name) {
                company.companyName = name
                company.emailAddress = email
                company.lastUpdated = Date()
                company.favoriteCompany = company.favoriteCompany
                saveContext()
            } else {
                ProgressHUD.showFailed("Invalid name or email.")
            }
        }
    }
    
     func removeCompany(company: Companies) {
        withAnimation {
            viewContext.delete(company)
            saveContext()
        }
    }
    
     func saveContext() {
        do {
            try viewContext.save()
            ProgressHUD.showSucceed("Success")
        } catch {
            print("Error saving context: \(error)")
            ProgressHUD.showError("Error Saving Company Details: \(error).")
        }
    }
}
