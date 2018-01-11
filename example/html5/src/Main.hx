package;

import haxe.ui.diff.Diff.*;
import haxe.ui.diff.*;
import haxe.ui.components.*;
import haxe.ui.containers.*;
import haxe.ui.core.*;
import haxe.ui.*;


class Main {
	static function main() {
		Toolkit.init();
		
		var vdom = h('vbox', {}, [
			h('button', {text: 'Button', onClick: function(event:MouseEvent) trace(event)}, []),
		]);
		
		var container = new Component();
		container.addComponent(createElement(vdom));
		Screen.instance.addComponent(container);
		
		var myComp = new MyComponent();
		var counter = 0;
		var timer = new haxe.Timer(1000);
		timer.run = function() {
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

