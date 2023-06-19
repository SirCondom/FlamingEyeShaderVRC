// Made with Amplify Shader Editor v1.9.1.5
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SirHoly/Eye effects/Flaming Eyes"
{
	Properties
	{
		_Tex("Tex", 2D) = "white" {}
		_Size("Size", Range( 0 , 10)) = 1
		_Flametext2("Flame text 2", 2D) = "white" {}
		_Eye2("Eye 2", 2D) = "white" {}
		[HDR]_Color0("Color 0", Color) = (1,1,1,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Tex;
		uniform sampler2D _Eye2;
		uniform float4 _Eye2_ST;
		uniform sampler2D _Flametext2;
		uniform float4 _Flametext2_ST;
		uniform float _Size;
		uniform float4 _Color0;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 uv_Eye2 = i.uv_texcoord * _Eye2_ST.xy + _Eye2_ST.zw;
			float4 tex2DNode48 = tex2D( _Eye2, uv_Eye2 );
			float2 uv_Flametext2 = i.uv_texcoord * _Flametext2_ST.xy + _Flametext2_ST.zw;
			float4 tex2DNode54 = tex2D( _Flametext2, uv_Flametext2 );
			float4 temp_output_56_0 = ( ( float4( i.uv_texcoord, 0.0 , 0.0 ) * tex2DNode48 ) + ( float4( uv_Flametext2, 0.0 , 0.0 ) * tex2DNode54 ) );
			float2 temp_output_4_0_g4 = (( temp_output_56_0.rg / _Size )).xy;
			float2 temp_output_17_0_g4 = float2( 1,1 );
			float mulTime22_g4 = _Time.y * 0.2;
			float temp_output_27_0_g4 = frac( mulTime22_g4 );
			float2 temp_output_11_0_g4 = ( temp_output_4_0_g4 + ( -(temp_output_56_0.rg*2.0 + -1.0) * temp_output_17_0_g4 * temp_output_27_0_g4 ) );
			float2 temp_output_12_0_g4 = ( temp_output_4_0_g4 + ( -(temp_output_56_0.rg*2.0 + -1.0) * temp_output_17_0_g4 * frac( ( mulTime22_g4 + 0.5 ) ) ) );
			float4 lerpResult9_g4 = lerp( tex2D( _Tex, temp_output_11_0_g4 ) , tex2D( _Tex, temp_output_12_0_g4 ) , ( abs( ( temp_output_27_0_g4 - 0.5 ) ) / 0.5 ));
			float2 temp_output_4_0_g2 = (( uv_Eye2 / _Size )).xy;
			float2 temp_output_17_0_g2 = float2( 0,0 );
			float mulTime22_g2 = _Time.y * 0.89;
			float temp_output_27_0_g2 = frac( mulTime22_g2 );
			float2 temp_output_11_0_g2 = ( temp_output_4_0_g2 + ( -(( float4( uv_Eye2, 0.0 , 0.0 ) * tex2D( _Eye2, uv_Eye2 ) ).rg*2.0 + -1.0) * temp_output_17_0_g2 * temp_output_27_0_g2 ) );
			float2 temp_output_12_0_g2 = ( temp_output_4_0_g2 + ( -(( float4( uv_Eye2, 0.0 , 0.0 ) * tex2D( _Eye2, uv_Eye2 ) ).rg*2.0 + -1.0) * temp_output_17_0_g2 * frac( ( mulTime22_g2 + 0.5 ) ) ) );
			float4 lerpResult9_g2 = lerp( tex2D( _Eye2, temp_output_11_0_g2 ) , tex2D( _Eye2, temp_output_12_0_g2 ) , ( abs( ( temp_output_27_0_g2 - 0.5 ) ) / 0.5 ));
			float4 temp_output_20_0 = lerpResult9_g2;
			float2 temp_output_4_0_g5 = (( uv_Flametext2 / _Size )).xy;
			float4 tex2DNode1 = tex2D( _Flametext2, uv_Flametext2 );
			float2 temp_cast_9 = (tex2DNode1.a).xx;
			float2 temp_output_17_0_g5 = temp_cast_9;
			float mulTime22_g5 = _Time.y * 0.89;
			float temp_output_27_0_g5 = frac( mulTime22_g5 );
			float2 temp_output_11_0_g5 = ( temp_output_4_0_g5 + ( -(temp_output_20_0.rg*2.0 + -1.0) * temp_output_17_0_g5 * temp_output_27_0_g5 ) );
			float2 temp_output_12_0_g5 = ( temp_output_4_0_g5 + ( -(temp_output_20_0.rg*2.0 + -1.0) * temp_output_17_0_g5 * frac( ( mulTime22_g5 + 0.5 ) ) ) );
			float4 lerpResult9_g5 = lerp( tex2D( _Flametext2, temp_output_11_0_g5 ) , tex2D( _Flametext2, temp_output_12_0_g5 ) , ( abs( ( temp_output_27_0_g5 - 0.5 ) ) / 0.5 ));
			float4 weightedBlendVar43 = saturate( temp_output_20_0 );
			float4 weightedBlend43 = ( weightedBlendVar43.x*saturate( lerpResult9_g5 ) + weightedBlendVar43.y*float4( 0,0,0,0 ) + weightedBlendVar43.z*float4( 0,0,0,0 ) + weightedBlendVar43.w*float4( 0,0,0,0 ) );
			float4 eye57 = weightedBlend43;
			float4 blendOpSrc58 = lerpResult9_g4;
			float4 blendOpDest58 = eye57;
			float4 fire62 = ( saturate( ( blendOpDest58 / max(blendOpSrc58,0.00001) ) ));
			float4 blendOpSrc81 = fire62;
			float4 blendOpDest81 = eye57;
			float4 lerpBlendMode81 = lerp(blendOpDest81, (( blendOpSrc81 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpSrc81 - 0.5 ) ) * ( 1.0 - blendOpDest81 ) ) : ( 2.0 * blendOpSrc81 * blendOpDest81 ) ),_Color0.a);
			o.Emission = saturate( ( ( saturate( lerpBlendMode81 )) * _Color0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19105
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;134.4279,19.12757;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;SirHoly/Eye effects/Flaming Eyes;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;2;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.SaturateNode;45;-157.2917,185.6324;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;46;-2260.682,2586.219;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;52;-1952.301,1827.068;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-2127.587,2149.931;Inherit;True;Property;_TextureSample6;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;235afdfab60665b47bc87f7bf820360c;c1be1a1f6ed25da4982f2df73f67b7fa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-1667.059,2177.828;Inherit;True;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-2642.547,800.1014;Inherit;True;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;16;-2935.914,868.4261;Inherit;True;Property;_TextureSample4;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;c1be1a1f6ed25da4982f2df73f67b7fa;c1be1a1f6ed25da4982f2df73f67b7fa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;20;-2372.301,802.4352;Inherit;True;Flow;0;;2;acad10cc8145e1f4eb8042bebe2d9a42;2,50,0,51,0;6;5;SAMPLER2D;;False;2;FLOAT2;0,0;False;55;FLOAT;1;False;18;FLOAT2;0,0;False;17;FLOAT2;0,0;False;24;FLOAT;0.89;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-2837.675,580.6694;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-2247.697,159.8374;Inherit;True;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-2628.914,276.7704;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;c1be1a1f6ed25da4982f2df73f67b7fa;c1be1a1f6ed25da4982f2df73f67b7fa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-2453.627,-46.09237;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;23;-1830.51,468.3568;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;57;-1299.01,363.9848;Inherit;False;eye;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-1406.587,2499.589;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-1043.913,2250.362;Inherit;False;57;eye;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-2065.554,2805.651;Inherit;True;2;2;0;FLOAT2;0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;48;-2358.921,2873.976;Inherit;True;Property;_TextureSample5;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;c1be1a1f6ed25da4982f2df73f67b7fa;c1be1a1f6ed25da4982f2df73f67b7fa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-1792.871,2495.9;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;59;-1110.016,2470.702;Inherit;True;Flow;0;;4;acad10cc8145e1f4eb8042bebe2d9a42;2,50,0,51,0;6;5;SAMPLER2D;;False;2;FLOAT2;0,0;False;55;FLOAT;1;False;18;FLOAT2;0,0;False;17;FLOAT2;1,1;False;24;FLOAT;0.2;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;-2957.824,233.0775;Inherit;True;Property;_Flametext2;Flame text 2;3;0;Create;True;0;0;0;False;0;False;b9bdb7f8ea48fc243a07b25d3e03a2ff;b9bdb7f8ea48fc243a07b25d3e03a2ff;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SaturateNode;25;-2023.266,575.4715;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-380.5062,2281.431;Inherit;False;fire;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;43;-1691.352,295.2495;Inherit;True;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;12;-2182.206,395.7935;Inherit;False;Flow;0;;5;acad10cc8145e1f4eb8042bebe2d9a42;2,50,0,51,0;6;5;SAMPLER2D;;False;2;FLOAT2;0,0;False;55;FLOAT;1;False;18;FLOAT2;0,0;False;17;FLOAT2;0.1,0;False;24;FLOAT;0.89;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;58;-757.4478,2351.742;Inherit;True;Divide;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;44;-861.7149,802.7839;Inherit;False;Property;_Color0;Color 0;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-415.126,676.9109;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;82;-130.4753,558.7041;Inherit;False;62;fire;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;83;-156.4753,738.7041;Inherit;False;57;eye;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;81;67.02063,638.9361;Inherit;True;HardLight;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;15;-3398.009,779.8516;Inherit;True;Property;_Eye2;Eye 2;4;0;Create;True;0;0;0;False;0;False;c1be1a1f6ed25da4982f2df73f67b7fa;c1be1a1f6ed25da4982f2df73f67b7fa;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
WireConnection;0;2;45;0
WireConnection;45;0;41;0
WireConnection;52;2;3;0
WireConnection;54;0;3;0
WireConnection;53;0;52;0
WireConnection;53;1;54;0
WireConnection;14;0;13;0
WireConnection;14;1;16;0
WireConnection;16;0;15;0
WireConnection;20;5;15;0
WireConnection;20;2;13;0
WireConnection;20;18;14;0
WireConnection;13;2;15;0
WireConnection;6;0;4;0
WireConnection;6;1;1;0
WireConnection;1;0;3;0
WireConnection;4;2;3;0
WireConnection;23;0;12;0
WireConnection;57;0;43;0
WireConnection;56;0;47;0
WireConnection;56;1;53;0
WireConnection;47;0;46;0
WireConnection;47;1;48;0
WireConnection;48;0;15;0
WireConnection;61;0;54;4
WireConnection;61;1;48;4
WireConnection;59;2;56;0
WireConnection;59;18;56;0
WireConnection;25;0;20;0
WireConnection;62;0;58;0
WireConnection;43;0;25;0
WireConnection;43;1;23;0
WireConnection;12;5;3;0
WireConnection;12;2;4;0
WireConnection;12;18;20;0
WireConnection;12;17;1;4
WireConnection;58;0;59;0
WireConnection;58;1;60;0
WireConnection;41;0;81;0
WireConnection;41;1;44;0
WireConnection;81;0;82;0
WireConnection;81;1;83;0
WireConnection;81;2;44;4
ASEEND*/
//CHKSM=FE34F3DFB90367B8BB6033BFEE90AAC7B0DDF7F7