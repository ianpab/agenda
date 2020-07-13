//
//  CalculaMediaAPI.swift
//  Agenda
//
//  Created by Ian Pablo on 01/09/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit

class CalculaMediaAPI: NSObject {

    func CalculaMediaGeralAlunos(alunos:Array<Aluno>, sucesso:@escaping(_ dicionarioDeMedia:Dictionary<String, Any>) -> Void, falha:@escaping(_ error:Error) -> Void){
        // cria as variaveis
        guard  let url = URL(string: "https://www.caelum.com.br/mobile") else { return }
        var listaDeAluno:Array<Dictionary<String, Any >> = []
        var json:Dictionary<String, Any> = [:]
        
        for aluno in alunos{
            
            guard let nome = aluno.nome else { break }
            guard let endereco = aluno.endereco else { break }
            guard let telefone = aluno.telefone else { break }
            guard let site = aluno.site else { break }
            
            // cria o conteudo do json
            let dicionarioDeAlunos = [
                "id" : "\(aluno.objectID)",
                "nome" : "\(nome)",
                "endereco" : "\(endereco)",
                "telefone" : "\(telefone)",
                "site" : "\(site)",
                "nota" : String(aluno.nota)
            ]
            // add o conteudo ao Dicionario Array
            listaDeAluno.append(dicionarioDeAlunos as [String:Any])

        }
        

        // cria a estrutura do json
        json = [
            "list" : [
                [ "aluno" : listaDeAluno  ]
            ]
        ]
        
        // faz a requisicao
        do {
            var requisicao = URLRequest(url: url)
           let data = try JSONSerialization.data(withJSONObject: json, options: [])
            requisicao.httpBody = data
            requisicao.httpMethod = "POST"
            requisicao.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: requisicao) { (data, response, error) in
                if error == nil{
                    do{
                        let dicionario = try JSONSerialization.jsonObject(with: data!, options: [])  as! Dictionary<String, Any>
                        sucesso(dicionario)
                    }catch{
                        falha(error)
                    }
                }
            }
            task.resume()
        }catch{
            print(error.localizedDescription)
        }

    }
    
}
