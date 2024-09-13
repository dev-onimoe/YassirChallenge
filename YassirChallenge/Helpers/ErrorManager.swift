//
//  ErrorManager.swift
//  YassirChallenge
//
//  Created by Masud Onikeku on 13/09/2024.
//

import Foundation

import SwiftUI

class ErrorManager: ObservableObject {
    @Published var errorMessage: String? = nil
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.errorMessage = message
        }
    }
    
    func clearError() {
        DispatchQueue.main.async {
            self.errorMessage = nil
        }
    }
}
