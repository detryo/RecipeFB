//
//  PostVC.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit

class PostVC: UIViewController {

    private let model: UserPost?
    
    init(model: UserPost?) {
        
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    

}
