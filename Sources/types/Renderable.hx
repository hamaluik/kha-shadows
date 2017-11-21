package types;

class Renderable {
    public var transform:Transform;
    public var mesh:Mesh;
    public var material:Material;

    public function new(mesh:Mesh, material:Material) {
        this.transform = new Transform();
        this.mesh = mesh;
        this.material = material;
    }
}