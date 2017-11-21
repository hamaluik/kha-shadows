package types;
import glm.GLM;
import glm.Mat4;
import glm.Quat;
import glm.Vec3;

class Transform {
    public var pos:Vec3;
    public var rot:Quat;
    public var sca:Vec3;
    public var model(default, null):Mat4;
    public var dirty:Bool;

    public function new() {
        pos = new Vec3();
        rot = Quat.identity(new Quat());
        sca = new Vec3(1, 1, 1);
        model = new Mat4();
        dirty = true;
    }

    public function calculateModel():Void {
        if(!dirty) return;
        model = GLM.transform(
            pos,
            rot,
            sca,
            model
        );
        dirty = false;
    }
}