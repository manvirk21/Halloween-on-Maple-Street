extends RichTextLabel


func _ready():
	Signals.connect("updatescore", updatescore)
	
func updatescore(score):
	self.text = str(score)

