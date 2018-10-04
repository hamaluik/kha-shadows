package types;

import kha.graphics4.VertexBuffer;
import kha.graphics4.IndexBuffer;
import kha.graphics4.VertexStructure;
import kha.graphics4.VertexData;
import kha.graphics4.Usage;

class Mesh {
    public var structure:VertexStructure;
    public var vertexBuffer:VertexBuffer;
    public var indexBuffer:IndexBuffer;

    public function new(numVerts:Int, vertices:Array<Float>, vertexStructure:VertexStructure, indices:Array<Int>) {
        vertexBuffer = new VertexBuffer(
            numVerts,
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

    /**
      Plane facing up with unit side length
      @return Mesh
     */
    public static function plane():Mesh {
        var structure:VertexStructure = new VertexStructure();
        structure.add("position", VertexData.Float3);
        structure.add("normal", VertexData.Float3);

        var vertices:Array<Float> = [
        //    x   y    z   nx ny nz 
            -0.5, 0, -0.5,  0, 1, 0,
             0.5, 0, -0.5,  0, 1, 0,
             0.5, 0,  0.5,  0, 1, 0,
            -0.5, 0,  0.5,  0, 1, 0,
        ];

        var indices:Array<Int> = [
            0, 1, 2,
            2, 3, 0
        ];

        return new Mesh(4, vertices, structure, indices);
    }

    public static function screen():Mesh {
        var structure:VertexStructure = new VertexStructure();
        structure.add("position", VertexData.Float2);

        var vertices:Array<Float> = [
            -1, -1,
            -1,  1,
             1,  1,
             1, -1,
        ];
        var indices:Array<Int> = [
            0, 1, 2,
            2, 3, 0
        ];

        return new Mesh(4, vertices, structure, indices);
    }
}