//
//  ListVC.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

// Este Controlador es de Followers y Followings
import UIKit

class ListVC: UIViewController {
    
    private let data: [UserRelationship]
    
    // Design UI
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserFollowCell.self, forCellReuseIdentifier: Identifier.userFollowCell)
        return tableView
    }()
    
    init(data: [UserRelationship]) {
        
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

extension ListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.userFollowCell, for: indexPath) as! UserFollowCell
        
        cell.configureCell(with: data[indexPath.row])
        cell.delegate = self
        
        return cell
    }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Go to Profile of selected cell
        let model = data[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    }
}

extension ListVC: UserFollowCellDelegate {
    
    func didTapFollowUnFollowButton(model: UserRelationship) {
        
        switch model.type {
            
        case .following:
            // Perform firebase update to unfollow
            break
        case .not_following:
            // Perform firebase update to follow
            break
        }
    }
}
