//
//  CampeonatoTableViewController.swift
//  ProjetoCampeonatos
//
//  Created by iossenac on 24/09/16.
//  Copyright © 2016 Renato Nunes de Nunes. All rights reserved.
//

import UIKit
import CoreData

class CampeonatoTableViewController: CoreDataTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.splitViewController?.delegate = self

        let request = NSFetchRequest<NSManagedObject>(entityName: "Campeonato")
        request.sortDescriptors = [
            NSSortDescriptor(key:"nome", ascending: false)//,
            //NSSortDescriptor(key:"semestre", ascending: false),
            //NSSortDescriptor(key:"diaSemana", ascending: true),
            //NSSortDescriptor(key:"disciplina", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))),
        ]
        
        // TODO: his part should go to CoreDataTableViewController.
        if let context = managedObjectContext {
            fetchedResultsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: "categoria",
                cacheName: nil)
        } else {
            fetchedResultsController = nil
        }
    }

    // MARK: - Table view data source
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let campeonato = fetchedResultsController?.object(at: indexPath) as? Campeonato {
//            var (curso, disciplina) = ("","")
//            turma.managedObjectContext?.performAndWait {
//                let c = turma.curso ?? "-"
//                let i = turma.instituicao ?? "-"
//                curso = "\(i) / \(c)"
//                disciplina = turma.disciplina ?? "-*-"
//            }
//            cell.textLabel?.text = disciplina
//            cell.detailTextLabel?.text = curso
            
            var (nome, local) = ("","")
            campeonato.managedObjectContext?.performAndWait {
                nome = campeonato.nome ?? "-*-"
                local = campeonato.local ?? "-*-"
            }
            cell.textLabel?.text = nome
            cell.detailTextLabel?.text = local
            
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("identificador: " + segue.identifier!)
        
     //   if segue.identifier == "segueEditar" {
     //       if let navcon = segue.destination as? UINavigationController {
     //           if let detail = navcon.visibleViewController as? DetailCampeonatoController,
     //               let indexPath = tableView.indexPathForSelectedRow
     //           {
     //               detail.campeonato = fetchedResultsController?.object(at: indexPath) as? Campeonato
     //           }
     //       }
     //   }
        
        
        if segue.identifier == "segueEditar" {
            if let navcon = segue.destination as? DetailCampeonatoController {
                if let indexPath = tableView.indexPathForSelectedRow
                {
                    navcon.campeonato = fetchedResultsController?.object(at: indexPath) as? Campeonato
                }
            }
        } else if segue.identifier == "segueAdicionar" {
            if let navcon = segue.destination as? DetailCampeonatoController {
                navcon.campeonato = nil
            }
        }
    }
    
    @IBAction func unwindToCampeonatoList(sender: UIStoryboardSegue) {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    

}
