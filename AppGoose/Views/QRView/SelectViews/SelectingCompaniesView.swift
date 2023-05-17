//
//  SelectingCompaniesView.swift
//  AppGoose
//
//  Created by Max on 5/12/23.
//

import SwiftUI
import CoreData

struct SelectingCompaniesView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Companies.companyName, ascending: true)], animation: .default)
    var companies: FetchedResults<Companies>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Settings.darkMode, ascending: true)],
        animation: .default)
    var settings: FetchedResults<Settings>
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var thisTx: thisTest
    @EnvironmentObject var indexGr: IndexGrabber
    
    @State var selectedCompany: Companies?
    @State var newCompanyName = ""
    @State var newCompanyEmail = ""
    @State var presentAddingCompanyAlert = false
    @State var presentDeleteCompanyAlert = false
    @State var presentEditCompanyAlert = false
    @State var presentMail = false
    @State var alertForChangingData = false
    @State var alertNoCompany = false
    @State var companyFoundAlert = false
    @State var alertMessage = ""
    @State var companyNotFoundAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Colors(colors: .yellow.opacity(0.8))
                content
            }
        }
        .task {
            taskFunction()
        }
    }
    
}
