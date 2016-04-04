//
//  DetalhesProjetoViewController.swift
//  swift-radar-político
//
//  Created by Ulysses on 4/1/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class DetalhesProposicaoViewController: UITableViewController {

    @IBOutlet weak var tituloProposicaoLabel: UILabel!
    
    @IBOutlet weak var autorImage: UIImageView!
    
    @IBOutlet weak var autorNomeLabel: UILabel!
    
    @IBOutlet weak var autorPartidoLabel: UILabel!
    
    @IBOutlet weak var lerProjetoButton: UIButton!
    
    private var proposicao:CDProposicao?
    private let sections = ["Detalhes","Votacoes"]
    
    func loadProposicao(proposicao:CDProposicao){
        self.proposicao = proposicao
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tituloProposicaoLabel.text = proposicao?.nome
        self.tableView.reloadData()
    }


    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return calcNumberOfRows()
        }
        return  0
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetalheCell", forIndexPath: indexPath) as! DetalheCell

        let font = UIFont.systemFontOfSize(11)
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = NSLineBreakMode.ByWordWrapping
        var size:CGSize?
        
        let itemData = getNextDetailItem(indexPath.row)
        
        cell.infoLabel?.text = itemData.0
        cell.dataText.text = itemData.1
        
        return cell
    }
    
    private func calcNumberOfRows()->Int{
        var numberOfRows:Int = 0
        numberOfRows += proposicao?.tema.isEmpty == true ? 0 : 1
        numberOfRows += proposicao?.ementa.isEmpty == true ? 0 : 1
        numberOfRows += proposicao?.explicacaoEmenta.isEmpty == true ? 0 : 1
        numberOfRows += proposicao?.indexacao.isEmpty == true ? 0 : 1
        
        return numberOfRows
    }
    
    private func getNextDetailItem(index:Int)->(String,String){
        let infoRaw = ["Tema","Ementa","Explicação Ementa","Indexação"]
        let dataRaw = [proposicao?.tema,proposicao?.ementa,proposicao?.explicacaoEmenta,proposicao?.indexacao].filter { (value) -> Bool in
            return !value!.isEmpty
        }
        return (infoRaw[index],dataRaw[index]!)
    }

   }
