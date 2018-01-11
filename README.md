# Haxe UI Diff

A proof-of-concept virtual DOM implementation for Haxe UI

## Examples

```haxe
static function main() {
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
			h('button', {text: 'Button ' + ++counter, onClick: function(event:MouseEvent) trace(event)}, []),
		]);
		updateElement(container, newDom, vdom);
		vdom = newDom;
	}
}

```

For more usage, see `example` folder