//float lightRange = 100;

struct PixelShaderInput
{
  float4 position : SV_POSITION;
  float4 color : COLOR;
  float3 normal : NORMAL;
  float3 light     : TEXCOORD0;
};

float4 SimplePixelShader( PixelShaderInput IN ) : SV_TARGET
{   
    
    float lightRange = 50;
    float attenuation = saturate(1 - dot(IN.light / lightRange, IN.light / lightRange));
    
    float3 nL = normalize(IN.light);
    
    float3 nN = normalize(IN.normal);
    
    float3 diffuse = IN.color.rgb * dot(nL, nN) * attenuation;
    
    //float4 color = float4(diffuse, 0.0) * IN.color;

    return float4(diffuse, 1); 
}  