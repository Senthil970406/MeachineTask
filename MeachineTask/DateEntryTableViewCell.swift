//
//  DateEntryTableViewCell.swift
//  MeachineTask
//
//  Created by Senthilnathan M on 06/02/21.
//

import UIKit

class DateEntryTableViewCell: UITableViewCell {

    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
