/*
 * generated by Xtext 2.9.1
 */
package de.htwg.konstanz.de.mgse.monopolyDsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import de.htwg.konstanz.de.mgse.monopolyDsl.monopolyDSL.Game
import de.htwg.konstanz.de.mgse.monopolyDsl.monopolyDSL.Field
import org.eclipse.emf.common.util.EList
import de.htwg.konstanz.de.mgse.monopolyDsl.monopolyDSL.Property;

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MonopolyDSLGenerator extends AbstractGenerator {

	val gameType = "monopoly"
	val typeClass = "FieldType"
	val fieldInterface = "IField"

	String gameName

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {

		val game = resource.contents.head as Game

		gameName = game.name

		val fields = game.fields

		if (!fields.isEmpty) {
			// generate an Interface if there are fields
			fsa.generateFile(fieldInterface + ".java", generateInterface())

			// generate Enum class for fieldTypes
			fsa.generateFile(typeClass + ".java", generateFieldTypes(fields, game))
		}

		for (field : fields) {
			// create a class for each field
			val class = generateClass(field)
			fsa.generateFile(field.name.toFirstUpper + ".java", class)
		}
	}

	/**
	 * Generate field enums
	 */
	def generateFieldTypes(EList<Field> list, Game game) '''
		�createPackage()�
		
		
		/**
		 * These enums represent the different types of a certain field in monopoly.
		 * 
		 */
		public enum �typeClass� {
		
		�FOR field : list BEFORE "" SEPARATOR "," AFTER ""�
			/**
			 * �field.description�
			 */
			�field.name.toUpperCase�
			
		�ENDFOR�
		}
		
	'''

	def generateInterface() '''
		�createPackage()�
		
		�createImportOf(gameType)�
		
		
		public interface �fieldInterface� {
			
			/**
			 * return the position of the field
			 * @return integer 
			 */
			int getPosition();
			
			/**
			 * Return the type of this field. For example: Street, train station etc.
			 * @return enum
			 */
			�typeClass� getType();
		}
		
	'''

	def generateClass(Field field) '''
		�createPackage()�
		
		�createImportOf(fieldInterface)�
		�createImportOf(typeClass)�
		
		public class �field.name� implements �fieldInterface� {
			
			�createOptionalFields(field.property)�
			
			// hide default constructor
			private �field.name.toFirstUpper�() {}
			
			/**
			 * Constructor for �field.name� field in Monopoly
			 */
			�createConstructor(field.name.toFirstUpper, field.property)�
			
			
			�createGetter(field.property)�
			
			�createSetter(field.property)�
		
			@Override
			public String toString() {
				return "�field.name�";
			}	
		}
	'''

	def createSetter(EList<Property> properties) '''
		�FOR property : properties BEFORE "" SEPARATOR "\n" AFTER ""�
			public void set�getPropertyNameOf(property)�(�getTypeOf(property)�) {
				this.�getPropertyNameOf(property)� = �getPropertyNameOf(property)�;
				}
				�ENDFOR�	
	'''

	def createGetter(EList<Property> properties) '''
		�FOR property : properties BEFORE "" SEPARATOR "\n" AFTER ""�
			public �getOnlyTypeOf(property)� get�getPropertyNameOf(property)�() {
				return this.�getPropertyNameOf(property)�;
				}
		�ENDFOR�				
	'''

	def createConstructor(String name,
		EList<Property> properties) '''
		public �name��FOR property : properties BEFORE "(" SEPARATOR "," AFTER ")"��getTypeOf(property)��ENDFOR� {
					�FOR property : properties BEFORE "" SEPARATOR ";" AFTER ";"�
						this.�getPropertyNameOf(property)� = �getPropertyNameOf(property)�
					�ENDFOR�
				}
	'''

	def createOptionalFields(EList<Property> properties) '''
		�FOR property : properties BEFORE "" SEPARATOR ";" AFTER ";"�
			private final �getTypeOf(property)�
		�ENDFOR�
	'''

	def getTypeOf1(Property type) {
	
		switch type {
			case type.rent : return "int rent"
		}
	}
	def getTypeOf(Property type) '''
		�IF type.rent != null�int rent
		�ELSEIF type.name != null�String name
		�ELSEIF type.color != null�String color
		�ELSEIF type.price != null�int price
		�ELSEIF type.soldStatus != null�boolean sold
		�ELSEIF type.action != null�String action
		�ELSEIF type.position != null�int position
		�ELSEIF type.type != null��typeClass� type
		�ENDIF�
	'''

	def getOnlyTypeOf(Property type) '''
		�IF type.rent != null�int
		�ELSEIF type.name != null�String
		�ELSEIF type.position != null�int
		�ELSEIF type.type != null��typeClass�
		�ELSEIF type.color != null�String
		�ELSEIF type.price != null�int
		�ELSEIF type.soldStatus != null�boolean
		�ELSEIF type.action != null�String
		�ENDIF�
	'''
	
	def getPropertyNameOf(Property type) '''
		�IF type.rent != null�rent
		�ELSEIF type.name != null�name
		�ELSEIF type.color != null�color
		�ELSEIF type.price != null�price
		�ELSEIF type.soldStatus != null�sold
		�ELSEIF type.action != null�action
		�ELSEIF type.position != null�position
		�ELSEIF type.type != null�type
		�ENDIF�
	'''

	def createPackage() '''
		package de.�gameName�.�gameType�;
	'''

	def createImportOf(String classToImport) '''
		import de.�gameName�.�gameType�.�classToImport�;
	'''

}
