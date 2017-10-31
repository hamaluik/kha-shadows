import kha.graphics4.PipelineState;
import kha.graphics4.ConstantLocation;
import kha.graphics4.Graphics;
import kha.math.FastVector3;
import kha.Color;

class DirectionalLight implements Light {
    private var index:Int;
    
    public var direction:FastVector3;
    public var colour:Color;

    private var dLoc:ConstantLocation;
    private var cLoc:ConstantLocation;

    public function new(index:Int, direction:FastVector3, colour:Color) {
        this.index = index;
        this.direction = direction;
        this.colour = colour;
    }

    public function initialize(pipeline:PipelineState):Void {
        dLoc = pipeline.getConstantLocation('directionalLights[${index}].direction');
        cLoc = pipeline.getConstantLocation('directionalLights[${index}].colour');
    }

    public function bind(g:Graphics):Void {
        g.setVector3(dLoc, direction);
        g.setFloat3(cLoc, colour.R, colour.G, colour.B);
    }
}