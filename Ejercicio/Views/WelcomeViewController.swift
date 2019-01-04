//
//  WelcomeViewController.swift
//  Ejercicio
//
//  Created by Francisco Paramo Muñoz on 25/12/2018.
//  Copyright © 2018 Francisco Paramo Muñoz. All rights reserved.
//

import UIKit


class WelcomeViewController: UIViewController {
    var arrData = [CentroCultural]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var constraintView: NSLayoutConstraint!
    var panGesture = UIPanGestureRecognizer()
    @IBOutlet weak var viewClicked: UIView!
    var con : CGFloat = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewHeader.layer.cornerRadius = 2
        self.viewHeader.clipsToBounds = true
        self.viewClicked.superview?.layer.cornerRadius = 5
        self.viewClicked.superview?.clipsToBounds = true
        con = constraintView.constant
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(WelcomeViewController.draggedView(_:)))
        viewClicked.isUserInteractionEnabled = true
        viewClicked.addGestureRecognizer(panGesture)
        Datas().downloadData(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func showList(_ sender: Any) {
        if arrData.count == 0 {
            let alert = UIAlertController(title: "Error", message: "No hay datos para mostrar", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: false, completion: nil)
        }else{
            let vc : ListViewController = storyboard?.instantiateViewController(withIdentifier: "List") as! ListViewController
            vc.arr = arrData
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        guard let v = self.viewClicked.superview else {
            return
        }
        let y = v.center.y + translation.y
        print(v.center.y - y)
        constraintView.constant = con + (-1 * (v.center.y - y))
        print(constraintView.constant)
        if constraintView.constant > (-1 * (self.viewClicked.bounds.height)) {
            constraintView.constant = (-1 * (self.viewClicked.bounds.height))
        }
        if constraintView.constant < (-1 * (v.bounds.height + 10)) {
            constraintView.constant = (-1 * (v.bounds.height + 10))
        }
        
        if sender.state == .ended {
            con = constraintView.constant
        }
    }
}

extension WelcomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.img.image = #imageLiteral(resourceName: "24736")
        cell.lbl.text = arrData[indexPath.row].title
        return cell
    }
    
}

extension WelcomeViewController : dataDownload {
    
    func correctDataDownload(arr: [CentroCultural]) {
        arrData = arr
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        do{
            let strJson = try encoder.encode(arr)
            defaults.set(strJson, forKey: "data")
        } catch let err {
            print(err.localizedDescription)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func errorDataDownload(err: Error) {
        if err.localizedDescription == "The Internet connection appears to be offline." {
            let defaults = UserDefaults.standard
            let data : Data = defaults.object(forKey: "data") as! Data
            do{
                let decoder = JSONDecoder()
                let download = try decoder.decode([CentroCultural].self, from: data)
                arrData = download
                
                collectionView.delegate = self
                collectionView.dataSource = self
            }catch let err {
                print(err.localizedDescription)
            }
            
            return
        }
        let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: false, completion: nil)
        
    }
    
    
}
