package haxe.ui.diff;

import haxe.DynamicAccess;
import haxe.ui.core.*;
import haxe.ui.components.*;
import haxe.ui.containers.*;

typedef Props = DynamicAccess<Dynamic>;

class Diff {
	public static inline function h(type:String, props, children):Node {
		return Node(type, props, children);
	}
	
	public static function createElement(node:Node) {
		
		return switch node {
			case Widget(widget):
				widget.initComponent();
			case Node(type, props, children):
				var element:Component = switch ComponentClassMap.get(type) {
					case null: throw 'Unknown element "${type}"';
					case className: Type.createInstance(Type.resolveClass(className), []);
				}
				
				setProps(element, props);
				for(child in children) element.addComponent(createElement(child));
				
				element;
		}
		
	}
	
	public static function updateElement(parent:Component, newNode:Node, oldNode:Node, index = 0) {
		
		if(parent == null) return;
		
		if(oldNode == null) {
			switch newNode {
				case null: // do nothing
				case node: 
					var el = createElement(newNode);
					parent.addComponent(el);
					parent.setComponentIndex(el, index);
			}
			
		} else if(newNode == null) {
			
			parent.removeComponent(parent.getComponentAt(index));
			
		} else if(changed(newNode, oldNode)) {
			
			parent.removeComponent(parent.getComponentAt(index));
			var el = createElement(newNode);
			parent.addComponent(el);
			parent.setComponentIndex(el, index);
			
		} else {
			
			switch [newNode, oldNode] {
				case [Node(_, p1, c1), Node(_, p2, c2)]:
					updateProps(parent.getComponentAt(index), p1, p2);
					var newLength = c1.length;
					var oldLength = c2.length;
					var i = 0;
					while(i < newLength || i < oldLength) {
						updateElement(parent.getComponentAt(index), c1[i], c2[i], i);
						i++;
					}
				case _:
			}
		}
	}
	
	static inline function changed(node1:Node, node2:Node) {
		return switch [node1, node2] {
			case [Node(t1, _, _), Node(t2, _, _)]: t1 != t2;
			case [Widget(w1), Widget(w2)]: w1 != w2;
			case _: true;
		}
	}
	
	static inline function setProp(element:Component, name:String, value:Dynamic)
		Reflect.setProperty(element, name, value);
	
	static function setProps(element:Component, props:Props) {
		for(key in props.keys()) setProp(element, key, props.get(key));
	}
	
	static inline function removeProp(element:Component, name:String)
		setProp(element, name, null);
		
	static function updateProp(element:Component, name:String, newVal:Dynamic, oldVal:Dynamic) {
		if(newVal == null) {
			removeProp(element, name);
		} else if(oldVal == null || newVal != oldVal) {
			setProp(element, name, newVal);
		}
	}
	
	static function updateProps(element:Component, newProps:Props, oldProps:Props) {
		var keys = new Map();
		for(key in newProps.keys()) keys.set(key, true);
		for(key in oldProps.keys()) keys.set(key, true);
		for(key in keys.keys()) updateProp(element, key, newProps.get(key), oldProps.get(key));
		
	}
}