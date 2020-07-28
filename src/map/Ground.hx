package map;

import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2MassData;
import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2Shape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2Body;
import openfl.display.Sprite;
import js.lib.Math;

class Ground {

	/** Ground Types **/
	public static final WOOD: Int = 0;
	public static final ICE: Int = 1;
	public static final TRAMPOLINE: Int = 2;
	public static final LAVA: Int = 3;
	public static final CHOCOLATE: Int = 4;
	public static final EARTH: Int = 5;
	public static final GRASS: Int = 6;
	public static final SAND: Int = 7;
	public static final CLOUD: Int = 8;
	public static final WATER: Int = 9;
	public static final STONE: Int = 10;
	public static final SNOW: Int = 11;
	public static final RECTANGLE: Int = 12;
	public static final CIRCLE: Int = 13;
	public static final INVISIBLE: Int = 14;
	public static final WEB: Int = 15;
	public static final AUTUMN_GRASS: Int = 17; 
	public static final PINK_GRASS: Int = 18; 

	/** Collisions **/
	public static final ALL_OBJECTS = 1; // Collision with all objects
	public static final SHAMAN_OBJECTS = 2; // Collision with shaman objects
	public static final MICE = 3; // Collision with shaman and mice
	public static final NO_COLLISION = 4; // No collision

	public var type: Int;
	public var width: Int = 10;
	public var height: Int = 10;
	public var x: Float = 0;
	public var y: Float = 0;
	public var restitution: Float;
	public var friction: Float;
	public var linearDamping: Float = 0;
	public var angularDamping: Float = 0;
	public var rotation: Int;
	public var collision: Int = 1;
	public var vanish: Int = -1; // Vanish the object after n milliseconds
	public var luaID: Int = -1; // Object id in lua
	public var mass: Int = 0;
	public var groundImage: String = '';
	public var invisible: Bool = false;
	public var noSync: Bool = false;
	public var dynamicGround: Bool = false;
	public var fixedRotation: Bool = false;
	public var sprite: Sprite = new Sprite();
	public var physics: B2Body;

	public function new(type: Int, x: Float, y: Float, width: Int = 10, height: Int = 10) {
		this.type = type;
		this.width = Math.min(4000, Math.max(10, width));
		this.height = Math.min(4000, Math.max(10, height));
		this.sprite.addChild(MapCustomization.getGround(this.type, this.width, this.height));
		this.x = x;
		this.y = y;
		this.restitution = 0.2 + Math.random() * 1e-06;
		this.friction = 0.3 + Math.random() * 1e-06;
		this.rotation = 0;
		switch (this.type) {
			case 1:
				this.friction = 0;
				this.restitution = 0.2;
			case 2:
				this.friction = 0;
				this.restitution = 1.2;
			case 3:
				this.friction = 0;
				this.restitution = 20;
			case 4:
				this.friction = 20;
				this.restitution = 0.2;
			case 7:
				this.friction = 0.1;
				this.restitution = 0.2;
			case 10:
				this.friction = 0.3;
				this.restitution = 0;
			case 11:
				this.friction = 0.05;
				this.restitution = 0.1;
			case 0:
			case 5:
			case 6:
			case 12:
			case 13:
			case 14:
			case 16:
			case 17:
			case 18:
				this.friction = 0.3;
				this.restitution = 0.2;
			
				this.friction = 0.3;
				this.restitution = 0.2;
		}
		var bodyDefine: B2BodyDef = new B2BodyDef();
		var fixtureDefine: B2FixtureDef = new B2FixtureDef();
		fixtureDefine.friction = this.friction;
		fixtureDefine.restitution = this.restitution;
		bodyDefine.position.set(this.x / 30, this.x / 30);
		bodyDefine.angle = this.rotation;
		bodyDefine.fixedRotation = this.fixedRotation;
		bodyDefine.linearDamping = this.linearDamping;
		bodyDefine.angularDamping = this.angularDamping;
		bodyDefine.userData = this;
		var shape: B2PolygonShape = new B2PolygonShape();
		shape.setAsBox(this.width/2/30, this.height/2/30);
		fixtureDefine.shape = shape;
		this.physics = Transformice.instance.physicWorld.createBody(bodyDefine);
		if (this.dynamicGround) {
			bodyDefine.type = B2Body.b2_dynamicBody;
			var mass: B2MassData = new B2MassData();
			mass.mass = 0;
			this.physics.setMassData(mass);
		}
		this.physics.createFixture(fixtureDefine);
		Transformice.instance.physicWorld.drawDebugData();
		Transformice.instance.world.addChild(this.sprite);
	}
	
	public function get_x(): Float {
		return this.x;
	}
	
	public function set_x(value: Float): Float {
		this.x = this.sprite.x = value;
		if (this.physics.getPosition().x != (this.x / 30))
			this.physics.setPosition(new B2Vec2(this.x / 30, this.physics.getPosition().y));
		return value;
	}

	public function get_y(): Float {
		return this.y;
	}
	
	public function set_y(value: Float): Float {
		this.y = this.sprite.y = value;
		if (this.physics.getPosition().y != (this.y / 30))
			this.physics.setPosition(new B2Vec2(this.physics.getPosition().x, this.y / 30));
		return value;
	}
}