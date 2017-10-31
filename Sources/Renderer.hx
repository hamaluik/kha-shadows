import kha.graphics4.Usage;
import kha.graphics4.Graphics;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexStructure;
import kha.graphics4.VertexData;
import kha.Shaders;
import kha.graphics4.VertexBuffer;
import kha.graphics4.IndexBuffer;
import kha.graphics4.ConstantLocation;
import kha.math.FastMatrix4;
import kha.math.FastVector3;
import kha.Color;

class Renderer {
    var pipeline:PipelineState;

    var mvpLocation:ConstantLocation;
    var mLocation:ConstantLocation;
    var albedoColourLocation:ConstantLocation;
    var ambientColourLocation:ConstantLocation;

    var viewMatrix:FastMatrix4 = FastMatrix4.identity();
    var projectionMatrix:FastMatrix4 = FastMatrix4.identity();
    var modelMatrix:FastMatrix4 = FastMatrix4.identity();

    var object:Mesh;

    @:allow(Main)
    var angle:Float = 0;

    var lights:Array<Light> = [
        new PointLight(0, new FastVector3(0.25, 0, 0.5), Color.White, 1)
    ];

    public function new() {
        pipeline = new PipelineState();

        var structure = new VertexStructure();
        structure.add("position", VertexData.Float3);
        structure.add("normal", VertexData.Float3);
        pipeline.inputLayout = [structure];

        pipeline.vertexShader = Shaders.mesh_vert;
        pipeline.fragmentShader = Shaders.mesh_frag;

        pipeline.compile();

        mvpLocation = pipeline.getConstantLocation("MVP");
        mLocation = pipeline.getConstantLocation("M");
        albedoColourLocation = pipeline.getConstantLocation("albedoColour");
        ambientColourLocation = pipeline.getConstantLocation("ambientColour");

        for(light in lights) light.initialize(pipeline);

        projectionMatrix = FastMatrix4.perspectiveProjection(0.5033799409866333, 1024/768, 0.1, 100);
        viewMatrix = FastMatrix4.lookAt(
            new FastVector3(1.6241856, -1.0735209, 1.0743349),
            new FastVector3(0, 0, 0),
            new FastVector3(0, 0, 1)
        );

        object = Mesh.pyramid(structure);
    }

    public function render(g:Graphics):Void {
        g.begin();
        g.clear(Color.Black, 0);

        modelMatrix = FastMatrix4.rotationZ(angle);
        var mvp:FastMatrix4 = projectionMatrix.multmat(viewMatrix.multmat(modelMatrix));

        g.setPipeline(pipeline);

        g.setMatrix(mvpLocation, mvp);
        g.setMatrix(mLocation, modelMatrix);

        g.setFloat3(albedoColourLocation, 0.8, 0.8, 0.8);
        g.setFloat3(ambientColourLocation, 0.0761854, 0.0886556, 0.1070231);

        for(light in lights) light.bind(g);

        g.setVertexBuffer(object.vertexBuffer);
        g.setIndexBuffer(object.indexBuffer);
        g.drawIndexedVertices();

        g.end();
    }
}