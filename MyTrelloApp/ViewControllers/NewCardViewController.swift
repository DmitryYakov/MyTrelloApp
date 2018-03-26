//
//  NewCardViewController.swift
//  MyTrelloApp
//
//  Created by YakovAlexey on 2/20/18.
//  Copyright © 2018 Alias. All rights reserved.
//

import UIKit

class NewCardViewController: UIViewController {

    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var attachment: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCreateCard(_ sender: Any) {
        guard let cardName = self.cardName.text, let listId = CardsTableViewController.Instance?.listID else {
            return
        }

        TrelloHelper.addCardForList(listId, name: cardName) { (card) in
            if card.error == nil, let cardInfo = card.value {
                TrelloHelper.addAttachmentForCard(cardInfo.id, name: "picture.png", mimeType: "image/png", file:UIImagePNGRepresentation(self.attachment.image!)! , completion: { (success) in
                    self.showAddCardResultAlert(success: success)
                })
            } else {
                self.showAddCardResultAlert(success: false)
            }
        }
    }
    
    func showAddCardResultAlert(success : Bool) {
        let alert = UIAlertController(title: "Add Card", message: success ? "Card Added Successfully" : "Add Card Failed", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
            CardsTableViewController.Instance?.tableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
