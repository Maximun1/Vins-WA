//
//  SelectingVIewBtns.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import SwiftUI

extension SelectingCompaniesView {
    @ViewBuilder
    func buttons(company: Companies) -> some View {
        VStack {
            Spacer()
            HStack {
                selectButton(for: company)
                Spacer()
                editButton(for: company)
                Spacer()
                favoriteButton(for: company)
                Spacer()
                deleteButton(for: company)
            }
        }
        .padding([.leading, .trailing])
        .padding(.bottom, 4)
    }
    
    @ViewBuilder
    func selectButton(for company: Companies) -> some View {
        Button {
            thisTx.getCompanyName = company.companyName ?? "nil"
            thisTx.getEmail = company.emailAddress ?? "Gose"
            presentMail.toggle()
        } label: {
            Text("Select")
                .foregroundColor(.black)
                .font(.title3)
                .fontWeight(.bold)
        }
        .fullScreenCover(isPresented: $presentMail) {
            MainPanelView(email: thisTx.getEmail, vin: thisTx.vin)
                .environmentObject(indexGr)
                .environmentObject(thisTx)
        }
    }
    
    @ViewBuilder
    func editButton(for company: Companies) -> some View {
        Button {
            selectedCompany = company
            presentEditCompanyAlert.toggle()
        } label: {
            Text("Edit")
                .foregroundColor(.black)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
    
    @ViewBuilder
    func favoriteButton(for company: Companies) -> some View {
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
    }
    
    @ViewBuilder
    func deleteButton(for company: Companies) -> some View {
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
