package types;

import kha.System;
import glm.GLM;
import glm.Mat4;
import glm.Vec3;

class Camera {
    public var view:Mat4;
    public var projection:Mat4;
    public var viewProjection:Mat4;

    public function new() {
        // TODO: don't use hard-coded values
        projection = GLM.perspective(
            Math.PI / 3,
            System.windowWidth() / System.windowHeight(),
            0.1, 100, new Mat4()
        );
        view = GLM.lookAt(
            new Vec3(10, 10, 10),
            new Vec3(0, 0, 0),
            new Vec3(0, 1, 0),
            new Mat4()
        );

        viewProjection = Mat4.multMat(view, projection, new Mat4());
    }
}