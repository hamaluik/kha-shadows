import kha.graphics4.PipelineState;
import kha.graphics4.Graphics;

interface Light {
    public function initialize(pipeline:PipelineState):Void;
    public function bind(g:Graphics):Void;
}