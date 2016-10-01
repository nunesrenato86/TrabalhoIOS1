//
//  Campeonato+CoreDataClass.swift
//  ProjetoCampeonatos
//
//  Created by iossenac on 24/09/16.
//  Copyright © 2016 Renato Nunes de Nunes. All rights reserved.
//

import Foundation
import CoreData


public class Campeonato: NSManagedObject {
    
    class func createWith(nome: String,
                          parceiro: String,
                          local: String,
                          categoria: String,
                          datainicio: String,
                          datafim: String,
                          in context: NSManagedObjectContext) -> Campeonato?
    {
        let request = NSFetchRequest<Campeonato>(entityName: "Campeonato")
        let query = "nome == %@ and parceiro == %@ and local == %@ and categoria == %@ and datainicio == %@ and datafim == %@"
        let params:[Any] = [nome,parceiro,local,categoria,datainicio, datafim]
        request.predicate = NSPredicate(format: query, argumentArray: params)
        
        if let campeonato = (try? context.fetch(request))?.first { // Note the (try?), it bugged.
            print("Found campeonato: \(campeonato)")
            return campeonato
        } else if let campeonato = NSEntityDescription.insertNewObject(forEntityName: "Campeonato", into: context) as? Campeonato
        {
            print("Created campeonato: \(campeonato)")
            campeonato.nome = nome
            campeonato.parceiro = parceiro
            campeonato.local = local
            campeonato.categoria = categoria
            campeonato.datainicio = datainicio
            campeonato.datafim = datafim
            return campeonato
        } else {
            print("No campeonato object.")
        }
        /*
         do {
         // swift 2.2
         let result = try context.executeFetchRequest(request)
         // Swift 2.2
         if let turma = resuld.first as? Turma
         return turma
         }
         } catch let error {
         
         }
         */
        
        return nil
    }
    
}
