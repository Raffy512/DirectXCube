float3 LightPosition = float3(3, 0, 1);
float LightRange = 100;

struct PixelShaderInput
{
    float4 color : COLOR;
    float3 light     : TEXCOORD0;
    float3 normal    : NORMAL;
};

float4 SimplePixelShader( PixelShaderInput IN ) : SV_TARGET
{
    float attenuation = saturate(1 - dot(IN.light / LightRange, IN.light / LightRange));
    
    float3 Ln = normalize(IN.light);
    float3 Nn = normalize(IN.normal);
    
    float3 diffuse = float3(1,0,0) * dot(Ln, Nn) * attenuation;

    return float4( diffuse,1.0);
}