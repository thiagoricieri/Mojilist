//
//  Operators.swift
//  Emojilist
//
//  Created by Thiago Ricieri on 04/01/18.
//  Copyright © 2018 GhostShip. All rights reserved.
//

import Foundation

// MARK: - REGULAR EXPRESSIONS -
struct Regex {
	var pattern: String{
		didSet{
			//updateRegex()
		}
	}
	var expressionOptions: NSRegularExpression.Options{
		didSet{
			
		}
	}
	var matchingOptions: NSRegularExpression.MatchingOptions
	var regex : NSRegularExpression?
	init(pattern: String, expressionOptions: NSRegularExpression.Options, matchingOptions: NSRegularExpression.MatchingOptions) {
		self.pattern = pattern
		self.expressionOptions = expressionOptions
		self.matchingOptions = matchingOptions
	}
	init(pattern:String) {
		self.pattern = pattern
		expressionOptions = NSRegularExpression.Options(rawValue: 0)
		matchingOptions = NSRegularExpression.MatchingOptions(rawValue: 0)
	}
}

// MARK: - Operator for Comparing Regex -
precedencegroup ComparingRegexPrecedenceGroup {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}
infix operator =~ : ComparingRegexPrecedenceGroup
func =~ (left: String, right: Regex) -> Bool {
	let range: NSRange = NSMakeRange(0, left.count)
	if (right.regex != nil) {
		let matches:[AnyObject] = right.regex!.matches(in: left, options: right.matchingOptions, range: range)
		return matches.count > 0
	}
	return false
}
func =~(left: String, right: String) -> Bool {
	return left =~ Regex(pattern: right)
}

// MARK: - Operator for Replacing Regex -
precedencegroup ReplacingRegexPrecedenceGroup {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}
infix operator >< : ReplacingRegexPrecedenceGroup
func >< (left:String, right: (regex:Regex,template:String) ) -> String{
	if left =~ right.regex {
		let range: NSRange = NSMakeRange(0, left.count)
		if (right.regex.regex != nil) {
			return right.regex.regex!.stringByReplacingMatches(in: left, options: right.regex.matchingOptions, range: range, withTemplate: right.template)
		}
	}
	return left
}
func >< (left:String, right: (pattern:String,template:String) ) -> String{
	return left >< (Regex(pattern: right.pattern),right.template)
}
