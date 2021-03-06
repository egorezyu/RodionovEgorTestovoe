//
//  ViewController.swift
//  RodionovEgorTestovoe
//
//  Created by Егор Родионов on 6.07.22.
//

import UIKit

class ViewController: UIViewController {
    private var phoneImage : UIImageView = UIImageView(image: UIImage(systemName: "phone"))
    private var collectionView : UICollectionView!
    private var secondCollectionView : UICollectionView!
    private var images : [UIImage?] = []
    private var secondImages : [UIImage?] = []
    private var typesOfFood : FoodType?
    private var accurateTypeOfFood : AccurateTypeOfFood?
    private var selectedIndex : Int = -1
    private var kind = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        phoneImage.tintColor = .white
        view.backgroundColor = .darkGray
       
        
        setNavigationTitle()
        setNavigationImage()
        configureCollectionView()
        configureSecondCollectionView()
        setFood()
        setTabBar()
        
        
        
        kind.font = UIFont.boldSystemFont(ofSize: 30)
        kind.textColor = .white
        view.addSubview(kind)
        kind.translatesAutoresizingMaskIntoConstraints = false
        kind.topAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: -10).isActive = true
        kind.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20).isActive = true
        // Do any additional setup after loading the view.
       
        
    }
    private func getAccurrateTypeOfFood(id : Int){
        
        NetworkManager.netWork.getData(url: "https://vkus-sovet.ru/api/getSubMenu.php?menuID=" + String(id),params: ["menuID": id]) { result in
            switch result{
                
            case .success(let data):
                do{
                    
    
                    let acc = try JSONDecoder().decode(AccurateTypeOfFood.self, from: data)
                    self.accurateTypeOfFood = acc
                    DispatchQueue.main.async {[weak self] in
                        self?.accurateTypeOfFood = acc
                    }
                    guard let accC = acc.menuList else{
                        return
                    }
                
                    for element in accC {
                        NetworkManager.netWork.getData(url: "https://vkus-sovet.ru/" + element.image,method: "GET") { result in
                            switch result{
                                
                            case .success(let data):
                                DispatchQueue.main.async {[weak self] in
                                    self?.secondImages.append(UIImage(data: data))
                                    self?.secondCollectionView.reloadData()
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                      
                        
                    }
                    
                    
                    
                }
                catch{
                    print(error)
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
        
    }
    private func setNavigationTitle(){
       
        
       
        
        
        let logo = UIImage(named: "logo")
        let imageView = UIImageView(image:logo)
        let title = UILabel()
        title.text = "VKUSSOVET"
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 30)
        imageView.contentMode = .scaleAspectFit
        if let navB = navigationController?.navigationBar{
            navB.addSubview(imageView)
            navB.addSubview(title)
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.leadingAnchor.constraint(equalTo: navB.leadingAnchor,constant: 10).isActive = true
            imageView.centerYAnchor.constraint(equalTo: navB.centerYAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            title.translatesAutoresizingMaskIntoConstraints = false
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10).isActive = true
            title.centerYAnchor.constraint(equalTo: navB.centerYAnchor).isActive = true
            
        }
       
        
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    private func setNavigationImage(){
        navigationController?.navigationBar.addSubview(phoneImage)
        setConstraintsForPhoneImage()
        
        
    }
    private func setConstraintsForPhoneImage(){
        
        
        if let navB = navigationController?.navigationBar{
//            let navBarHeightPercentage = navB.frame.height * 0.7
            phoneImage.translatesAutoresizingMaskIntoConstraints = false
            phoneImage.trailingAnchor.constraint(equalTo: navB.trailingAnchor,constant: -20).isActive = true
            phoneImage.centerYAnchor.constraint(equalTo: navB.centerYAnchor).isActive = true
            phoneImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
            phoneImage.heightAnchor.constraint(equalToConstant: 50).isActive = true

            
        }
    }
    private func configureCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        layout.itemSize = CGSize(width: (view.frame.width / 3), height: (view.frame.width / 3))
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CusCollectionViewCell.self, forCellWithReuseIdentifier: CusCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .darkGray
        view.addSubview(collectionView)
        setConstraintsForCollectionView()
    }
    private func setConstraintsForCollectionView(){
        collectionView.frame = CGRect(x: 20, y: 0, width: view.frame.width - 20, height: view.frame.height * 0.35)
        
    }
    private func setFood(){
        NetworkManager.netWork.getData(url: "https://vkus-sovet.ru/api/getMenu.php") { result in
            switch result{
                
            case .success(let data):
                do{
    
                    let typeOfFoods = try JSONDecoder().decode(FoodType.self, from: data)
                    DispatchQueue.main.async {[weak self] in
                        self?.typesOfFood = typeOfFoods
                    }
                
                    for element in typeOfFoods.menuList{
                        NetworkManager.netWork.getData(url: "https://vkus-sovet.ru/" + element.image,method: "GET") { result in
                            switch result{
                                
                            case .success(let data):
                                DispatchQueue.main.async {[weak self] in
                                    self?.images.append(UIImage(data: data))
                                    self?.collectionView.reloadData()
                                }
                            case .failure(let error):
                                print(error)
                            }
                        }
                        
                      
                        
                    }
                    
                }
                catch{
                    print(error)
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    private func setTabBar(){
        let pViewController = UIViewController()
        pViewController.title = "Add"
        
        pViewController.tabBarItem.image = UIImage(systemName: "plus")
        
        let cont = UIViewController()
        cont.title = "Home"
        cont.tabBarItem.image = UIImage(systemName: "house")
        let tabBar = UITabBarController()
        tabBar.tabBar.backgroundColor = .yellow
        tabBar.tabBar.layer.cornerRadius = 25
        
        tabBar.setViewControllers([pViewController,cont], animated: false)
        tabBar.modalPresentationStyle = .fullScreen
    }
    private func configureSecondCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 10, height: (view.frame.width / 1.5) - 3)
        secondCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        secondCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.identifier)
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.backgroundColor = .darkGray
        view.addSubview(secondCollectionView)
        setConstraintsForSecondCollectionView()
        
    }
    private func setConstraintsForSecondCollectionView(){
        secondCollectionView.frame = CGRect(x: 5, y: collectionView.frame.height + 30, width: view.frame.width - 10, height: view.frame.height * 0.50)
        
    }
    
   


}
extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView{
            if let menuList = typesOfFood?.menuList{
                return menuList.count
            }
            else{
                return 0
            }
        }
        else{
            if let menuList = accurateTypeOfFood?.menuList{
                return menuList.count
            }
            else{
                return 0
            }
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CusCollectionViewCell.identifier, for: indexPath) as! CusCollectionViewCell
            
            if let menuList = typesOfFood?.menuList{
                cell.initMenuList(menuList: menuList[indexPath.row])
                if ((images.count) <= indexPath.row){
                    cell.initMenuList(menuList: menuList[indexPath.row])
                }
                else{
                    cell.initMenuList(menuList: menuList[indexPath.row], image: images[indexPath.row])
                }
            }
            
            if selectedIndex == indexPath.row{
                cell.contentView.backgroundColor = .systemBlue
            }
            else{
                cell.contentView.backgroundColor = .gray
            }
            
            
            
            return cell
            }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.identifier, for: indexPath) as! SecondCollectionViewCell
            if let accType = accurateTypeOfFood?.menuList{
                
                if ((secondImages.count) <= indexPath.row){
                    cell.initMenuItem(menu: accType[indexPath.row])
                }
                else{
                    cell.initMenuItem(menu: accType[indexPath.row], image: secondImages[indexPath.row])
                }
            }
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        secondImages = []
        selectedIndex = indexPath.row
        self.kind.text = typesOfFood?.menuList[selectedIndex].name ?? ""
        self.collectionView.reloadData()
        
        
//        self.secondCollectionView.reloadData()
        if let idString = typesOfFood?.menuList[selectedIndex].menuID,let idInt = Int(idString){
            getAccurrateTypeOfFood(id: idInt)
        }
       

       
        
    }
    
}



