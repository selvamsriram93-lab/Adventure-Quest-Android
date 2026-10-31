extends Node2D

const SPEED = 380.0
const JUMP_FORCE = -650.0
const GRAVITY = 1500.0

var player_pos = Vector2(100, 560)
var velocity = Vector2.ZERO
var grounded = true
var score = 0

var coins = [
    Vector2(350, 570),
    Vector2(600, 570),
    Vector2(900, 570),
    Vector2(1100, 570)
]


func _process(delta):
    var direction = 0.0

    if Input.is_action_pressed("ui_left"):
        direction -= 1.0

    if Input.is_action_pressed("ui_right"):
        direction += 1.0

    velocity.x = direction * SPEED

    if Input.is_action_just_pressed("ui_accept") and grounded:
        velocity.y = JUMP_FORCE
        grounded = false

    velocity.y += GRAVITY * delta
    player_pos += velocity * delta

    if player_pos.y >= 560:
        player_pos.y = 560
        velocity.y = 0
        grounded = true

    player_pos.x = clampf(player_pos.x, 0, 1232)

    for i in range(coins.size() - 1, -1, -1):
        if player_pos.distance_to(coins[i]) < 55:
            coins.remove_at(i)
            score += 10

    queue_redraw()


func _draw():
    draw_rect(
        Rect2(0, 0, 1280, 720),
        Color("#79d7ff")
    )

    draw_circle(
        Vector2(1080, 100),
        55,
        Color("#fff18a")
    )

    draw_rect(
        Rect2(0, 620, 1280, 100),
        Color("#35b84a")
    )

    for coin in coins:
        draw_circle(coin, 17, Color("#ffca28"))
        draw_circle(coin, 8, Color("#fff18a"))

    draw_rect(
        Rect2(player_pos, Vector2(48, 60)),
        Color("#e94b55")
    )

    draw_circle(
        player_pos + Vector2(34, 18),
        5,
        Color.WHITE
    )

    draw_string(
        ThemeDB.fallback_font,
        Vector2(35, 50),
        "ADVENTURE QUEST",
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        30,
        Color.WHITE
    )

    draw_string(
        ThemeDB.fallback_font,
        Vector2(35, 90),
        "SCORE: " + str(score),
        HORIZONTAL_ALIGNMENT_LEFT,
        -1,
        24,
        Color.WHITE
    )
