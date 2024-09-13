//
//  ViewModel.swift
//  YassirChallenge
//
//  Created by Masud Onikeku on 10/09/2024.
//

import Foundation
import Combine

class ViewModel : ObservableObject {
    
    @Published private(set) var characters : [Character] = []
    @Published private(set) var filteredCharacters : [Character] = []
    private(set) var currentPage = 0
    var filteredCurrentPage = 0
    var hasNext = true
    var filteredHasNext = true
    
    func fetchCharacters() async {
        if hasNext {
            do {
                let response = try await Network.shared.fetchData(decodingType: CharacterResponse.self, page: currentPage + 1, status: nil)
                if let res = response {
                    
                    currentPage = currentPage + 1
                    if currentPage == res.info.pages {
                        hasNext = false
                    }
                    
                    self.characters = res.results
                    //print(characters)
                }
            }catch {
                errorManager.showError(error.localizedDescription)
            }
        }
    }
    
    func fetchFilteredCharacters(status: String) async {
        if filteredHasNext {
            do {
                let response = try await Network.shared.fetchData(decodingType: CharacterResponse.self, page: filteredCurrentPage + 1, status: status.lowercased())
                if let res = response {
                    
                    filteredCurrentPage = filteredCurrentPage + 1
                    if filteredCurrentPage == res.info.pages {
                        filteredHasNext = false
                    }
                    
                    self.filteredCharacters = res.results
                    //print(filteredCharacters)
                }
            }catch {
                errorManager.showError(error.localizedDescription)
            }
        }
    }
}
