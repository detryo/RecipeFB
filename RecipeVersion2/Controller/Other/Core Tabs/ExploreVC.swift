//
//  ExploreVC.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit

class ExploreVC: UIViewController {
    
    private var model = [UserPost]()
    private var collectionView: UICollectionView?
    let layout = UICollectionViewFlowLayout()
    private var tabbedSearchCollectionView: UICollectionView?
    
    // Design UI
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .secondarySystemBackground
        return searchBar
    }()
    
    private let dimedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureSearchBar()
        configureExploreCollectionView()
        configureDimedView()
        configureTabSearch()
    }
  
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
        dimedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0,
                                                   y: view.safeAreaInsets.top,
                                                   width: view.width,
                                                   height: 70)
    }
    
    private func configureTabSearch() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width / 3, height: 50)
        layout.scrollDirection = .horizontal
        
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        tabbedSearchCollectionView?.backgroundColor = .yellow
        
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else { return }
        
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        view.addSubview(tabbedSearchCollectionView)
        
    }
    
    private func configureDimedView() {
        
        view.addSubview(dimedView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSearchCancel))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        dimedView.addGestureRecognizer(gesture)
    }
    
    private func configureSearchBar() {
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func configureExploreCollectionView() {
        
        let size = (view.width - 4) / 3
        
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: Identifier.photoCell)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
}

extension ExploreVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        didSearchCancel()
        
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        query(text)
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didSearchCancel))
        
        dimedView.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.dimedView.alpha = 0.4
            
        }) { done in
            //Complition handler
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }
    }
    
    @objc private func didSearchCancel() {
        
        searchBar.becomeFirstResponder()
        navigationItem.rightBarButtonItem = nil
        
        self.tabbedSearchCollectionView?.isHidden = true
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.dimedView.alpha = 0
            
        }) { done in
            //Complition handler
            self.dimedView.isHidden = true
        }
    }
    
    private func query(_ text: String) {
        
        // perfomr the search in the back end
    }
}

extension ExploreVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tabbedSearchCollectionView {
            
            return UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.photoCell,
                                                            for: indexPath) as? PhotoCell else {
            
            return UICollectionViewCell()
        }
        
        cell.configureDebugg(debug: "Emblem")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == tabbedSearchCollectionView {
            // Change search content
            return
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let user = User(userName: "Chris",
                        bio: "",
                        name: (first: "", last: ""),
                        birthDate: Date(),
                        joinDate: Date(),
                        gender: .male,
                        count: UserCount(followers: 1, following: 1, post: 1),
                        profilePhoto: URL(string: "https://www.google.com")!)
        
        let post = UserPost(identifier: "",
                            postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: nil,
                            likeCount: [],
                            comments: [],
                            createDate: Date(),
                            taggedUsers: [],
                            owner: user)
        
        let viewController = PostVC(model: post)
        viewController.title = post.postType.rawValue
        navigationController?.pushViewController(viewController, animated: true)
    }
}
