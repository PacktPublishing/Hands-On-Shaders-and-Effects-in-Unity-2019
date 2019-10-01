Shader "Pack/TestShader"
{
	Properties
	{
		_MainColor("Main Color", Color) = (1, 0, 0, 1)
		_MainTexture("Main Texture", 2D) = "white"{}
		_Interpolation("Interpolation", Range(0, 1)) = 0
		_Noise("Perlin Noise", 2D) = "white"{}
	}
		SubShader
	{
		Pass
		{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag

		fixed4 _MainColor;
		sampler2D _MainTexture;
		float _Interpolation;
		sampler2D _Noise;

		struct appdata
		{
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2f
		{
			float4 vertex : SV_POSITION;
			float2 uv : TEXCOORD0;
		};

		v2f vert(appdata v)
		{
			v2f o;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uv = v.uv;
			return o;
		}

		fixed4 frag(v2f i) : SV_Target
		{
			fixed4 col = tex2D(_MainTexture, i.uv);
			fixed4 noise = tex2D(_Noise, i.uv);
			col = lerp(col, lerp(_MainColor, col, noise), step(noise, _Interpolation));
			return col;
		}

		ENDCG
		}
	}
}
