import types.Mesh;
import types.Camera;
import types.Material;
import types.Renderable;
import kha.Color;
import kha.graphics4.Graphics;
import glm.Mat4;

class Renderer {
    var camera:Camera;
    var meshPlane:Mesh;
    var matPlain:Material;

    var plane:Renderable;

    var mvp:Mat4;

    public function new() {
        camera = new Camera();
        meshPlane = Mesh.plane();
        matPlain = Material.plain();

        plane = new Renderable(meshPlane, matPlain);

        mvp = new Mat4();
    }

    public function render(g:Graphics):Void {
        g.begin();
        g.clear(Color.Black, 1);

        /// render the plane first
        // calculate the matrices
        plane.transform.calculateModel();
        mvp = Mat4.multMat(camera.viewProjection, plane.transform.model, mvp);

        // setup the GL state
        g.setPipeline(plane.material.pipeline);
        plane.material.setProperty("MVP", Matrix4(mvp));
        plane.material.setProperty("M", Matrix4(plane.transform.model));
        plane.material.bindUniforms(g);

        // draw!
        g.setVertexBuffer(plane.mesh.vertexBuffer);
        g.setIndexBuffer(plane.mesh.indexBuffer);
        g.drawIndexedVertices();
    }
}