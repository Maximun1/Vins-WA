//
//  ExtensionViews.swift
//  AppGoose
//
//  Created by Max Bezzabara on 5/11/23.
//

import SwiftUI
import CoreData
import CloudKit
import ProgressHUD

extension Companies {
    var uniqueID: String {
        guard let lastUpdated = self.lastUpdated else {
            return "\(self.objectID)"
        }
        return "\(self.objectID)-\(lastUpdated.timeIntervalSince1970)"
    }
}

