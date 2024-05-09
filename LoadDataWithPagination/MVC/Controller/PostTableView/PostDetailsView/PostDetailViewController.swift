//
//  PostDetailViewController.swift
//  LoadDataWithPagination
//
//  Created by JB on 5/9/24.
//

import UIKit

class PostDetailViewController: UIViewController {
        var post: Post?

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblUserID: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let post = post {
                    lblID.text = "\(post.id)"
                    lblUserID.text = "\(post.userId)"
                    lblTitle.text = "\(post.title)"
                    lblSubTitle.text = "\(post.body)"
               }
        
        // Perform intensive computation and display the result
               HeavyComputation.performIntensiveComputation { result in
                   print("result \(result)")
                   self.navigationItem.title = result
               }
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
