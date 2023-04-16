shader_type canvas_item;

uniform bool critical = false;
uniform bool healing = false;

uniform vec4 healing_color = vec4(0.0, 0.8, 0.8, 1.0);

void fragment() {
	COLOR = texture(TEXTURE, UV);

	if (healing) {
		COLOR.rgb = healing_color.rgb;
	} 
	/*else if (critical) {
		COLOR.b = 0.0;
	} else {
		COLOR.b = 1.0;
	}*/
	
	
	float current_val = sin(TIME * 10.0);
	if (current_val < -0.5) {
		COLOR.a = 0.0;
	} else {
		
	}
}
