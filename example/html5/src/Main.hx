package;

#if haxeui_hxwidgets
import hx.widgets.*;
#end
import haxe.ui.diff.Diff.*;
import haxe.ui.diff.*;
import haxe.ui.components.*;
import haxe.ui.containers.*;
import haxe.ui.core.*;
import haxe.ui.*;


class Main {
	static function main() {
		#if haxeui_hxwidgets
			var app = new App();
			app.init();
			
			var frame = new Frame(null, "My App");
			frame.resize(800, 600);
		#end
		
		Toolkit.init({
			#if haxeui_hxwidgets
				frame: frame,
			#end
		});
		trace('inited');
		
		var vdom = h('vbox', {}, [
			h('button', {text: 'Button', onClick: function(event:MouseEvent) trace(event)}, []),
		]);
		
		var container = new Component();
		container.addComponent(createElement(vdom));
		Screen.instance.addComponent(container);
		
		var myComp = new MyComponent();
		var counter = 0;
		function interval() {
			var newDom = h('vbox', {}, [
				h('button', {text: 'Button ' + ++counter, onClick: function(event:MouseEvent) trace(event)}, []),
				Widget(myComp),
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
		
		#if haxeui_hxwidgets
		var timer = new Timer(frame, 1000);
		frame.bind(EventType.TIMER, function(_) interval());
		#else
		var timer = new haxe.Timer(1000);
		timer.run = inverval;
		#end
		
		#if haxeui_hxwidgets
			frame.show();
			app.run();
			app.exit();
		#end

	}
	
	
}

class MyComponent extends Button implements Widget {
	public function new() {
		super();
		this.text = 'CustomButton';
	}
	
	public function initComponent() {
		return this;
	}
}

