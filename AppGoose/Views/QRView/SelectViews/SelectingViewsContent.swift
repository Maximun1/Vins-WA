//
//  SelectingViewsContent.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import SwiftUI
import ProgressHUD

extension SelectingCompaniesView {
    
    @ViewBuilder
    var content: some View {
        VStack {
            GeometryReader { geo in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(companies, id: \.uniqueID) { company in
                            CompanyRectangleViews(name: company.companyName ?? "", email: company.emailAddress ?? "")
                                .environmentObject(indexGr)
                                .frame(width: geo.size.width, height: 100)
                                .overlay {
                                    buttons(company: company)
                                }
                        }
                    }
                }.navigationBarTitle("Select Company", displayMode: .inline)
                    .navigationBarItems(leading:
                                            Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("QR Scanner")
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
}
