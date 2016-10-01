//
//  Campeonato+CoreDataProperties.swift
//  ProjetoCampeonatos
//
//  Created by iossenac on 24/09/16.
//  Copyright © 2016 Renato Nunes de Nunes. All rights reserved.
//

import Foundation
import CoreData


extension Campeonato {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Campeonato> {
        return NSFetchRequest<Campeonato>(entityName: "Campeonato");
    }

    @NSManaged public var nome: String?
    @NSManaged public var parceiro: String?
    @NSManaged public var categoria: String?
    @NSManaged public var datainicio: String?
    @NSManaged public var datafim: String?
    @NSManaged public var local: String?

}
