//
//  HomeTableViewController.swift
//  Quote Pro
//
//  Created by Anthony Coelho on 2016-06-08.
//  Copyright © 2016 Anthony Coelho. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, QuoteVCDelegate {
    
    var quotesArray: Array<Quote> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)         
        tableView.reloadData()  
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.quotesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! QuoteTVC

        // Configure the cell...
    
        cell.quoteImageView.image = self.quotesArray[indexPath.row].quoteImage
        cell.quoteLabel.text = self.quotesArray[indexPath.row].quoteText

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! QuoteTVC

        
        let quoteView = QuoteView(frame: self.view.bounds)
        quoteView.imageView.image = currentCell.quoteImageView.image
        quoteView.quoteLabel.text = currentCell.quoteLabel.text
        
        let objectsToShare = [snapshot(quoteView)]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = self.view
        self.presentViewController(activityVC, animated: true, completion: nil)
    }
    
    
    func snapshot(view: QuoteView) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0);
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
    return image;
    }
    
    func addQuoteObject(quote: Quote) {
        
        self.quotesArray.append(quote)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showQuoteVC" {
            
            let quoteVC = segue.destinationViewController as! QuoteViewController
            quoteVC.delegate = self
            
        }
    }
    
}
