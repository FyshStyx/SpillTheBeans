extends Label


var total_score
var secret_url

# Called when the node enters the scene tree for the first time.
func _ready():
	total_score = 0
	set_text("Score: %s" % total_score)


func add_score():
	total_score += 1
	set_text("Score: %s" % total_score)


func push_online_highscores():
	$HTTPRequest.request(secret_url)

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
