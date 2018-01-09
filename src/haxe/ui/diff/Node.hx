package haxe.ui.diff;

enum Node {
	Node(type:String, props:Dynamic, children:Array<Node>);
	Widget(inst:Widget);
}