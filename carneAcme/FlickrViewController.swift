//
//  PresentationViewController.swift
//  carneAcme
//
//  Created by Álvaro Martín on 20/12/2016.
//  Copyright © 2016 Álvaro Martín. All rights reserved.
//





import UIKit
import SwiftyXMLParser

class FlickrViewController: UITabBarController {
    
    var picID = [String]()
    var picInfoEndPoint = [String]()
    var picsURL = [String]()
    let pictureTag = "meat"

    let flickrOneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()

    let flickrTwoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    } ()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.90, alpha: 1)
        view.addSubview(flickrOneImageView)
        view.addSubview(flickrTwoImageView)
        
        setupflickrOneImageView()
        setupflickrTwoImageView()
        
        fetchFlickrPicsId()
        
    }
    
    func fetchFlickrPicsId() {
        
        let picEndPoint: String = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=df3e5ec4dcc70c6a1dc31a412483dd42&tags=\(pictureTag)&per_page=2"
        
        guard let url = URL(string: picEndPoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard error == nil else {
                print("error calling GET")
                print(error!)
                return
            }
        
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            let xml = XML.parse(responseData)
            for pic in xml["rsp", "photos", "photo"] {
                self.picsURL.append("https://farm\(pic.attributes["farm"]!).staticflickr.com/\(pic.attributes["server"]!)/\(pic.attributes["id"]!)_\(pic.attributes["secret"]!).jpg")
                
            }
            
            if let checkedUrl = URL(string: self.picsURL[0]) {
                self.downloadImage(url: checkedUrl, flickrPic: self.flickrOneImageView)
                self.downloadImage(url: URL(string: self.picsURL[1])!, flickrPic: self.flickrTwoImageView)
            }
            
        }
    
        task.resume()
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, flickrPic: UIImageView) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                flickrPic.image = UIImage(data: data)
            }
        }
    }
    
    func setupflickrOneImageView() {
        flickrOneImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        flickrOneImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        flickrOneImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        flickrOneImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
    }

    func setupflickrTwoImageView() {
        flickrTwoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        flickrTwoImageView.topAnchor.constraint(equalTo: flickrOneImageView.bottomAnchor).isActive = true
        flickrTwoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        flickrTwoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
    }
    
}
