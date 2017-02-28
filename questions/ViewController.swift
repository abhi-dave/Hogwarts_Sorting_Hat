//
//  ViewController.swift
//  questions
//
//  Created by Abhishek Dave on 09/02/17.
//  Copyright © 2017 Abhishek Dave. All rights reserved.
//

import UIKit

struct Questions {
    var questionString: String?
    var answers: [String]?
    var selectedAnsIndex: Int?
}

var questionList: [Questions] = [Questions.init(questionString: "What is your Favorite Animal?", answers: ["Snake","Lion","Eagle","Dog"],selectedAnsIndex: nil),Questions.init(questionString: "What is your Favorite Color?", answers: ["Green","Red","Blue","Yellow"], selectedAnsIndex: nil),Questions.init(questionString: "Fav House?", answers: ["Slytherin","Gryffindor","Ravenclaw","HufflePuff"], selectedAnsIndex: nil)]

class QuestionViewController: UITableViewController {
    
    let cellId = "cellId"
    let headerId = "headerId"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Question"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        tableView.register( AnswerCell.self, forCellReuseIdentifier: cellId)
        tableView.register( HeaderCell.self , forHeaderFooterViewReuseIdentifier: headerId)
        
        tableView.sectionHeaderHeight = 50
        tableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let index = navigationController?.viewControllers.index(of: self){
            let question = questionList[index]
            if let count = question.answers?.count{
                return count
            }
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header =  tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! HeaderCell
        
        if let index = navigationController?.viewControllers.index(of: self){
            let question = questionList[index]
            header.namelabel.text = question.questionString
            //return header
        }
            return header
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnswerCell
        
        if let index = navigationController?.viewControllers.index(of: self){
            let question = questionList[index]
            cell.anslabel.text = question.answers?[indexPath.row]
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        if let index = navigationController?.viewControllers.index(of: self){
            questionList[index].selectedAnsIndex = indexPath.row
            
            if index < questionList.count - 1 {
                let controller = QuestionViewController()
                self.navigationController?.pushViewController(controller, animated: true)
            }
            else
            {
            let controller = ResultView()
            self.navigationController?.pushViewController(controller, animated: true)
        }
        }
    }
}
class HeaderCell: UITableViewHeaderFooterView{

    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let namelabel: UILabel = {
       let label = UILabel()
       label.text = "Header"
       label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    func setupView(){
    
      addSubview(namelabel)
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": namelabel]))
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": namelabel]))
    
    }
    
}
class ResultView: UIViewController{

    var score = 0

    let namelabel: UILabel = {
        let label = UILabel()
        label.text = "You are Slytherin"
        label.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var bgImage : UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Result"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Restart", style: .plain, target: self, action: #selector(done))
       // navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: "done")
        view.addSubview(namelabel)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":namelabel]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":namelabel]))

        let names = ["Slytherin","Gryffindor","RavenClaw","Hufflepuff"]
        
        for question in questionList{
            score += question.selectedAnsIndex!
        
        }
    
 
        func tempfunc(house:String){
            
            let image: UIImage = UIImage(named: house)!
            bgImage = UIImageView(image: image)
            bgImage!.frame = CGRect(x: 115, y: 150, width: 150 , height: 150)
            
            self.view.addSubview(bgImage!)
        }

        let result = names[score % names.count]
        
        func resultshow(){
            namelabel.text = "You are \(result)"
        }
        if result == "Gryffindor"{
            resultshow()
            tempfunc(house: "Gryffindor.jpg")
            namelabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        }
        if result == "Hufflepuff"{
            
            resultshow()
            tempfunc(house: "Hufflepuff.jpg")
            namelabel.textColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)

        }
        if result == "Slytherin"{
            resultshow()
            tempfunc(house: "Slytherin.jpg")
            namelabel.textColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        }
        if result == "RavenClaw"{
            resultshow()
            tempfunc(house: "Ravenclaw.jpg")
            namelabel.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }

    }
    

    func done(){
        print(score)
        _ = navigationController?.popToRootViewController(animated: true)
        
    }

}
class AnswerCell: UITableViewCell{

    override init(style:UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let anslabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    
    }()

    func setupView(){
        addSubview(anslabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat:"H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":anslabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":anslabel]))
        
    
    
    }


}
