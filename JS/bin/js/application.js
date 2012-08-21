function MyCompound(){
	console.log("MyCompound constructed");
	//addBehaviour("test", MyBehaviour);
	//register(MyView);
}

MyCompound.extends(Compound);

function MyView(){
	console.log("MyView constructed");
}

MyView.extends(View);

function MyBehaviour(){
	console.log("MyBehaviour constructed");
}

MyBehaviour.extends(Behaviour);