//
//  ViewController.swift
//  createCSVfile
//
//  Created by humberto Lima on 24/11/18.
//  Copyright © 2018 humberto Lima. All rights reserved.
//

import UIKit
import MessageUI


class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func geraCSV(_ sender: UIButton) {
        
        let fileName = "teste.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)!
        
        let Stringteste = "Texto Variavel"
        
        var csvText = "Coluna1,Coluna2,Coluna3,\(Stringteste),String Fixa,123\n"

            for i in 1...10 {
                let newLine = "Linha \(i),Linha \(i),Linha \(i), Fixa,Linha \(i),Linha \(i),\n"
                csvText.append(contentsOf: newLine)
            }

            do {
                try csvText.write(to: path, atomically: true, encoding: String.Encoding.utf8)
                
                
                if MFMailComposeViewController.canSendMail() {
                    let emailController = MFMailComposeViewController()
                    emailController.mailComposeDelegate = self
                    emailController.setToRecipients([])
                    emailController.setSubject("Assunto do e-mail")
                    emailController.setMessageBody("Mensagem do texto para enviar \n linha2 \n linha3", isHTML: false)
                    
                    emailController.addAttachmentData(NSData(contentsOf: path)! as Data, mimeType: "text/csv", fileName: "teste.csv")
                    
                    present(emailController, animated: true, completion: nil)
                }
                
            } catch {
                
                print("Erro ao criar arquivo")
                print("\(error)")
            }
    }
    
    @IBAction func exportaRelatorio(_ sender: UIButton) {
        
        let image = UIImage(named: "image")
        
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

