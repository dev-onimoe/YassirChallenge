//
//  Network.swift
//  YassirChallenge
//
//  Created by Masud Onikeku on 10/09/2024.
//

import Foundation

class Network {
    
    public static let shared = Network()
    private init() {}
    
    func fetchData<T: Codable>(decodingType: T.Type, page: Int, status: String?) async throws -> T? {
        
        if Task.isCancelled {
            throw URLError(.cancelled)
        }
        var link = BASE_URL+"?page=\(page)"
        if let status = status {
            link = link + "&status=\(status)"
        }
        print(link)
        guard let url = URL(string: link) else {throw NetworkError.invalidURL}
        
        //var obj : T? = nil
        if Task.isCancelled {
            throw URLError(.cancelled)
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            if Task.isCancelled {
                throw URLError(.cancelled)
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                return decodedObject
            } catch {
                throw NetworkError.decodingFailed
            }
            
        }catch is URLError {
            print("No Internet Connection")
            throw NetworkError.noInternet
        } catch let networkError as NetworkError {
            print("Network Error: \(networkError.localizedDescription)")
            throw networkError
        } catch {
            print("Unexpected Error: \(error.localizedDescription)")
            throw NetworkError.unknownError(error: error)
        }
        
    }
    
    func fetchImage(url: String, completion: @escaping (Data?) -> ()) {
        
        guard let url = URL(string: url) else {return}
        let req = URLRequest(url: url)
        URLSession.shared.dataTask(with: req, completionHandler: {data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
            }else {
                completion(data)
            }
        }).resume()
    }
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case noData
    case decodingFailed
    case unknownError(error: Error)
    case noInternet
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)."
        case .noData:
            return "No data was received from the server."
        case .decodingFailed:
            return "Failed to decode the response data."
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        case .noInternet:
            return "There is no internet connection"
        }
        
    }
}
