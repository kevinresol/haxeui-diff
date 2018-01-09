package;


import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Assets;

import haxe.ui.diff.Diff.*;
import haxe.ui.components.*;
import haxe.ui.containers.*;
import haxe.ui.core.*;
import haxe.ui.*;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		var bitmap = new Bitmap (Assets.getBitmapData ("assets/openfl.png"));
		addChild (bitmap);
		
		bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2;
		
		Toolkit.init();
		
		var vdom = h('vbox', {}, [
			h('button', {text: 'Button', onClick: function(event:MouseEvent) trace(event)}, []),
		]);
		
		var container = new Component();
		container.addComponent(createElement(vdom));
		Screen.instance.addComponent(container);
		
		var counter = 0;
		var timer = new haxe.Timer(1000);
		timer.run = function() {
			var newDom = h('vbox', {}, [
				h('button', {text: 'Button ' + counter++, onClick: function(event:MouseEvent) trace(event)}, []),
				counter % 2 == 1 ? h('button', {text: 'Button Extra'}, []) : null,
				h('grid', {columns: 2}, [
					h('vbox', {}, [h('label', {text: 'Label $counter'}, [])]),
					h('vbox', {}, [h('label', {text: 'Label $counter'}, [])]),
					h('vbox', {}, [h('label', {text: 'Label $counter'}, [])]),
					h('vbox', {}, [h('label', {text: 'Label $counter'}, [])]),
				]),
			]);
			updateElement(container, newDom, vdom);
			vdom = newDom;
		}
		
	}
	
	
}