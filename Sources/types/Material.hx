package types;

import kha.Shaders;
import kha.Color;
import kha.graphics4.Graphics;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexStructure;
import kha.graphics4.VertexData;
import kha.graphics4.ConstantLocation;
import kha.graphics4.CullMode;
import kha.graphics4.CompareMode;
import haxe.ds.StringMap;
import glm.Mat4;
import glm.Vec3;

enum MaterialProperty {
    Matrix4(m:Mat4);
    Direction(d:Vec3);
    Colour3(c:Color);
    Colour4(c:Color);
}

typedef UniformProperty = {
    var location:ConstantLocation;
    var property:MaterialProperty;
}

class Material {
    public var pipeline:PipelineState;
    public var uniforms:StringMap<UniformProperty>;

    public function new(pipeline:PipelineState, uniformNames:Array<String>) {
        this.pipeline = pipeline;
        uniforms = new StringMap<UniformProperty>();
        for(name in uniformNames) {
            uniforms.set(name, {
                location: pipeline.getConstantLocation(name),
                property: null
            });
        }
    }

    public function bindUniforms(g:Graphics):Void {
        for(u in uniforms.iterator()) {
            if(u.property == null) continue;
            switch(u.property) {
                case Matrix4(m): g.setMatrix(u.location, m);
                case Direction(d): g.setVector3(u.location, d);
                case Colour3(c): g.setFloat3(u.location, c.R, c.G, c.B);
                case Colour4(c): g.setFloat4(u.location, c.R, c.G, c.B, c.A);
            }
        }
    }

    public function setProperty(name:String, prop:MaterialProperty):Void {
        if(!uniforms.exists(name)) return;
        uniforms.get(name).property = prop;
    }

    public static function plain():Material {
        var structure:VertexStructure = new VertexStructure();
        structure.add("position", VertexData.Float3);
        structure.add("normal", VertexData.Float3);

        var pipeline:PipelineState = new PipelineState();
        pipeline.inputLayout = [structure];
        pipeline.vertexShader = Shaders.mesh_vert;
        pipeline.fragmentShader = Shaders.mesh_frag;
        pipeline.cullMode = CullMode.None;
        pipeline.depthMode = CompareMode.Less;
        pipeline.depthWrite = true;
        pipeline.compile();

        var mat:Material = new Material(
            pipeline,
            ["MVP", "M", "lightDirection", "ambientColour", "albedoColour"]
        );
        mat.setProperty("lightDirection", Direction(new Vec3(0, 1, 0)));
        mat.setProperty("ambientColour", Colour3(Color.fromFloats(0.05, 0.05, 0.05)));
        mat.setProperty("albedoColour", Colour3(Color.White));
        return mat;
    }
}