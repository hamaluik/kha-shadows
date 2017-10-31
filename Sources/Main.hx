import kha.Scheduler;
import kha.System;
import kha.Framebuffer;
import kha.Color;

class Main {
    static var renderer:Renderer;

    public static function main() {
        System.init({ title: "Kha Shadows", width: 1024, height: 768 }, function() {
            renderer = new Renderer();

            System.notifyOnRender(render);
            Scheduler.addTimeTask(update, 0, 1 / 60);
        });
    }

    static function update():Void {
        renderer.angle += (1/60) * Math.PI / 4;
    }

    static function render(fb:Framebuffer):Void {
        renderer.render(fb.g4);
    }
}