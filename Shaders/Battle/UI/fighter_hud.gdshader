shader_type canvas_item;

uniform bool selected = false;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (selected == true){
		COLOR.b = 1.0;
	}
}
