//
//  UserProfilePhotoCell.swift
//  InstagramFirebase
//
//  Created by zijia on 11/15/18.
//  Copyright © 2018 cognitiveAI. All rights reserved.
//

import UIKit

class UserProfilePhotoCell: UICollectionViewCell {
    
    var post: Post?{
        didSet{
            guard let imageUrl = post?.imageUrl else {return}
            guard let url = URL(string: imageUrl) else {return}
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if err != nil{
                    print(err!)
                    return
                }
                
                if url.absoluteString != self.post?.imageUrl{
                    return
                }
                
                guard let imageData = data else {return}
                let photoImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.photoImageView.image = photoImage
                }
                
                }.resume()
        }
    }
    
    let photoImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        imageV.backgroundColor = .red
        return imageV
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
