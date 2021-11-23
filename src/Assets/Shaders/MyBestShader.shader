Shader "Unlit/MyBestShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct Particle
            {
                float3 pos;
                float3 vel;
                float3 col;
            };

            struct appdata
            {
                float4 vertex : POSITION;
                //float2 uv : TEXCOORD0;
            };

            struct v2f
            {
               // float2 uv : TEXCOORD0;
               // UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float3 color: COLOR;
            };

            uniform StructuredBuffer<Particle>Particles;

           // sampler2D _MainTex;
            //float4 _MainTex_ST;

            v2f vert (uint id : SV_VertexID)
            {
                Particle p = Particles[id];
                v2f o;
                o.vertex = UnityObjectToClipPos(p.pos);
                o.color = p.col;
                //o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
               // fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
               // UNITY_APPLY_FOG(i.fogCoord, col);
                return fixed4(i.color.rgb,1);
            }
            ENDCG
        }
    }
}
