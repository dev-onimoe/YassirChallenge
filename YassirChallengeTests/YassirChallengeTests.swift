//
//  YassirChallengeTests.swift
//  YassirChallengeTests
//
//  Created by Masud Onikeku on 10/09/2024.
//

import XCTest
@testable import YassirChallenge

final class YassirChallengeTests: XCTestCase {

    func testFetchDataSuccess() async {
        let network = Network.shared
        
        let result: CharacterResponse? = try? await network.fetchData(decodingType: CharacterResponse.self, page: 1, status: nil)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.results.count, 20)
    }
    
    func testFetchImageSuccess() {
        let exp = expectation(description: "Got image")
        let network = Network.shared
        
        network.fetchImage(url: "https://rickandmortyapi.com/api/character/avatar/32.jpeg", completion: { data in
            
            XCTAssertNotNil(data)
            exp.fulfill()
        })
        wait(for: [exp], timeout: 10.0)
        
    }
    
    func testFetchCharactersSuccess() async {
        let viewModel = ViewModel()
        
        await viewModel.fetchCharacters()
        
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertEqual(viewModel.characters.count, 20)
    }
    
    func testFetchFilteredCharactersSuccess() async {
        let viewModel = ViewModel()
        
        await viewModel.fetchFilteredCharacters(status: "alive")
        
        XCTAssertEqual(viewModel.filteredCurrentPage, 1)
        XCTAssertEqual(viewModel.filteredCharacters.count, 20)
    }


}
