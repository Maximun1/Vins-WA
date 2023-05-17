//
//  SelectingViewFunctions.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import SwiftUI
import ProgressHUD

extension SelectingCompaniesView {
    func taskFunction() {
        for companyTest in companies {
            if thisTx.getCompanyName == "" {
                
            } else {
                if companyTest.companyName == thisTx.getCompanyName {
                    selectedCompany = companyTest
                }
            }
            
        }
        
        if selectedCompany != nil {
            alertMessage = "Company Found, Do You Want To Select A different Company? Name: \(selectedCompany?.companyName ?? "Nil"), Email: \(selectedCompany?.emailAddress ?? "Nil")"
            companyFoundAlert.toggle()
        } else {
            alertMessage = "Company Not Found. Please select or make a new company to continue"
            companyNotFoundAlert.toggle()
        }
    }
    
    func containsOnlyStringsAndNumbers(_ input: String) -> Bool {
        let characterSet = CharacterSet.alphanumerics.inverted
        return input.rangeOfCharacter(from: characterSet) == nil
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func addCompany(name: String, email: String) {
        withAnimation {
            guard isValidEmail(email: email), !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                ProgressHUD.showFailed("Invalid name or email.")
                return
            }
            
            let company = Companies(context: viewContext)
            company.companyName = name
            company.emailAddress = email
            company.lastUpdated = Date()
            company.favoriteCompany = false
            saveContext()
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
            guard isValidEmail(email: email), !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                ProgressHUD.showFailed("Invalid name or email.")
                return
            }
            
            company.companyName = name
            company.emailAddress = email
            company.lastUpdated = Date()
            saveContext()
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
            ProgressHUD.showError("Error Saving company: \(error).")
            print("Error saving context: \(error)")
        }
    }
}
