//
//  SettingsVC.swift
//  RecipeVersion2
//
//  Created by Cristian Sedano Arenas on 01/10/2020.
//

import UIKit
import SafariServices

struct SettingsCellModel {
    
    let title: String
    let handler: (() -> Void)
}

enum SettingsURLType {
    
    case terms, privacy, help
}

/// View Controller to show user settings
final class SettingsVC: UIViewController {
    
    private let tableVIew: UITableView = {
        // .grouped separa las opciones, segun las tenemos en la funcion configureModel
        // puedes probar el .insetGrouped
        let tableVIew = UITableView(frame: .zero, style: .grouped)
        tableVIew.register(UITableViewCell.self, forCellReuseIdentifier: Identifier.settingsCell)
        return tableVIew
    }()

    private var data = [[SettingsCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(tableVIew)
        
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
        configureModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableVIew.frame = view.bounds
    }
    
    private func configureModels() {
        
        data.append([
                        SettingsCellModel(title: "Edit Profile") { [weak self] in
                            
                            self?.didTapEditProfile()
                        },
                        SettingsCellModel(title: "Invite Friends") { [weak self] in
                            
                            self?.didTapInviteFriends()
                        },
            
                        SettingsCellModel(title: "Save Original Recipe") { [weak self] in
                            
                            self?.didTapSaveOriginalPosts()
                        }
        ])
        
        data.append([
        
                        SettingsCellModel(title: "Terms Of Services") { [weak self] in
                            
                            self?.openURL(type: .terms)
                        },
            
                        SettingsCellModel(title: "Privacy Policy") { [weak self] in
                            
                            self?.openURL(type: .privacy)
                        },
            
                        SettingsCellModel(title: "Help / Feedback") { [weak self] in
                            
                            self?.openURL(type: .help)
                        }
        ])
        
        data.append([ SettingsCellModel(title: "Log Out") { [weak self] in
            
            self?.didTapLogOut()
            
            }
        ])
        
    }
    
    private func openURL(type: SettingsURLType) {
        
        let urlString: String
        
        switch type {
        
        case .terms: urlString = "https://www.gov.uk/help/terms-conditions"
        case .privacy: urlString = "https://www.gov.uk/data-protection"
        case .help: urlString = "https://www.gov.uk/help"
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true, completion: nil)
    }
    
    private func didTapSaveOriginalPosts() {
        
        
    }
    
    private func didTapInviteFriends() {
        
        // Show share sheet to invite friends
        
    }
    
    private func didTapEditProfile() {
        
        let viewController = EditProfileVC()
        viewController.title = "Edit Profile"
        
        let navViewController = UINavigationController(rootViewController: viewController)
        navigationController?.modalPresentationStyle = .fullScreen
        present(navViewController, animated: true, completion: nil)
    }
    
    private func didTapLogOut() {
        
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {_ in
            
            AuthManager.shared.logOut(complition: { success in
                
                DispatchQueue.main.async {
                    
                    if success {
                        // present Log In
                        let loginVC = LoginVC()
                        loginVC.modalPresentationStyle = .fullScreen
                        
                        self.present(loginVC, animated: true) {
                            
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        // Error
                        self.simpleAlert(title: "Error", message: "Error, something wrong")
                    }
                }
            })
        }))
        // esta accion es para el Ipad, si no la ponemos, no sabe como presentarlo y se rompe la aplicacion
        actionSheet.popoverPresentationController?.sourceView = tableVIew
        actionSheet.popoverPresentationController?.sourceRect = tableVIew.bounds
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.settingsCell, for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Handle cell selection
        data[indexPath.section][indexPath.row].handler()
    }
}
