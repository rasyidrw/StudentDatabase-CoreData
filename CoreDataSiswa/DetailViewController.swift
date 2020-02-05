//
//  DetailViewController.swift
//  CoreDataSiswa
//
//  Created by Rasyid Respati Wiriaatmaja on 04/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var detailNama: UILabel!
    @IBOutlet weak var detailAsal: UILabel!
    @IBOutlet weak var detailGender: UILabel!
    @IBOutlet weak var detailJenjang: UILabel!
    @IBOutlet weak var detailHobi: UILabel!
    
    var dataNama : String?
    var dataAsal : String?
    var dataGender : String?
    var dataJenjang : String?
    var dataHobi : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailNama.text = dataNama
        detailAsal.text = dataAsal
        detailGender.text = dataGender
        detailJenjang.text = dataJenjang
        detailHobi.text = dataHobi
        
        if dataGender == "Pria" {
            imgDetail.image = UIImage(named: "male_icon")
        } else {
            imgDetail.image = UIImage(named: "female_icon")
        }
        
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
