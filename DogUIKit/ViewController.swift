//
//  ViewController.swift
//  DogUIKit
//
//  Created by jbarrull on 29/06/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var buttonREload: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadNewImage()
    }


    fileprivate func loadNewImage()  {
         Task.init {
            do {
                self.imageView.image = try await self.fetchImage()
                
            }catch {
                print("error")
            }
        }
    }
    
    @IBAction func  buttonReload(_ sender: UIButton) {
        
        loadNewImage()
        
    }
    
    
    struct Dog: Identifiable, Codable {
        let message: String
        let status: String

        var id: String { message }
        var url: URL { URL(string: message)! }
    }
    
    
    func fetchDog() async throws -> Dog {
        let dogURL = URL(string: "https://dog.ceo/api/breeds/image/random")!
        let (data, _) = try await URLSession.shared.data(from: dogURL)
        return try JSONDecoder().decode(Dog.self, from: data)
    }

    func fetchImage() async throws -> UIImage {
        let dog = try await fetchDog()
        let (data, _) = try await URLSession.shared.data(from: dog.url)
        return UIImage(data: data)!
    }
    
}

