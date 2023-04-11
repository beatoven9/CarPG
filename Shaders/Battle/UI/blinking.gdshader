shader_type canvas_item;

uniform bool critical = false;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (critical) {
		COLOR.b = 0.0;
	} else {
		COLOR.b = 1.0;
	}
	//COLOR.a = sin(TIME * 20.0) - .25;
	float current_val = sin(TIME * 10.0);
	if (current_val < -0.5) {
		COLOR.a = 0.0;
	} else {
		
	}
}
