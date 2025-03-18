import keyboard
import pygame
import threading

# Definir las teclas a monitorear
MOD_KEYS = {
    "Shift": "shift",
    "Control": "ctrl",
    "Alt": "alt",
    "GUI": "win",
    "Super": "caps lock",
    "Hyper": "scroll lock",
}

# Configurar Pygame para mostrar indicadores en pantalla
pygame.init()
screen = pygame.display.set_mode((300, 100), pygame.NOFRAME)  # Ventana sin bordes
pygame.display.set_caption("OSM Indicators")

# Colores
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
GREEN = (0, 255, 0)

# Posiciones personalizadas de los indicadores
POSITIONS = {
    "Shift": (20, 20),
    "Control": (80, 20),
    "Alt": (140, 20),
    "GUI": (200, 20),
    "Super": (20, 60),
    "Hyper": (80, 60),
}

# Estados de las teclas
key_status = {key: False for key in MOD_KEYS}

def check_keys():
    """Monitorea el estado de las teclas en segundo plano."""
    global key_status
    while True:
        for key, code in MOD_KEYS.items():
            key_status[key] = keyboard.is_pressed(code)

# Hilo para monitorear teclas
key_thread = threading.Thread(target=check_keys, daemon=True)
key_thread.start()

# Bucle principal para mostrar indicadores
running = True
while running:
    screen.fill(BLACK)
    
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
    
    # Dibujar indicadores
    font = pygame.font.Font(None, 36)
    for key, pos in POSITIONS.items():
        color = GREEN if key_status[key] else WHITE
        text = font.render(key, True, color)
        screen.blit(text, pos)

    pygame.display.flip()

pygame.quit()


