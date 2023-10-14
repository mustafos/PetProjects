//
//  Shaders.metal
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 14.09.2023.
//

#include <metal_stdlib>
#import "Common.h"
using namespace metal;

constant float3 lightPosition = float3(2.0, 1.0, 0);
constant float3 ambientLightColor = float3(1.0, 1.0, 1.0);
constant float ambientLightIntensity = 0.3;
constant float3 lightSpecularColor = float3(1.0, 1.0, 1.0);


constant float3 color[6] = {
    float3(1, 0, 0),
    float3(0, 1, 0),
    float3(0, 0, 1),
    float3(0, 0, 1),
    float3(0, 1, 0),
    float3(1, 0, 1)
};

struct VertexOut {
    float4 position [[position]];
    float3 color;
    float3 worldNormal;
    float3 worldPosition;
    float2 uv;
};

struct VertexIn {
    float4 position [[attribute(0)]];
    float3 normal [[attribute(1)]];
    float2 uv [[attribute(2)]];
};

vertex VertexOut vertex_main(VertexIn vertexBuffer [[stage_in]],
                             constant Uniforms &uniforms [[buffer(21)]]) {
    VertexOut out {
        .position = uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * vertexBuffer.position,
        .worldNormal = (uniforms.modelMatrix * float4(vertexBuffer.normal, 0)).xyz,
        .worldPosition = (uniforms.modelMatrix * vertexBuffer.position).xyz,
        .uv = vertexBuffer.uv
    };
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]],
                              constant Material &material [[buffer(11)]],
                              constant FragmentUniforms &fragmentUniforms [[buffer(22)]]) {
    
    float3 lightVector = normalize(lightPosition);
    float3 normalVector = normalize(in.worldNormal);
    
    float materialShininess = material.shininess;
    float3 materialSpecularColor = material.specularColor;
    
    float3 baseColor = material.baseColor;
    
    float diffuseIntensity = saturate(dot(lightVector, normalVector));
    
    float3 diffuseColor = baseColor * diffuseIntensity;
    float3 ambientColor = baseColor * ambientLightColor * ambientLightIntensity;
    
    float3 reflection = reflect(lightVector, normalVector);
    float3 cameraVector = normalize(in.worldPosition - fragmentUniforms.cameraPosition);
    float specularIntensity = pow(saturate(dot(reflection, cameraVector)), materialShininess);
    float3 specularColor = lightSpecularColor * materialSpecularColor * specularIntensity;
    float3 color = diffuseColor + ambientColor + specularColor;
    return float4(color, 1);
}
