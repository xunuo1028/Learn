// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CookbookShaders/SelfSpriteShader"
 {  
     Properties
     {
         [PerRendererData]_MainTex ("Sprite Texture", 2D) = "white" {}
        _Color ("Alpha Color Key", Color) = (0,0,0,1)
        _Range("Range",Range (0,1.01))=0.1
        [MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
        _ScrollXSpeed("X Scroll Speed", Range(0, 10)) = 2
        _ScrollYSpeed("Y Scroll Speed", Range(0, 10)) = 2
        _MainTint("Diffuse Tint", Color) = (1, 1, 1, 1)
        _NoiseTex("Noise Texture", 2D) = "white" {}
        _NoiseValue("Noise Value", Range(0, 1)) = 0.5
     }
     SubShader
     {
         Tags 
         { 
             "Queue"="Transparent" 
         	"IgnoreProjector"="True" 
         	"RenderType"="Transparent" 
         	"PreviewType"="Plane"
         	"CanUseSpriteAtlas"="True"
         }

         Pass
         {
              Cull Off
              Lighting Off
              ZWrite Off
              Fog { Mode Off }
              Blend SrcAlpha OneMinusSrcAlpha


             CGPROGRAM
             #pragma vertex vert
             #pragma fragment frag
             #pragma multi_compile DUMMY PIXELSNAP_ON

             sampler2D _MainTex;
             float4 _Color;
             half _Range;
             fixed _ScrollXSpeed;
             fixed _ScrollYSpeed;
             float4 _MainTint;
             sampler2D _NoiseTex;
             half _NoiseValue;

             struct Vertex
             {
                 float4 vertex : POSITION;
                 float2 uv_MainTex : TEXCOORD0;
                 float2 uv2 : TEXCOORD1;
             };

             struct Fragment
             {
                 float4 vertex : POSITION;
                 float2 uv_MainTex : TEXCOORD0;
                 float2 uv2 : TEXCOORD1;
             };

             Fragment vert(Vertex v)
             {
                 Fragment o;

                 o.vertex = UnityObjectToClipPos(v.vertex);
                 o.uv_MainTex = v.uv_MainTex;
                 o.uv2 = v.uv2;

                 return o;
             }

             float4 frag(Fragment IN) : Color
             {
				fixed2 scrolledUV = IN.uv_MainTex;

				fixed xScrollValue = _ScrollXSpeed * _Time;
				fixed yScrollValue = _ScrollYSpeed;

				scrolledUV += fixed2(xScrollValue, yScrollValue);

				half4 c = tex2D(_MainTex, scrolledUV);

				float4 o = float4(1, 1, 1, 1);
				o.rgb = c.rgb * _MainTint;
				o.a = c.a;

				return o;
             }

             ENDCG
         }
     }
 }