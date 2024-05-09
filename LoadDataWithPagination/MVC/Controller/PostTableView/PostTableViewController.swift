//
//  ViewController.swift
//  LoadDataWithPagination
//
//  Created by JB on 5/9/24.
//

import UIKit

class PostTableViewController: UIViewController {

    var posts: [Post] = []
    @IBOutlet weak var tblView:UITableView!
    var isLoading = false
       var hasMoreData = true
       
       let headerLoadingIndicator = UIActivityIndicatorView(style: .large)
       let footerLoadingIndicator = UIActivityIndicatorView(style: .medium)
       
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadInitialData()
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          // Hide the navigation bar when this view controller appears
          navigationController?.setNavigationBarHidden(true, animated: animated)
      }
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Show the navigation bar when this view controller disappears
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
  
}
