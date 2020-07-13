//
//  Safari.swift
//  Agenda
//
//  Created by Ian Pablo on 03/11/19.
//  Copyright © 2019 Alura. All rights reserved.
//

import UIKit
import SafariServices


class Safari: NSObject {
    
    func abrirPaginaWeb(_ alunoSelecionado:Aluno, controller:UIViewController){
        if let urlDoAluno = alunoSelecionado.site{

            var urlFormatada = urlDoAluno
            if !urlFormatada.hasPrefix("http://"){
                urlFormatada = String(format: "http://%@", urlFormatada)
            }
            guard let urlAluno = URL(string: urlFormatada) else  { return }
          //  UIApplication.shared.open(urlAluno, options: [:], completionHandler: nil)
            let safariViewControlle = SFSafariViewController(url: urlAluno)
            controller.present(safariViewControlle, animated: true, completion: nil)

        }
    }

}
