//
//  thisTestModel.swift
//  AppGoose
//
//  Created by Max on 5/13/23.
//

import Foundation
import SwiftUI

class thisTest: ObservableObject {
    @Published var vin: String = ""
    @Published var getEmail: String = ""
    @Published var getPickupOrDeliveryType: String = ""
    @Published var getCompanyName: String = ""
    @Published var companyType: String = ""
}
