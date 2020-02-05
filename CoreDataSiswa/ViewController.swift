//
//  ViewController.swift
//  CoreDataSiswa
//
//  Created by Rasyid Respati Wiriaatmaja on 04/02/20.
//  Copyright © 2020 rasyidrw. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var tfNama: UITextField!
    @IBOutlet weak var tfAsal: UITextField!
    @IBOutlet weak var pvJenisKelamin: UIPickerView!
    @IBOutlet weak var pvJenjang: UIPickerView!
    @IBOutlet weak var swMenggambar: UISwitch!
    @IBOutlet weak var swMembaca: UISwitch!
    @IBOutlet weak var swMenulis: UISwitch!
    
    var jenisKelamin = ["Pria", "Wanita"]
    var jenjang = ["TK", "SD", "SMP", "SMA"]
    
    var siswa : Siswa? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pvJenisKelamin.delegate = self
        pvJenisKelamin.dataSource = self
        
        pvJenjang.delegate = self
        pvJenjang.dataSource = self
        
        if siswa != nil {
            self.title = "Edit Data"
            terimaData()
        }
        
    }
    
    func terimaData(){
        
        tfNama.text = siswa?.nama
        tfAsal.text = siswa?.asal
        
        //ambil index jenis kelamin
        let indexJenisKelamin = jenisKelamin.firstIndex(of: siswa!.jenisKelamin!)
        pvJenisKelamin.selectRow(indexJenisKelamin!, inComponent: 0, animated: true)
        
        //ambil index jenjang
        let indexJenjang = jenjang.firstIndex(of: siswa!.jenjang!)!
        pvJenjang.selectRow(indexJenjang, inComponent: 0, animated: true)
        
        if (siswa?.hobi?.contains("Menggambar"))! {
            swMenggambar.isOn = true
        }
        
        if (siswa?.hobi?.contains("Membaca"))! {
            swMembaca.isOn = true
        }
        
        if (siswa?.hobi?.contains("Menulis"))! {
            swMenulis.isOn = true
        }
        
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        let nama = tfNama.text
        let asal = tfAsal.text
        let jenisKl = jenisKelamin[pvJenisKelamin.selectedRow(inComponent: 0)]
        let jnjg = jenjang[pvJenjang.selectedRow(inComponent: 0)]
        
        var hobi = [String]()
        
        if swMenggambar.isOn {
            hobi.append("Menggambar")
        }
        if swMembaca.isOn {
            hobi.append("Membaca")
        }
        if swMenulis.isOn {
            hobi.append("Menulis")
        }
        
        let hobies = hobi.joined(separator: ", ")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //cek data, edit atau tambah
        if siswa == nil {
            siswa = Siswa(context: context)
        }
        
        //set data ke core data
        siswa?.nama = nama
        siswa?.asal = asal
        siswa?.jenisKelamin = jenisKl
        siswa?.jenjang = jnjg
        siswa?.hobi = hobies
        
        //simpan ke core data
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        //tampilkan alert
        let alert = UIAlertController(title: "Info", message: "Berhasil disimpan!", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
            self.navigationController?.popToRootViewController(animated: true)
        })
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        let tag = pickerView.tag
        
        if tag == 1{
            return jenisKelamin.count
        } else {
            return jenjang.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let tag = pickerView.tag
        
        if tag == 1 {
            return jenisKelamin[row]
        } else {
            return jenjang[row]
        }
    }
    
    
    
}

