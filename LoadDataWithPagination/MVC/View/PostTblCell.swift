//
//  PostTblCell.swift
//  LoadDataWithPagination
//
//  Created by JB on 5/9/24.
//

import UIKit

class PostTblCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblId: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupData(data:Post) {
          self.lblId.text = "\(data.id)"
          self.lblTitle.text = "\(data.title)"
          
      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
