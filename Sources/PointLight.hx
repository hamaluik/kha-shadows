import kha.graphics4.PipelineState;
import kha.graphics4.ConstantLocation;
import kha.graphics4.Graphics;
import kha.math.FastVector3;
import kha.Color;

class PointLight implements Light {
    private var index:Int;
    
    public var position:FastVector3;
    public var colour:Color;
    public var distance:Float;

    private var pLoc:ConstantLocation;
    private var cLoc:ConstantLocation;
    private var dLoc:ConstantLocation;

    public function new(index:Int, position:FastVector3, colour:Color, distance:Float) {
        this.index = index;
        this.position = position;
        this.colour = colour;
        this.distance = distance;
    }

    public function initialize(pipeline:PipelineState):Void {
        pLoc = pipeline.getConstantLocation('pointLights[${index}].position');
        cLoc = pipeline.getConstantLocation('pointLights[${index}].colour');
        dLoc = pipeline.getConstantLocation('pointLights[${index}].distance');
    }

    public function bind(g:Graphics):Void {
        g.setVector3(pLoc, position);
        g.setFloat3(cLoc, colour.R, colour.G, colour.B);
        g.setFloat(dLoc, distance);
    }
}