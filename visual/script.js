var userSize = 12;
var users = [];

function User(x, y) {
	this.x = x || 0;
	this.y = y || 0;
	users.push(this);
	this.coaches = [];
	this.isCoachedBy = [];
	this.infected = false;

	this.addStudent = function(student) {
		student.isCoachedBy.push(this);
		this.coaches.push(student);
	}

	this.draw = function() {
		var guy;
		ctx.fillStyle = "black";
		for (var i=0, n=this.coaches.length; i<n; i++) {
			guy = this.coaches[i];
			drawLineArrow(this.x + userSize/2, this.y + userSize/2, guy.x, guy.y);
		}

		ctx.fillStyle = (this.infected ? "red" : "blue");
		ctx.fillRect(this.x, this.y, userSize, userSize);
	}

	this.infect = function () {
		this.infected = true;
	}
}

var canvas, ctx, interval, width, height;

function init() {
	canvas = document.getElementById('c');
	canvas.width = width = document.body.clientWidth;
	canvas.height = height = document.body.clientHeight;

	if (canvas.getContext) {
		canvas.addEventListener('click', handleClick, false);
		ctx = canvas.getContext('2d');
		interval = setInterval(step, (1/30.0));

		u = new User(100, 100);
		u2 = new User(200, 200);
		u.addStudent(u2);

		generate();
	}
}

function generate() {
	var minClassSize = 4;
	var maxClassSize = 16;
	var minIterations = 4;
	var maxIterations = 20;

	var t = new User(0, 0);
	for (var i=0, n=randomBetween(minClassSize, maxClassSize); i<n; i++) {
		var u = new User(randomBetween(0, 100), randomBetween(0, 100));
		t.addStudent(u);
	}
}

function randomBetween(min, max) {
	return Math.floor(Math.random()*(max - min + 1) + min);
}

function step() {
	draw();
}

function draw() {
	ctx.clearRect(0,0,width,height);

	// draw users
	for (var i=0,n=users.length; i<n; i++)
		users[i].draw();
}

function handleClick(event) {
	console.log(event.x + " " + event.y);
	var u;
	for (var i=0,n=users.length; i<n; i++) {
		u = users[i];
		if (collisionRect(u, event.x, event.y, 100, 100)) {
			u.infect();
		}
	}
}

window.addEventListener('load', init, false);

//checks for a collision with an instance in a rectangle
function collisionRect(inst1, x, y, w, h)
{
	w = w || 1;
	h = h || 1;
	return ((inst1.x+inst1.width >= x) && (inst1.x <= x + w) && (inst1.y+inst1.height >= y) && (inst1.y <= y + h))
};

// helper drawing functions
// Source: http://deepliquid.com/blog/archives/98
var arrow = [
    [ 2, 0 ],
    [ -10, -5 ],
    [ -10, 5]
];
function drawLineArrow(x1,y1,x2,y2) {
    ctx.beginPath();
    ctx.moveTo(x1,y1);
    ctx.lineTo(x2,y2);
    ctx.stroke();
    var ang = Math.atan2(y2-y1,x2-x1);
    drawFilledPolygon(translateShape(rotateShape(arrow,ang),x2,y2));
};

function rotateShape(shape,ang) {
    var rv = [];
    for(p in shape)
        rv.push(rotatePoint(ang,shape[p][0],shape[p][1]));
    return rv;
};
function rotatePoint(ang,x,y) {
    return [
        (x * Math.cos(ang)) - (y * Math.sin(ang)),
        (x * Math.sin(ang)) + (y * Math.cos(ang))
    ];
};

function translateShape(shape,x,y) {
    var rv = [];
    for(p in shape)
        rv.push([ shape[p][0] + x, shape[p][1] + y ]);
    return rv;
};

function drawFilledPolygon(shape) {
    ctx.beginPath();
    ctx.moveTo(shape[0][0],shape[0][1]);

    for(p in shape)
        if (p > 0) ctx.lineTo(shape[p][0],shape[p][1]);

    ctx.lineTo(shape[0][0],shape[0][1]);
    ctx.fill();
};