/*
 * generated by Xtext 2.9.1
 */
package de.htwg.konstanz.de.mgse.monopolyDsl.ui.quickfix

import org.eclipse.xtext.ui.editor.quickfix.DefaultQuickfixProvider
import de.htwg.konstanz.de.mgse.monopolyDsl.validation.MonopolyDSLValidator
import org.eclipse.xtext.validation.Issue
import org.eclipse.xtext.ui.editor.quickfix.Fix
import org.eclipse.xtext.ui.editor.quickfix.IssueResolutionAcceptor

/**
 * Custom quickfixes.
 *
 * See https://www.eclipse.org/Xtext/documentation/304_ide_concepts.html#quick-fixes
 */
class MonopolyDSLQuickfixProvider extends DefaultQuickfixProvider {

	@Fix(MonopolyDSLValidator.INVALID_NAME)
	def capitalizeName(Issue issue, IssueResolutionAcceptor acceptor) {
		acceptor.accept(issue, 'Capitalize name', 'Capitalize the name.', 'upcase.png') [
			context |
			val xtextDocument = context.xtextDocument
			val firstLetter = xtextDocument.get(issue.offset, 1)
			xtextDocument.replace(issue.offset, 1, firstLetter.toUpperCase)
		]
	}
}