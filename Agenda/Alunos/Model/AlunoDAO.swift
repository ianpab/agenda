//
//  AlunoDAO.swift
//  Agenda
//
//  Created by Ian Pablo on 13/10/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import CoreData


class AlunoDAO: NSObject {
    
    var gerenciadorDeResultados:NSFetchedResultsController<Aluno>? // LE TODO O BD

    
    // contexto para acessar o BD
      var contexto:NSManagedObjectContext{
          let appDelegate = UIApplication.shared.delegate as! AppDelegate
          return appDelegate.persistentContainer.viewContext
      }
    
    func recuperaAlunos() -> Array<Aluno>{
        let pesquisaAluno:NSFetchRequest<Aluno> = Aluno.fetchRequest()
        let ordenarPorNome = NSSortDescriptor(key: "nome", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenarPorNome]
        
        gerenciadorDeResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)

        do{
        try gerenciadorDeResultados?.performFetch()
        }catch{
            print(error.localizedDescription)
        }
        guard let listaDeAlunos = gerenciadorDeResultados?.fetchedObjects else { return [] }
        return listaDeAlunos
        
    }

    func salvarAluno(dicionarioDeAluno:Dictionary<String, Any>){
        
        var aluno:NSManagedObject?
        
        guard let id = UUID(uuidString: dicionarioDeAluno["id"] as! String) else { return }
        let alunos = recuperaAlunos().filter() { $0.id == id}
        //VERIFICA SE IRA CRIAR CADASTRO OU ATUALIZAR

        if alunos.count > 0 {
            guard let alunoExistente =  alunos.first else { return }
            aluno = alunoExistente
        }else{
            let entidade = NSEntityDescription.entity(forEntityName: "Aluno", in: contexto)
            aluno = NSManagedObject.init(entity: entidade!, insertInto: contexto)
        }
        
//        aluno.id = id
//        aluno.nome = dicionarioDeAluno["nome"] as? String
//        aluno.endereco = dicionarioDeAluno["endereco"] as? String
//        aluno.site = dicionarioDeAluno["site"] as? String
//        aluno.telefone = dicionarioDeAluno["telefone"] as? String
        // Setar valor nas variaveis
        aluno?.setValue(id, forKey: "id")
        aluno?.setValue(dicionarioDeAluno["nome"] as? String, forKey: "nome")
        aluno?.setValue(dicionarioDeAluno["endereco"] as? String, forKey: "endereco")
        aluno?.setValue(dicionarioDeAluno["site"] as? String, forKey: "site")
        aluno?.setValue(dicionarioDeAluno["telefone"] as? String, forKey: "telefone")

        guard let nota = dicionarioDeAluno["nota"] else { return }
        if (nota is String){
            aluno?.setValue((dicionarioDeAluno["nota"] as! NSString).doubleValue, forKey: "nota")
        }
        else{
            let conversaoDeNota = String(describing: nota)
            aluno?.setValue((conversaoDeNota as NSString).doubleValue, forKey: "nota")
        }
        atualizaContexto()
        
    }
    
    func deletaAluno(aluno:Aluno){
        contexto.delete(aluno)
        atualizaContexto()
        
    }
    
    func atualizaContexto(){
        do{
            try contexto.save()
            }catch{
                  print(error.localizedDescription)
               }
    }
}
