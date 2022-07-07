//
//  CollectionViewCell.swift
//  RodionovEgorTestovoe
//
//  Created by Егор Родионов on 6.07.22.
//

import UIKit

class CusCollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    private var vStack = UIStackView()

    private let type = UILabel()
    private let subCount = UILabel()
    private var image : UIImageView = UIImageView(image: UIImage(systemName: "questionmark"))
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        type.font = UIFont.boldSystemFont(ofSize: 12)
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 20
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 3
        contentView.addSubview(image)
        type.textColor = .white
        subCount.textColor = .white
        vStack.addArrangedSubview(type)
        vStack.addArrangedSubview(subCount)
        contentView.addSubview(vStack)
        setConstraintsForImage()
        configureStack()
        


        

        
    }
    func initMenuList(menuList : MenuList){
        if let url = URL(string: menuList.image){
            do{
                try self.image.image = UIImage(data: Data(contentsOf: url))
            }
            catch{
                print(error)
            }
            
        }

        
        
        type.text = menuList.name
       
        subCount.text = String(menuList.subMenuCount) + " Товаров"
       
        
      
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStack(){
        vStack.axis = .vertical
        vStack.spacing = contentView.frame.height / 7
        vStack.distribution = .equalSpacing
        vStack.alignment = .center
        
        
       
      
        
       
        setConstraintsForStack()
        
    }
    private func setConstraintsForStack(){
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 10).isActive = true
        vStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        
        
        
    }
    private func setConstraintsForImage(){
        self.image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.5).isActive = true
        
        
    }
    
}
