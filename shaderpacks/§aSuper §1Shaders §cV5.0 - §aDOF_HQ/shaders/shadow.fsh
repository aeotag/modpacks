#version 120

/*
Read Mine and Chocapic13's terms of mofification/sharing before changing something below please!
ﯼᵵᴀᵶᵶᴬﺤ super Shaders (ﯼ✗∃), derived from Chocapic13 v4 Beta 4.8
Place two leading Slashes in front of the following '#define' lines in order to disable an option.
*/

varying vec4 texcoord;

varying vec4 color;
varying vec3 normal;
varying vec3 rawNormal;

uniform sampler2D tex;
varying float materialIDs;
varying float iswater;

//////////////////////////////VOID MAIN//////////////////////////////
//////////////////////////////VOID MAIN//////////////////////////////
//////////////////////////////VOID MAIN//////////////////////////////
//////////////////////////////VOID MAIN//////////////////////////////
//////////////////////////////VOID MAIN//////////////////////////////

void main() {

vec4 tex = texture2D(tex, texcoord.st, 0) * color;

	if (iswater > 0.5)
	{
		vec4 albedo = tex;
		float lum = albedo.r + albedo.g + albedo.b;
			  lum /= 3.0f;

			  lum = pow(lum, 1.0f) * 1.0f;
			  lum += 0.0f;

		vec3 waterColor = color.rgb;

		waterColor = normalize(waterColor);

		tex = vec4(0.1f, 0.7f, 1.0f, 210.0f/255.0f);
		tex.rgb *= 0.4f * waterColor.rgb;
		tex.rgb *= vec3(lum);

		// tex = vec4(color.r, color.g, color.b, 0.4f);
		// tex.rgb *= vec3(0.9f, 1.0f, 0.1f) * 0.8f;
	}
	
	float NdotL = pow(max(0.0f, mix(dot(normal.rgb, vec3(0.0f, 0.0f, 1.0f)), 1.0f, 0.0f)), 1.0f / 2.2f);
	vec3 shadowNormal = normal.xyz;

	bool isTranslucent = abs(materialIDs - 3.0f) < 0.1f
					  //|| abs(materialIDs - 2.0f) < 0.1f
					  || abs(materialIDs - 4.0f) < 0.1f
					  //|| abs(materialIDs - 11.0f) < 0.1f
					  ;

	if (isTranslucent)
	{
		shadowNormal = vec3(0.0f, 0.0f, 0.0f);
		NdotL = 1.0f;
	}
	
	bool isGlassFix = abs(materialIDs - 89114.0f) < 0.1f;

if (isGlassFix)
{
discard;
}

bool isFireFix = abs(materialIDs - 89224.0f) < 0.1f;

if (isFireFix)
{
discard;
}
	
	
	gl_FragData[0] = vec4(tex.rgb, tex.a);
}