//
//  SelectingViewsAlerts.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import SwiftUI
import ProgressHUD

extension SelectingCompaniesView {
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
        }.alert("Alert", isPresented: $companyFoundAlert) {
            VStack {
                HStack {
                    Button("Yes", role: .destructive) {
                        companyFoundAlert.toggle()
                    }
                    Button("No", role: .cancel) {
                        companyFoundAlert.toggle()
                        presentMail.toggle()
                    }
                }
                .padding()
            }
        } message: {
            Text(alertMessage)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }.alert("Alert", isPresented: $companyNotFoundAlert) {
            VStack {
                HStack {
                    Button("Ok", role: .cancel) {
                        companyNotFoundAlert.toggle()
                    }
                }
                .padding()
            }
        } message: {
            Text(alertMessage)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
        }
    }
}
