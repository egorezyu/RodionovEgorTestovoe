//
//  SecondCollectionViewCell.swift
//  RodionovEgorTestovoe
//
//  Created by Егор Родионов on 6.07.22.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    private var type : UILabel = UILabel()
    private var subType : UILabel = UILabel()
    private var price : UILabel = UILabel()
    private var weight : UILabel = UILabel()
    private var vStack = UIStackView()
    private var hStack = UIStackView()
    private var image = UIImageView(image: UIImage(systemName: "questionmark"))
    private var pepper = UIImageView()
    
    private var button : UIButton  = {
        var button = UIButton()
        button.setTitle("В корзину", for: .normal)
        
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        return button
        
    }()
    
    
    
    
    static let identifier = "SecondCollectionViewCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 20
//        contentView.layer.borderWidth = 3
//        contentView.layer.borderColor = UIColor.cyan.cgColor
        image.layer.cornerRadius = 20
        contentView.backgroundColor = .black
        pepper.contentMode = .scaleAspectFit
        subType.lineBreakMode = .byWordWrapping
        subType.numberOfLines = 0
        type.font = UIFont.boldSystemFont(ofSize: 20)
        vStack.addArrangedSubview(type)
        vStack.addArrangedSubview(subType)
        hStack.addArrangedSubview(price)
        hStack.addArrangedSubview(weight)
        
        contentView.addSubview(vStack)
        contentView.addSubview(hStack)
        contentView.addSubview(image)
        contentView.addSubview(pepper)
        
        let button = button
        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 7).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant:  contentView.frame.width * 0.2).isActive = true
        button.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.8).isActive = true
        
        configureImageConstraints()
        setConstraintsForImage()
        configureStacks()
    }
    private func configureStacks(){
        vStack.axis = .vertical
        vStack.spacing = 7
        vStack.distribution = .fill
        vStack.alignment = .center
        hStack.axis = .horizontal
        hStack.spacing = 7
        hStack.distribution = .fill
        hStack.alignment = .center
        
        
        
       
      
        
       
        setConstraintsForStacks()
        
        
    }
    private func configureImageConstraints(){
        pepper.translatesAutoresizingMaskIntoConstraints = false
        pepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        pepper.centerYAnchor.constraint(equalTo: hStack.centerYAnchor).isActive = true
        pepper.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.1).isActive = true
        price.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.1).isActive = true
        
    }
    func initMenuItem(menu : MenuListForAccurateFood,image : UIImage? = nil){
        self.image.image = image
        type.text = menu.name
        type.textColor = .white
        subType.text = menu.content
        subType.textColor = .gray
        price.text = menu.price + " Р/"
        price.textColor = .white
        if let weigt = menu.weight{
            weight.text = weigt + "."
        }
        
        weight.textColor = .gray
        if menu.spice != nil{
            pepper.image =  UIImage(named: "pepper")
            
        }
    }
    private func setConstraintsForStacks(){
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5).isActive = true
        vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5).isActive = true
        vStack.heightAnchor.constraint(equalToConstant:  contentView.frame.height / 4).isActive = true
        hStack.translatesAutoresizingMaskIntoConstraints = false
        hStack.topAnchor.constraint(equalTo: vStack.bottomAnchor,constant: 30).isActive = true
        hStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    
        
    }
    private func setConstraintsForImage(){
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 5).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
