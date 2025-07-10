extends Node


# Aktiv-Status für Fähigkeiten (zur Laufzeit)
var is_bullet_time: bool = false
var is_time_stop: bool = false

# Freigeschaltete Fähigkeiten (kann z. B. beim Levelstart gesetzt werden)
var unlocked_skills := {
	"bullet_time": true,
	"time_stop": true,
}
