//
//  ViewController.swift
//  Quote Pro
//
//  Created by Anthony Coelho on 2016-06-08.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

import UIKit

protocol QuoteVCDelegate: class {
    func addQuoteObject(quote: Quote)
    
}

class QuoteViewController: UIViewController {
    
    @IBOutlet weak var quoteView: QuoteView!
    weak var delegate: QuoteVCDelegate?
   
    
    
    var photosArray: Array<Photo> = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        quoteView.quoteButton.action = #selector(QuoteViewController.changeQuote)
        quoteView.imageButton.action = #selector(QuoteViewController.changeImage)
        quoteView.saveButton.action = #selector(QuoteViewController.save)
        
        self.quoteView.activityIndicator.hidden = false
        quoteView.activityIndicator.startAnimating()
        getPhotos()
        

    
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getPhotos() {
        

        
        
        let req = NSMutableURLRequest(URL: NSURL(string:"https://unsplash.it/list")!)
        
        req.HTTPMethod = "GET"
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) { (data, resp, err) in
            
            guard let data = data else {
                print("no data returned from server \(err)")
                return
            }
            
            guard let resp = resp as? NSHTTPURLResponse else {
                print("no response returned from server \(err)")
                return
            }
            
            guard let rawJson = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
                print("data returned is not json, or not valid")
                return
            }
            
            guard resp.statusCode == 200 else {
                // handle error
                print("an error occurred \(rawJson["error"])")
                return
            }

            
            var json: Array<AnyObject>!
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? Array
            } catch {
                print(error)
            }
        
            for objects in json {

                let photoID: Int = objects["id"] as! Int
                let req = NSMutableURLRequest(URL: NSURL(string:"https://unsplash.it/200/300/?image=\(photoID)&blur")!)
                
                req.HTTPMethod = "GET"
                req.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = NSURLSession.sharedSession().dataTaskWithRequest(req) { (data, resp, err) in
                    
                    guard let data = data else {
                        print("no data returned from server \(err)")
                        return
                    }

                    let photo = Photo(id: photoID, image:UIImage(data: data)!)
    

                    self.photosArray.append(photo)
   
                }

                dispatch_async(dispatch_get_main_queue(), {
                    self.quoteView.activityIndicator.stopAnimating()
                    self.quoteView.activityIndicator.hidden = true


  
                })
                
                task.resume()

            }
            
 
        }
        
        
        task.resume()

        
    }
    
    func changeQuote() {

            self.quoteView.activityIndicator.hidden = false
            quoteView.activityIndicator.startAnimating()
        
            
            let req = NSMutableURLRequest(URL: NSURL(string:"http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!)
        
            req.HTTPMethod = "GET"
            req.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(req) { (data, resp, err) in
                
                guard let data = data else {
                    print("no data returned from server \(err)")
                    return
                }
                
                guard let resp = resp as? NSHTTPURLResponse else {
                    print("no response returned from server \(err)")
                    return
                }
                
                guard let rawJson = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else {
                    print("data returned is not json, or not valid")
                    return
                }
                
                guard resp.statusCode == 200 else {
                    // handle error
                    print("an error occurred \(rawJson["error"])")
                    return
                }
                
                // do something with the data returned (decode json, save to user defaults, etc.)
                var json: NSDictionary!
                do {
                    json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? NSDictionary
                } catch {
                    print(error)
                }
                
                let quote = json["quoteText"] as! String
                let author = json["quoteAuthor"] as! String
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.quoteView.quoteLabel.text = "\(quote)\n\n\(author)"
              
                    
                })

                
            }
        
        
            dispatch_async(dispatch_get_main_queue(), {
                self.quoteView.activityIndicator.stopAnimating()
                self.quoteView.activityIndicator.hidden = true
                
                
            })
        
            task.resume()
            
        


    }
    
    func randomItem() -> Int {
        let index = Int(arc4random_uniform(UInt32(self.photosArray.count)))
        return index
    }

    func changeImage() {
        
        let photoID = randomItem()
        
        self.quoteView.imageView.image = self.photosArray[photoID].image
            

   
        
    }
    
    func save() {
        
        let quote = Quote(quoteText: self.quoteView.quoteLabel.text!, image: self.quoteView.imageView.image!)
        
        self.delegate!.addQuoteObject(quote)
        
        self.navigationController!.popViewControllerAnimated(true)
        
    }
}

