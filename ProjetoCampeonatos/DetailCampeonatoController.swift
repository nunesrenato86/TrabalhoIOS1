//
//  ViewController.swift
//  ProjetoCampeonatos
//
//  Created by iossenac on 24/09/16.
//  Copyright © 2016 Renato Nunes de Nunes. All rights reserved.
//

import UIKit
import CoreData

class DetailCampeonatoController: UIViewController {
    
    weak var campeonato: Campeonato? {
        didSet {
            updateUI()
        }
    }
    
    var managedObjectContext =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    
    @IBOutlet weak var edtNome: UITextField!
    @IBOutlet weak var edtParceiro: UITextField!
    @IBOutlet weak var edtLocal: UITextField!
    @IBOutlet weak var edtDatainicio: UITextField!
    @IBOutlet weak var edtDatafim: UITextField!
    @IBOutlet weak var edtCategoria: UITextField!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let campeonato = self.campeonato {
            //currentYear = Int(turma.ano)
            edtNome?.text = campeonato.nome
            edtParceiro?.text = campeonato.parceiro
            edtCategoria?.text = campeonato.categoria
            edtLocal?.text = campeonato.local
            edtDatainicio?.text = campeonato.datainicio //formatTime(campeonato.datainicio!)
            edtDatafim?.text = campeonato.datafim //formatTime(campeonato.datafim!)
        }
    
    }
    
    func formatTime(_ date: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter.string(from: date as Date)
    }
    
    func formatDate(_ date: NSDate) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .short
        return formatter.string(from: date as Date)
    }

    @IBAction func btnSaveClick(_ sender: AnyObject) {
        // update database
        if  let context = managedObjectContext {
            
            context.performAndWait {
                self.updateCampeonato()
                do {
                    try self.campeonato?.managedObjectContext!.save()
                } catch let error {
                    print("Core Data error: \(error)")
                }
            }
        } else {
            // TODO: Handle errors
            print("Failed to get Managed Object Context.")
        }
        // get back to previous scene
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func updateCampeonato() {
        if let context = managedObjectContext {
            if  let nome = edtNome.text,
                let parceiro = edtParceiro.text,
                let categoria = edtCategoria.text,
                let local = edtLocal.text,
                let datainicio = edtDatainicio.text,
                let datafim = edtDatafim.text
                
                
            {
                //let ano = Int(stepper.value)
                //let semestre = semestreSelector.selectedSegmentIndex + 1
                // gregorian calendar uses 1 for Sunday, 2 for monday
                // we use 0 for monday, 6 for sunday
                //let si = diaSemanaSelector.selectedSegmentIndex
                //let diaDaSemana = (si + 1) % 7 + 1
                
                // String to a NSDate
                let dateFormatter = DateFormatter()
                //let dateString = "20/03/2016"
                dateFormatter.dateFormat = "dd/MM/yyyy"
                dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
                //let dateIniFromString = dateFormatter.date(from: datainicio)
                //let dateFimFromString = dateFormatter.date(from: datafim)
                
                
                if campeonato == nil {
                    campeonato = Campeonato.createWith(nome: nome,
                                                       parceiro: parceiro,
                                                       local: local,
                                                       categoria: categoria,
                                                       datainicio: datainicio,//(dateIniFromString as NSDate?)!,
                                                       datafim: datafim,//(dateFimFromString as NSDate?)!,
                                                       in: context)
                } else {
                    campeonato?.nome = nome
                    campeonato?.parceiro = parceiro
                    campeonato?.categoria = categoria
                    campeonato?.local = local
                    campeonato?.datainicio = datainicio//dateIniFromString as NSDate?
                    campeonato?.datafim = datafim//dateFimFromString as NSDate?
                }
            }
        }
    }
    
    
    @IBAction func btnCalcelClick(_ sender: AnyObject) {
        
        // get back to previous scene
        _ = self.navigationController?.popViewController(animated: true)
  
    }
    
    
}

