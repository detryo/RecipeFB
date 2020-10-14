//
//  ListVC.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit

class ListVC: UIViewController {
    
    private let data: [UserRelationship]
    
    init(data: [UserRelationship]) {
        
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

   

}
