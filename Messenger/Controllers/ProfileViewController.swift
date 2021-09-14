//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Isaac Loez on 09/09/21.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let data = ["Cerrar Sesión"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

       
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        //Css del boton
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .blue
        
        return cell
    }
    
    //Acciones del boton
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Crear alerta para cofnrimarq eu quiere cerrar sesion
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cerrar Sesion",
                                      style: .destructive,
                                      handler: { [weak self] _ in
                                        
                                        guard let strongSelf = self else {
                                            return
                                        }
                                        
                                        do {
                                           try FirebaseAuth.Auth.auth().signOut()
                                            
                                            let vc = LoginViewController()
                                            let nav = UINavigationController(rootViewController: vc)
                                            nav.modalPresentationStyle = .fullScreen
                                            strongSelf.present(nav, animated: true)
                                            
                                        }
                                        catch{
                                            print("fallo al salir la sesion")
                                            
                                        }
                                        
         }))
        //Creamos otra opcion de cancelar
        alert.addAction(UIAlertAction(title: "Cancelar ",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
        
        
   
    }
}
