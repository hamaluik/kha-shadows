import kha.System;
import kha.Framebuffer;

class Main {
    static var renderer:Renderer;

    public static function main() {
        System.init({ title: "Kha Shadows", width: 640, height: 480 }, function() {
            renderer = new Renderer();
            System.notifyOnRender(render);
        });
    }

    static function render(fb:Framebuffer):Void {
        renderer.render(fb.g4);
    }
}