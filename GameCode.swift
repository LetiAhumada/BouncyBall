import Foundation

let ball = OvalShape(width: 40, height: 40)
//barrier
let barrierWidth = 300.0
let barrierHeight = 25.0
let barrierPoints = [
    Point(x: 0, y: 0),
    Point(x: 0, y: barrierHeight),
    Point(x: barrierWidth, y:
       barrierHeight),
    Point(x: barrierWidth, y: 0)
]
let barrier = PolygonShape(points:
   barrierPoints)
//funnel
let funnelPoint = [
    Point(x: 0, y: 50),
        Point(x: 80, y: 50),
        Point(x: 60, y: 0),
        Point(x: 20, y: 0)
]
let funnel = PolygonShape(points: funnelPoint)
//target
let targetPoints = [
    Point(x: 10, y: 0),
    Point(x: 0, y: 10),
    Point(x: 10, y: 20),
    Point(x: 20, y: 10)
]
let target = PolygonShape(points: targetPoints)
func setupTarget() {
    target.position = Point(x: 200, y: 400)
    target.hasPhysics = true
    target.isImmobile = true
    target.isImpermeable = false
    target.fillColor = .red
    target.name = "target"
    
    scene.add(target)
}

/*
The setup() function is called once when the app launches. Without it, your app won't compile.
Use it to set up and start your app.

You can create as many other functions as you want, and declare variables and constants,
at the top level of the file (outside any function). You can't write any other kind of code,
for example if statements and for loops, at the top level; they have to be written inside
of a function.
*/

func setup() {
    ball.position = Point(x:250, y:400)
    ball.hasPhysics = true
    ball.isDraggable = false
    ball.fillColor = .yellow
    scene.add(ball)
    scene.trackShape(ball)
    ball.onExitedScene = ballExistedScene
    ball.onCollision = ballCollided(with:)
    ball.onTapped = resetGame
    //barrier code
    barrier.position = Point(x: 200, y: 150)
    barrier.hasPhysics = true
    barrier.isImmobile = true
    barrier.fillColor = .gray
    scene.add(barrier)
    //funnel code
    funnel.position = Point(x: 200, y:
    scene.height - 25)
    funnel.fillColor = .orange
    scene.add(funnel)
    funnel.onTapped = dropBall
    //target code
    setupTarget()
    //reset
    resetGame()
}

func dropBall() {
    ball.position = funnel.position
    ball.stopAllMotion()
    barrier.isDraggable = false
}

func ballCollided(with otherShape: Shape) {
    if otherShape.name != "target" { return }
    otherShape.fillColor = .yellow
}

func ballExistedScene() {
    barrier.isDraggable = true
}

func resetGame() {
    ball.position = Point(x: 0, y: -80)
}
