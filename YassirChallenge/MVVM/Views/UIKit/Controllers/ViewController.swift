//
//  ViewController.swift
//  YassirChallenge
//
//  Created by Masud Onikeku on 10/09/2024.
//

import UIKit
import Combine
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var statusStack : UIStackView!
    @IBOutlet weak var tableView : UITableView!
    
    
    let viewModel = ViewModel()
    var chars : [Character] = []
    var filteredChars : [Character] = []
    var refChars : [Character] = []
    var filterOn = false
    var filterStatus = ""
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setup()
        
        errorManager.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorString in
                self?.showError(error: errorString)
            }
            .store(in: &cancellables)
        
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] characters in
                self?.updateUI(with: characters)
            }
            .store(in: &cancellables)
        
        viewModel.$filteredCharacters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] characters in
                self?.updateFilteredUI(with: characters)
            }
            .store(in: &cancellables)
        
        Task {
            await viewModel.fetchCharacters()
        }
    }
    
    func updateUI(with characters: [Character]) {
        self.chars.append(contentsOf: characters)
        self.refChars = chars
        self.tableView.reloadData()
    }
    
    func updateFilteredUI(with characters: [Character]) {
        self.filteredChars.append(contentsOf: characters)
        self.refChars = filteredChars
        self.tableView.reloadData()
    }
    
    func showError(error: String?) {
        guard let err = error else {return}
        let alert = UIAlertController(title: "Error", message: err, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func setup() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        statusStack.isUserInteractionEnabled = true
        for v in statusStack.arrangedSubviews {
            
            v.isUserInteractionEnabled = true
            v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(applyFilter)))
            
        }
    }
    
    @objc func applyFilter(sender: UITapGestureRecognizer) {
        
        let view = sender.view!
        if view.backgroundColor == UIColor.green {
            view.backgroundColor = .white
            if let label = view.subviews.first as? UILabel {
                label.textColor = .black
            }
            self.refChars = chars
            self.tableView.reloadData()
            filterOn = false
            viewModel.filteredCurrentPage = 0
            self.filteredChars.removeAll()
        }else {
            for views in statusStack.arrangedSubviews {
                views.backgroundColor = UIColor.white
                if let label = views.subviews.first as? UILabel {
                    label.textColor = .black
                }
            }
            view.backgroundColor = UIColor.green
            var status = ""
            if let label = view.subviews.first as? UILabel {
                label.textColor = .white
                status = label.text!
                self.filterStatus = status
                Task {
                    await viewModel.fetchFilteredCharacters(status: status)
                }
            }
            filterOn = true
            viewModel.filteredCurrentPage = 0
            self.filteredChars.removeAll()
        }
        
    }
    
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        refChars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharacterTableViewCell
        let char = self.refChars[indexPath.row]
        cell.selectionStyle = .none
        cell.bggView.backgroundColor = listColors.randomElement()
        cell.Charimage.fetchImage(url: char.image)
        cell.name.text = char.name
        cell.type.text = char.species
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let char = refChars[indexPath.row]
        let hostController = UIHostingController(rootView: SwiftUIView(closure: {
            self.navigationController?.popViewController(animated: true)
        }, character: char))
        self.navigationController?.pushViewController(hostController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == refChars.count {
            
            if filterOn {
                Task {
                    await viewModel.fetchFilteredCharacters(status: self.filterStatus)
                }
            }else {
                Task {
                    await viewModel.fetchCharacters()
                }
            }
            
        }
    }
}

