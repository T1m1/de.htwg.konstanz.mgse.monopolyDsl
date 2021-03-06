/*
 * generated by Xtext 2.9.1
 */
package de.htwg.konstanz.de.mgse.monopolyDsl.validation

import org.eclipse.xtext.validation.Check
import de.htwg.konstanz.de.mgse.monopolyDsl.monopolyDSL.Game
import de.htwg.konstanz.de.mgse.monopolyDsl.monopolyDSL.MonopolyDSLPackage
import de.htwg.konstanz.de.mgse.monopolyDsl.monopolyDSL.Field
import de.htwg.konstanz.de.mgse.monopolyDsl.monopolyDSL.Property

/**
 * This class contains custom validation rules. 
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class MonopolyDSLValidator extends AbstractMonopolyDSLValidator {

	public static val INVALID_NAME = 'invalidName'

	@Check
	def void checkDescriptionIsNotEmpty(Field field) {
		if (field.description.isEmpty) {
			warning("description cannot be empty", MonopolyDSLPackage.Literals.FIELD__DESCRIPTION);
		}
	}

	@Check
	def void checkNameStartsWithCapital(Field field) {
		if (!Character::isUpperCase(field.getName().charAt(0))) {
			warning("Name should start with a capital", MonopolyDSLPackage.Literals.FIELD__NAME, INVALID_NAME);
		}
	}

	@Check
	def void checkLogicalProperties(Field field) {
		if (field.property.empty) {
			error("Required parameters 'type' & 'position' missing!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
		} else {

			var boolean type
			var boolean position
			var boolean rent
			var boolean name
			var boolean color
			var boolean price
			var boolean soldStatus
			var boolean action

			for (var i = 0; i < field.property.length; i++) {
				if (field.property.get(i).type == "type") {
					if (type) {
						warning("Duplicate parameter 'type'!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
					}
					type = true
				}
				if (field.property.get(i).position == "position") {
					if (position) {
						warning("Duplicate parameter 'position'!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
					}
					position = true
				}
				if (field.property.get(i).rent == "rent") {
					if (rent) {
						warning("Duplicate parameter 'rent'!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
					}
					rent = true
				}
				if (field.property.get(i).position == "name") {
					if (name) {
						warning("Duplicate parameter 'name'!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
					}
					name = true
				}
				if (field.property.get(i).color == "color") {
					if (color) {
						warning("Duplicate parameter 'color'!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
					}
					color = true
				}
				if (field.property.get(i).price == "price") {
					if (price) {
						warning("Duplicate parameter 'price'!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
					}
					price = true
				}
				if (field.property.get(i).soldStatus == "soldStatus") {
					if (soldStatus) {
						warning("Duplicate parameter 'soldStatus'!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
					}
					soldStatus = true
				}
				if (field.property.get(i).action == "action") {
					if (action) {
						warning("Duplicate parameter 'action'!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
					}
					action = true
				}
			}

			if (!price && soldStatus || !price && rent) {
				error("Parameter 'price' missing!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
			}

			if (!type) {
				error("Parameter 'type' required!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
			}

			if (!position) {
				error("Parameter 'position' required!", MonopolyDSLPackage.Literals.FIELD__PROPERTY);
			}
		}

	}

	@Check
	def void blabla(Property property) {
	}
}
