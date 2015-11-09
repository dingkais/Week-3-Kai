//
//  MailboxViewController.swift
//  Mailbox - Kai
//
//  Created by Kai Ding on 11/7/15.
//  Copyright © 2015 Kai Ding. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var rescheduleMenu: UIImageView!
    @IBOutlet weak var listMenu: UIImageView!
    @IBOutlet weak var menuView: UIView!
    
    var messageOriginalCenter: CGPoint!
    var leftIconOriginalCenter: CGPoint!
    var rightIconOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = feedImageView.image!.size

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panMessage(sender: UIPanGestureRecognizer) {
        // Absolute (x,y) coordinates in parent view
        var point = sender.locationInView(view)
        // Relative change in (x,y) coordinates from where gesture began.
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalCenter = messageView.center
            leftIconOriginalCenter = archiveIcon.center
            rightIconOriginalCenter = listIcon.center
            
            print("Gesture began at: \(point)-\(translation)-\(velocity) ")
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            listIcon.center = CGPoint(x: rightIconOriginalCenter.x + translation.x, y: rightIconOriginalCenter.y)
            laterIcon.center = CGPoint(x: rightIconOriginalCenter.x + translation.x, y: rightIconOriginalCenter.y)
            archiveIcon.center = CGPoint(x: leftIconOriginalCenter.x + translation.x, y: leftIconOriginalCenter.y)
            deleteIcon.center = CGPoint(x: leftIconOriginalCenter.x + translation.x, y: leftIconOriginalCenter.y)
            
            // pan left
            if translation.x < 0 && translation.x >= -60 {
                messageBackgroundView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                laterIcon.alpha = 0
                listIcon.alpha = 0
            } else if translation.x < -60 && translation.x >= -260 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor(red: 255/255, green: 211/255, blue: 30/255, alpha: 1)
                    self.laterIcon.alpha = 1
                    self.listIcon.alpha = 0
                })

            } else if translation.x < -260 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.messageBackgroundView.backgroundColor = UIColor(red: 216/255, green: 166/255, blue: 117/255, alpha: 1)
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 1
                })
            }
            
                // pan right
              else if translation.x > 0 && translation.x <= 60 {
                messageBackgroundView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                archiveIcon.alpha = 0
                deleteIcon.alpha = 0
            } else if translation.x > 60 && translation.x <= 260 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor(red: 98/255, green: 217/255, blue: 98/255, alpha: 1)
                    self.archiveIcon.alpha = 1
                    self.deleteIcon.alpha = 0
                })
            } else if translation.x > 260 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor(red: 238/255, green: 84/255, blue: 10/255, alpha: 1)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 1
                })
            }
            
            
            

            print("Gesture changed at: \(point)-\(translation)-\(velocity) ")
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if translation.x < -260 {
                self.messageView.alpha = 0
                self.listIcon.alpha = 0
                self.menuView.hidden = false
                self.rescheduleMenu.hidden = true
                self.listMenu.hidden = false
                
            } else if translation.x > -260 && translation.x < -60 {
                self.messageView.alpha = 0
                self.laterIcon.alpha = 0
                self.menuView.hidden = false
                self.rescheduleMenu.hidden = false
                self.listMenu.hidden = true
            } else if translation.x > 260 {
                self.messageView.alpha = 0
                self.deleteIcon.alpha = 0
                delay(0.5, closure: { () -> () in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.feedImageView.center.y -= 86
                    })
                })
               
            } else if translation.x > 60 && translation.x <= 260 {
                self.messageView.alpha = 0
                self.archiveIcon.alpha = 0
                delay(0.5, closure: { () -> () in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.feedImageView.center.y -= 86
                    })
                })
            }
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.messageView.center =  self.messageOriginalCenter
                self.laterIcon.center = self.rightIconOriginalCenter
                self.listIcon.center = self.rightIconOriginalCenter
                self.archiveIcon.center = self.leftIconOriginalCenter
                self.deleteIcon.center = self.leftIconOriginalCenter
                }, completion: { (Bool) -> Void in
//                self.messageBackgroundView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                    
            })
            
           
            print("Gesture ended at: \(point)-\(translation)-\(velocity) ")

        }
    }
    
    @IBAction func tapRescheduleMenu(sender: UITapGestureRecognizer) {
        self.menuView.hidden = true
        self.rescheduleMenu.hidden = true
        self.listMenu.hidden = true
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.feedImageView.center.y -= 86
            }) { (Bool) -> Void in
                self.messageView.alpha = 1
                delay(0.5, closure: { () -> () in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.feedImageView.center.y += 86
                    })
                })
        }
    }
    
    @IBAction func tapListMenu(sender: UITapGestureRecognizer) {
        self.menuView.hidden = true
        self.rescheduleMenu.hidden = true
        self.listMenu.hidden = true
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.feedImageView.center.y -= 86
            }) { (Bool) -> Void in
                self.messageView.alpha = 1
                delay(0.5, closure: { () -> () in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.feedImageView.center.y += 86
                    })
                })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
