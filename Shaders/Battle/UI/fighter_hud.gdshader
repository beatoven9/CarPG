shader_type canvas_item;

uniform bool selected = false;

void fragment() {
	COLOR = texture(TEXTURE, UV);

	//COLOR += clamp(sin(TIME * 10.0), 0, .2);
	if (selected == true){
		COLOR += clamp(sin(TIME * 10.0), 0, .2);
	}
}
