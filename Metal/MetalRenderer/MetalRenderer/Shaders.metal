//
//  Shaders.metal
//  MetalRenderer
//
//  Created by Mustafa Bekirov on 14.09.2023.
//

#include <metal_stdlib>
using namespace metal;

constant float4 position[6] = {
    float4(-0.5, -0.2, 0, 1),
    float4(0.2, -0.2, 0, 1),
    float4(0, 0.5, 0, 1),
    float4(0, 0.5, 0, 1),
    float4(0.2, -0.2, 0, 1),
    float4(0.7, 0.7, 0, 1),
};

constant float3 color[6] = {
    float3(1, 0, 0),
    float3(0, 1, 0),
    float3(0, 0, 1),
    float3(0, 0, 1),
    float3(0, 1, 0),
    float3(1, 0, 1),
};

struct VertexOut {
    float4 position [[position]];
    float point_size [[point_size]];
    float3 color;
};

vertex VertexOut vertex_main(uint vertexId [[vertex_id]]) {
    
    VertexOut out {
        .position = position[vertexId],
        .color = color[vertexId],
        .point_size = 60
    };
    return out;
}

fragment float4 fragment_main(VertexOut in [[stage_in]]) {
    return float4(in.color, 1);
}
