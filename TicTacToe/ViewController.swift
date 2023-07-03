//
//  ViewController.swift
//  TicTacToe
//
//  Created by CallumHill on 30/7/21.
//

import UIKit

class ViewController: UIViewController
{
	enum Turn {
		case Nought
		case Cross
	}
	
	@IBOutlet weak var turnLabel: UILabel!

    @IBOutlet var Cells : [UIButton]!
    
	var firstTurn = Turn.Cross
	var currentTurn = Turn.Cross
	var NOUGHT = "O"
	var CROSS = "X"
	
	var noughtsScore = 0
	var crossesScore = 0
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
	}
	

	@IBAction func boardTapAction(_ sender: UIButton)
	{
		addToBoard(sender)
		
		if checkForVictory(CROSS)
		{
			crossesScore += 1
			resultAlert(title: "Crosses Win!")
		}
		
		if checkForVictory(NOUGHT)
		{
			noughtsScore += 1
			resultAlert(title: "Noughts Win!")
		}
		
		if(fullBoard())
		{
			resultAlert(title: "Draw")
		}
	}
	
    func checkForVictory(_ s :String) -> Bool
        {
            // Horizontal Victory
            if thisSymbol(Cells[0], s) && thisSymbol(Cells[1], s) && thisSymbol(Cells[2], s)
            {
                return true
            }
            if thisSymbol(Cells[3], s) && thisSymbol(Cells[4], s) && thisSymbol(Cells[5], s)
            {
                return true
            }
            if thisSymbol(Cells[6], s) && thisSymbol(Cells[7], s) && thisSymbol(Cells[8], s)
            {
                return true
            }
            
            // Vertical Victory
            if thisSymbol(Cells[0], s) && thisSymbol(Cells[3], s) && thisSymbol(Cells[6], s)
            {
                return true
            }
            if thisSymbol(Cells[1], s) && thisSymbol(Cells[4], s) && thisSymbol(Cells[7], s)
            {
                return true
            }
            if thisSymbol(Cells[2], s) && thisSymbol(Cells[5], s) && thisSymbol(Cells[8], s)
            {
                return true
            }
            
            // Diagonal Victory
            if thisSymbol(Cells[0], s) && thisSymbol(Cells[4], s) && thisSymbol(Cells[8], s)
            {
                return true
            }
            if thisSymbol(Cells[2], s) && thisSymbol(Cells[4], s) && thisSymbol(Cells[6], s)
            {
                return true
            }
            
            return false
        }
	func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool
	{
		return button.title(for: .normal) == symbol
	}
	
	func resultAlert(title: String)
	{
		let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
		let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
		ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
			self.resetBoard()
		}))
		self.present(ac, animated: true)
	}
	
	func resetBoard()
	{
		for i in Cells
		{
			i.setTitle(nil, for: .normal)
			i.isEnabled = true
		}
		if firstTurn == Turn.Nought
		{
			firstTurn = Turn.Cross
			turnLabel.text = CROSS
		}
		else if firstTurn == Turn.Cross
		{
			firstTurn = Turn.Nought
			turnLabel.text = NOUGHT
		}
		currentTurn = firstTurn
	}
	
	func fullBoard() -> Bool
	{
		for j in Cells
		{
			if j.title(for: .normal) == nil
			{
				return false
			}
		}
		return true
	}
	
	func addToBoard(_ sender: UIButton)
	{
		if(sender.title(for: .normal) == nil)
		{
			if(currentTurn == Turn.Nought)
			{
				sender.setTitle(NOUGHT, for: .normal)
				currentTurn = Turn.Cross
				turnLabel.text = CROSS
			}
			else if(currentTurn == Turn.Cross)
			{
				sender.setTitle(CROSS, for: .normal)
				currentTurn = Turn.Nought
				turnLabel.text = NOUGHT
			}
			sender.isEnabled = false
		}
	}
	
}

