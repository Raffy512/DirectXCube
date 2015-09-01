cbuffer PerApplication : register( b0 )
{
    matrix projectionMatrix;
}

cbuffer PerFrame : register( b1 )
{
    matrix viewMatrix;
}

cbuffer PerObject : register( b2 )
{
    matrix worldMatrix;
}

float3 LightPosition = float3(0.0f,0.0f, -10.0f);
float LightRange = 100;

struct AppData
{
    float3 position : POSITION;
    float3 color: COLOR;
    float3 normal :NORMAL;
};

struct VertexShaderOutput
{
    float4 color : COLOR;
    float4 position : SV_POSITION;
    float3 normal : NORMAL;
    float3 light     : TEXCOORD0;
};

VertexShaderOutput SimpleVertexShader( AppData IN )
{
    VertexShaderOutput OUT;

    float4 posWorld = mul(float4(IN.position, 1), worldMatrix);

    matrix mvp = mul( projectionMatrix, mul( viewMatrix, worldMatrix ) );
    OUT.position = mul( mvp, float4( IN.position, 1.0f ) );
    OUT.normal = mul(IN.normal, (float3x3)worldMatrix).xyz;
    OUT.light = LightPosition - posWorld.xyz;
    OUT.color = float4( IN.color, 0 );

    return OUT;
}