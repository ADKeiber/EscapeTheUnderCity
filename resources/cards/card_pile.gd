## Card Pile class that holds and modifies 
## different "STacks" or collections of cards
##
class_name CardPile
extends Resource

## updates the size of the card pile
##
signal card_pile_size_changed(cards_amount)

## Data that holds the cards in the pile
##
@export var cards: Array[Card] = []

## Checks if the card is empty
##
func empty() -> bool:
	return cards.is_empty()

## Pops a card from the front of the pile and updates the size
##
func draw_card() -> Card:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	return card

## Appends a card to the end of the pile and updates the size 
##
func add_card(card: Card):
	cards.append(card)
	card_pile_size_changed.emit(cards.size())

## Shuffles the deck
func shuffle() -> void:
	cards.shuffle()

## Empties the deck and sets size to 0
##
func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())

## Creates a string for the card thats unique and recognizable
##
func _to_string() -> String: 
	var _card_strings: PackedStringArray = []
	for i in range(cards.size()):
		_card_strings.append("%s: %s" % [i+1, cards[i].id])
	return "\n".join(_card_strings)
