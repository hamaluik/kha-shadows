import kha.graphics4.VertexBuffer;
import kha.graphics4.IndexBuffer;
import kha.graphics4.VertexStructure;
import kha.graphics4.Usage;

class Mesh {
    public var vertexBuffer:VertexBuffer;
    public var indexBuffer:IndexBuffer;

    public function new(vertices:Array<Float>, vertexStructure:VertexStructure, indices:Array<Int>) {
        vertexBuffer = new VertexBuffer(
            Std.int(vertices.length / 6),
            vertexStructure,
            Usage.StaticUsage
        );
        var vbData = vertexBuffer.lock();
        for(i in 0...vbData.length) vbData.set(i, vertices[i]);
        vertexBuffer.unlock();

		indexBuffer = new IndexBuffer(
			indices.length,
			Usage.StaticUsage
		);
		var iData = indexBuffer.lock();
		for (i in 0...iData.length) iData[i] = indices[i];
        indexBuffer.unlock();
    }

    public static function pyramid(structure:VertexStructure):Mesh {
        var vertices:Array<Float> = [
            0.000000, -0.500000, 0.000000, -0.774597, -0.447214, 0.447214,
            0.000000, 0.000000, 0.500000, -0.774597, -0.447214, 0.447214,
            -0.433013, 0.250000, 0.000000, -0.774597, -0.447214, 0.447214,
            -0.433013, 0.250000, 0.000000, 0.000000, 0.894427, 0.447214,
            0.000000, 0.000000, 0.500000, 0.000000, 0.894427, 0.447214,
            0.433013, 0.250000, 0.000000, 0.000000, 0.894427, 0.447214,
            0.433013, 0.250000, 0.000000, 0.774597, -0.447214, 0.447214,
            0.000000, 0.000000, 0.500000, 0.774597, -0.447214, 0.447214,
            0.000000, -0.500000, 0.000000, 0.774597, -0.447214, 0.447214,
            0.000000, -0.500000, 0.000000, -0.000000, -0.000000, -1.000000,
            -0.433013, 0.250000, 0.000000, -0.000000, -0.000000, -1.000000,
            0.433013, 0.250000, 0.000000, -0.000000, -0.000000, -1.000000,
        ];

        var indices:Array<Int> = [
            0, 1, 2,
            3, 4, 5,
            6, 7, 8,
            9, 10, 11,
        ];

        return new Mesh(vertices, structure, indices);
    }

    public static function plane(structure:VertexStructure, size:Float):Mesh {
        var hs:Float = size / 2;
        var vertices:Array<Float> = [
            -hs, -hs, 0,
             hs, -hs, 0,
            -hs,  hs, 0,
             hs,  hs, 0
        ];

        var indices:Array<Int> = [
            0, 2, 1,
            2, 3, 1
        ];

        return new Mesh(vertices, structure, indices);
    }
}